
-- Modules --
import XMonad

import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Hooks.InsertPosition

import XMonad.Actions.CycleWS
import XMonad.Actions.DwmPromote

import XMonad.Layout.NoBorders
import XMonad.Layout.IM
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Reflect
import XMonad.Layout.ResizableTile
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances

import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Prompt.Workspace
import XMonad.Prompt.AppendFile

import XMonad.Util.NamedScratchpad
import XMonad.Util.Run

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

import System.Exit

main :: IO ()
main = myConfig >>= xmonad

myConfig = do
    return defaultConfig
        { terminal           = "urxvtc"
--      , startupHook        = setWMName "LG3D"
        , manageHook         = myManageHook
        , layoutHook         = myLayouts
        , workspaces         = myWorkspaces
        , keys               = myKeys
        , modMask            = mod4Mask
        , borderWidth        = 1
        , normalBorderColor  = black4
        , focusedBorderColor = orange }


myManageHook = (composeAll $ concat
    [ [resource  =? r --> doIgnore       | r <- myIgnores]
    , [className =? c --> doFloat        | c <- myFloats]
    , [className =? c --> doCenterFloat  | c <- myCFloats]
    , [isFullscreen   --> myDoFullFloat]
	, [manageDocks]
    ])

    where
    
        myIgnores = ["desktop", "desktop_window"]
        myFloats  = ["MPlayer", "VirtualBox", "Gimp"]
        myCFloats = ["Save As..."]

        myDoFullFloat :: ManageHook
        myDoFullFloat = doF W.focusDown <+> doFullFloat

-- Layouts --
myLayouts = smartBorders
            $ avoidStruts
            $ onWorkspace "gimp" gimp
            $ mkToggle (single NBFULL)
            $ tiled ||| Mirror tiled
    where
        tiled   = ResizableTall nmaster delta ratio []
        nmaster = 1 
        delta   = 1/20
        ratio   = 0.5   -- goldenRatio
        gimp    = withIM (0.11) (Role "gimp-toolbox")
                  $ reflectHoriz
                  $ withIM (0.15) (Role "gimp-dock") Full

-- Workspaces --
myWorkspaces :: [WorkspaceId]
myWorkspaces = ["one", "two", "three", "four"] ++ map show [5..9 :: Int]

-- Key bindings --
altMask = mod1Mask   -- Alt key
myKeys :: XConfig t -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((modm, xK_Return), spawn $ XMonad.terminal conf)
    , ((modm, xK_Escape), kill)
    , ((modm, xK_space), dwmpromote)
    , ((modm, xK_a), sendMessage Shrink)
    , ((modm, xK_s), sendMessage Expand)
    , ((modm, xK_r), sendMessage MirrorShrink)
    , ((modm, xK_w), sendMessage MirrorExpand)
    , ((modm, xK_b), sendMessage ToggleStruts)
    , ((modm, xK_f), sendMessage $ Toggle NBFULL)
    , ((modm, xK_t), withFocused $ windows . W.sink)
    , ((modm, xK_comma), sendMessage (IncMasterN 1))
    , ((modm, xK_period), sendMessage (IncMasterN (-1)))
    , ((modm .|. shiftMask, xK_q), io (exitWith ExitSuccess)) -- Exit xmonad
    , ((modm, xK_c), shellPrompt myXPConfig)
    , ((modm, xK_n), appendFilePrompt myXPConfig "/home/yoos/memo.txt")
    , ((modm, xK_q), spawn "xmonad --recompile; xmonad --restart")
    , ((modm, xK_x), spawn "killall xmobar && xmobar")
    , ((modm, xK_Left), spawn "mpc prev")
    , ((modm, xK_Right), spawn "mpc next")
    , ((modm, xK_k), spawn "setxkbmap us")
    , ((modm, xK_n), spawn "setxkbmap us -variant colemak; xmodmap /home/yoos/.Xmodmap")

    -- Backlight
    --, ((0, 0x1008FF07), spawn "/home/yoos/bin/backlight up")
    --, ((0, 0x1008FF08), spawn "/home/yoos/bin/backlight down")

    -- Volume
    , ((0, 0x1008FF11), spawn "amixer -q set Master 2-")
    , ((0, 0x1008FF12), spawn "amixer -q set Master toggle")
    , ((0, 0x1008FF13), spawn "amixer -q set Master 2+")

    -- Music
    , ((0, 0x1008FF14), spawn "ncmpcpp toggle")
    , ((0, 0x1008FF15), spawn "ncmpcpp stop")
    , ((0, 0x1008FF16), spawn "ncmpcpp prev")
    , ((0, 0x1008FF17), spawn "ncmpcpp next") ]

    ++

    [((modm, k), windows $ W.greedyView i) | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]]

    ++

    [((modm .|. altMask, k), (windows $ W.shift i) >> (windows $ W.greedyView i) >> (windows $ W.swapDown))
    | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]]

-- Prompt --
myXPConfig :: XPConfig
myXPConfig = defaultXPConfig
    { font          = myFont
    , bgColor       = black
    , fgColor       = white
    , bgHLight      = black1
    , fgHLight      = orange
    , borderColor   = black
    , position      = Top
    , height        = 16 }

-- Colors --
orange = "#ebac54"
white  = "#ffffff"
black  = "#000000"
black1 = "#1f1f1f"
black2 = "#1c1c1c"
black3 = "#2c2c2c"
black4 = "#3f3f3f"
grey1  = "#4f4f4f"
grey2  = "#7f7f7f"



-- Definitions --
myFont = "-*-proggycleanszcp-medium-r-normal-*-13-80-96-96-c-70-iso8859-1"
goldenRatio = toRational $ 2/(1 + sqrt 5 :: Double)

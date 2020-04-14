
-- Modules --
import XMonad

import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.EwmhDesktops  (fullscreenEventHook)

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
main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ docks defaultConfig   -- docks for upstream issue xmonad/xmonad#79
        { terminal           = "urxvtc"
        , startupHook        = setWMName "LG3D"   -- Hack for Java
        , manageHook         = myManageHook
        , layoutHook         = myLayouts
        , logHook            = myLogHook xmproc
        , handleEventHook    = fullscreenEventHook   -- Fix chrome fullscreen
        , workspaces         = myWorkspaces
        , keys               = myKeys
        , modMask            = mod4Mask
        , borderWidth        = 2
        , normalBorderColor  = black1
        , focusedBorderColor = yellow }


myManageHook = (composeAll $ concat
    [ [resource  =? r --> doIgnore       | r <- myIgnores]
    , [className =? c --> doFloat        | c <- myFloats]
    , [className =? c --> doCenterFloat  | c <- myCFloats]
    , [isFullscreen   --> myDoFullFloat]
    , [manageDocks]
    ])

    where

        myIgnores = ["desktop", "desktop_window"]
        myFloats  = ["MPlayer", "VirtualBox", "Gimp", "rdesktop"]
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

myLogHook x = dynamicLogWithPP xmobarPP
                  { ppOutput = hPutStrLn x
                  , ppTitle  = xmobarColor "white" "" . shorten 60   -- Put first 60 characters of window title in title area.
                  }


-- Workspaces --
myWorkspaces :: [WorkspaceId]
--myWorkspaces = ["one", "two", "three", "four"] ++ map show [5..9 :: Int]
myWorkspaces = map show [1..9 :: Int]

-- Key bindings --
altMask = mod1Mask   -- Alt key
myKeys :: XConfig t -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((modm, xK_Return), spawn $ XMonad.terminal conf)
    , ((modm, xK_Escape), kill)
    , ((modm, xK_space), dwmpromote)
    , ((modm .|. shiftMask, xK_space), sendMessage NextLayout) -- Rotate through workspace layouts
    , ((modm, xK_a), sendMessage Shrink)
    , ((modm, xK_s), sendMessage Expand)
    , ((modm, xK_r), sendMessage MirrorShrink)
    , ((modm, xK_w), sendMessage MirrorExpand)
    , ((modm, xK_b), sendMessage ToggleStruts)
    , ((modm, xK_f), sendMessage $ Toggle NBFULL)
    , ((modm, xK_t), withFocused $ windows . W.sink)
    , ((modm, xK_comma), sendMessage (IncMasterN 1))
    , ((modm, xK_period), sendMessage (IncMasterN (-1)))
    , ((modm,               xK_Tab), windows W.focusDown)   -- Move focus to next window
    , ((modm .|. shiftMask, xK_Tab), windows W.focusUp)     -- Move focus to previous window
    , ((modm,               xK_m),   windows W.focusMaster) -- Move focus to master
    , ((modm .|. shiftMask .|. altMask, xK_q), io (exitWith ExitSuccess)) -- Exit xmonad
    , ((modm, xK_c), shellPrompt myXPConfig)
    --, ((modm, xK_n), appendFilePrompt myXPConfig "/home/syoo/memo.txt")
    , ((modm, xK_q), spawn "xmonad --recompile; xmonad --restart")
    , ((modm, xK_k), spawn "setxkbmap us")
    , ((modm, xK_n), spawn "setxkbmap us -variant colemak; xmodmap /home/yoos/.Xmodmap") ]

    ++
    -- Volume
    [ ((0, 0x1008FF11), spawn "amixer -q -c 0 set PCM 2-")
    , ((0, 0x1008FF12), spawn "amixer -q -c 0 set PCM toggle")
    , ((0, 0x1008FF13), spawn "amixer -q -c 0 set PCM 2+") ]

    ++
    -- Switch to workspace N with mod-N
    [((modm, k), windows $ W.view i) | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]]

    ++
    -- "Load" workspace N with mod-shift-N
    [((modm .|. shiftMask, k), windows $ W.greedyView i) | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]]

    ++
    -- Move window to workspace n with mod-alt-N
    [((modm .|. altMask, k), (windows $ W.shift i) >> (windows $ W.greedyView i) >> (windows $ W.swapDown))
    | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]]

-- Prompt --
myXPConfig :: XPConfig
myXPConfig = defaultXPConfig
    { font          = myFont
    , bgColor       = black
    , fgColor       = white
    , bgHLight      = black1
    , fgHLight      = yellow
    , borderColor   = black
    , position      = Top
    , height        = 32 }

-- Colors --
green  = "#33ff33"
orange = "#ebac54"
yellow = "#ffff33"
white  = "#ffffff"
black  = "#000000"
black1 = "#1f1f1f"
black2 = "#1c1c1c"
black3 = "#2c2c2c"
black4 = "#3f3f3f"
grey1  = "#4f4f4f"
grey2  = "#7f7f7f"



-- Definitions --
myFont = "xft:Inconsolata:size=12:antialias=true"
goldenRatio = toRational $ 2/(1 + sqrt 5 :: Double)

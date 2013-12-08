import System.IO
import System.Exit
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Layout.ToggleLayouts

import XMonad.Hooks.FadeInactive
import qualified XMonad.StackSet as W
import qualified Data.Map as M

startup :: X ()
startup = do
           spawn "sh ~/.xmonad/autostart.sh"

myWorkspaces = [ "♥", "♦", "♠", "♣"] ++ map show [5..9]


-- Mouse Settings
mouseModMask = mod1Mask

myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList
    -- mod-button1 %! Set the window to floating mode and move by dragging
    [ ((mouseModMask, button1), \w -> focus w >> mouseMoveWindow w
                                          >> windows W.shiftMaster)
    -- mod-button2 %! Raise the window to the top of the stack
    , ((mouseModMask, button2), windows . (W.shiftMaster .) . W.focusWindow)
    -- mod-button3 %! Set the window to floating mode and resize by dragging
    , ((mouseModMask, button3), \w -> focus w >> mouseResizeWindow w
                                         >> windows W.shiftMaster)
    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

keyModMask = mod4Mask


normalLayout = spacing 9 $ Tall 2 (7/12) (7/12)
myLayout = toggleLayouts Full (normalLayout ||| Mirror normalLayout)


main = do
    xmproc <- spawnPipe "xmobar"
    xmonad myConfig
        { logHook            = dynamicLogWithPP $ xmobarPP
                               { ppOutput = hPutStrLn xmproc
                               , ppCurrent  = xmobarColor "red" "" .wrap " " ""
                               , ppHidden  = xmobarColor "#D0D0D0" "" .wrap " " ""
                               , ppTitle = xmobarColor "#9B3453" "" . shorten 80
                               }

        }

myConfig = defaultConfig
        { manageHook         = manageDocks <+> manageHook defaultConfig
        , layoutHook         = avoidStruts $ myLayout
        , workspaces         = myWorkspaces
        , terminal           = "xfce4-terminal"
        , borderWidth        = 6
        , normalBorderColor  = "#303030"
        , focusedBorderColor = "#9B3453"
        , modMask            = mod4Mask
        , focusFollowsMouse  = False
        , startupHook        = startup
        , mouseBindings      = myMouseBindings
        }
        `removeKeys`
        [ (keyModMask              , xK_q)
        , (keyModMask .|. shiftMask, xK_q)
        ]
        `additionalKeys`
        [ ((keyModMask, xK_w), kill) -- close window
        , ((keyModMask .|. shiftMask, xK_r), io (exitWith ExitSuccess))
        , ((keyModMask, xK_r     ), spawn "if type xmonad; then xmonad --recompile && xmonad --restart; else xmessage xmonad not in \\$PATH: \"$PATH\"; fi")
        , ((keyModMask, xK_f), sendMessage ToggleLayout)
        ]

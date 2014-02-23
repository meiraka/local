import System.IO
import System.Exit
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig
import XMonad.Util.Scratchpad
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Layout.ToggleLayouts
import XMonad.Layout.Grid
import XMonad.Actions.GridSelect

import XMonad.Hooks.FadeInactive
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import qualified Data.List

startup :: X ()
startup = do
           spawn "sh ~/.xmonad/autostart.sh"

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad myConfig
        { logHook            = do fadeInactiveLogHook fadeAmount
                                  dynamicLogWithPP $ xmobarPP { ppOutput = hPutStrLn xmproc
                                                              , ppCurrent  = xmobarColor "red" "" .wrap " " ""
                                                              , ppHidden  = xmobarColor "#c0c0c0" "" .wrap " " "" .noScratchPad
                                                              , ppTitle = xmobarColor "#c0c0c0" "" . shorten 80
                                                              }

        }

        where
          noScratchPad ws = if ws == "NSP" then "" else ws
          fadeAmount = 0.7

myConfig = defaultConfig
        { manageHook         = myManageHook
        , layoutHook         = avoidStruts $ myLayout
        , workspaces         = myWorkspaces
        , terminal           = myTerminal
        , borderWidth        = 6
        , normalBorderColor  = "#202020"
        , focusedBorderColor = "#ffe6f1"
        , focusFollowsMouse  = False
        , startupHook        = startup
        , keys               = myKeys
        , mouseBindings      = myMouseBindings
        }

myWorkspaces = [ "♥", "♦", "♠", "♣"] ++ map show [5..9]

myManageHook = composeAll([className =? "Xfce4-notifyd" --> doIgnore]) <+>
               manageDocks <+>
               scratchpadManageHook (W.RationalRect (1/20) (1/20) (18/20) (18/20)) <+>
               manageHook defaultConfig

myLayout     = toggleLayouts fullLayout (normalLayout ||| Mirror normalLayout)
normalLayout = spacing 9 $ Grid
fullLayout   = noBorders Full

-- scratchpad for quake style terminal using sakura.
myTerminal = "sakura"
scratchPad = scratchpadSpawnActionCustom "sakura --name scratchpad"

-- Keyboard Settings
keyModMask = mod4Mask

myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    -- launching and killing programs
    [ ((keyModMask .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf) -- %! Launch terminal
    , ((keyModMask,               xK_r     ), spawn "gmrun") -- %! Launch gmrun
    , ((keyModMask,               xK_w     ), kill) -- %! Close the focused window
    , ((keyModMask,               xK_a     ), sendMessage NextLayout) -- %! Rotate through the available layout algorithms
    , ((keyModMask,               xK_f     ), sendMessage ToggleLayout) -- %! Toggle fullscreen mode
    , ((keyModMask,               xK_space ), scratchPad) -- %! Toggle terminal
    , ((keyModMask,               xK_n     ), refresh) -- %! Resize viewed windows to the correct size
    , ((keyModMask,               xK_g     ), goToSelected defaultGSConfig)    

    -- move focus up or down the window stack
    , ((keyModMask,               xK_Tab   ), windows W.focusDown) -- %! Move focus to the next window
    , ((keyModMask .|. shiftMask, xK_Tab   ), windows W.focusUp  ) -- %! Move focus to the previous window
    , ((keyModMask,               xK_j     ), windows W.focusDown) -- %! Move focus to the next window
    , ((keyModMask,               xK_k     ), windows W.focusUp  ) -- %! Move focus to the previous window
    , ((keyModMask,               xK_m     ), windows W.focusMaster  ) -- %! Move focus to the master window

    -- modifying the window order
    , ((keyModMask,               xK_Return), windows W.swapMaster) -- %! Swap the focused window and the master window
    , ((keyModMask .|. shiftMask, xK_j     ), windows W.swapDown  ) -- %! Swap the focused window with the next window
    , ((keyModMask .|. shiftMask, xK_k     ), windows W.swapUp    ) -- %! Swap the focused window with the previous window

    -- resizing the master/slave ratio
    , ((keyModMask,               xK_h     ), sendMessage Shrink) -- %! Shrink the master area
    , ((keyModMask,               xK_l     ), sendMessage Expand) -- %! Expand the master area

    -- floating layer support
    , ((keyModMask,               xK_t     ), withFocused $ windows . W.sink) -- %! Push window back into tiling

    -- increase or decrease number of windows in the master area
    , ((keyModMask              , xK_comma ), sendMessage (IncMasterN 1)) -- %! Increment the number of windows in the master area
    , ((keyModMask              , xK_period), sendMessage (IncMasterN (-1))) -- %! Deincrement the number of windows in the master area

    -- quit, or restart
    , ((keyModMask .|. shiftMask, xK_q     ), io (exitWith ExitSuccess)) -- %! Quit xmonad
    , ((keyModMask .|. shiftMask, xK_r     ), spawn "if type xmonad; then xmonad --recompile && xmonad --restart; else xmessage xmonad not in \\$PATH: \"$PATH\"; fi") -- %! Restart xmonad

    ]
    ++
    -- mod-[1..9] %! Switch to workspace N
    -- mod-shift-[1..9] %! Move client to workspace N
    [((m .|. keyModMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]



-- Mouse Settings
mouseModMask = mod1Mask

myMouseBindings (XConfig {XMonad.modMask = keyModMask}) = M.fromList
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



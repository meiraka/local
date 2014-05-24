from lib import *

status = {"default": {"type": "plain"
                     ,"bg": 8
                     ,"fg": 232}
         ,"left": [{"type": "plain"
                   ,"text": "[#F] #I #S #T"
                   ,"bg": 160
                   ,"fg": 232}
                  ,{"type": "shell"
                   ,"text": "whoami"
                   ,"bg": 160
                   ,"fg": 232}
                  ,{"type": "shell"
                   ,"text": "hostname"
                   ,"bg": 160
                   ,"fg": 232}
                  ,{"type": "shell"
                   ,"text": "uptime"
                   ,"bg": 88
                   ,"fg": 232}
                   ]
         ,"right": [{"type": "func"
                    ,"text": mpd
                    ,"bg": 124
                    ,"fg": 232}
                   ,{"type": "shell"
                    ,"text": "date +%Y%m%d"
                    ,"bg": 88
                    ,"fg": 232}
                  ]
         }

data = {"status": status}

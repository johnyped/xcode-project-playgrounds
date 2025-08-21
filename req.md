### create localize generator using swift 

### Environment Condition:
- call run shell script then call swift script file
- all realted function should be in LocalizeDecoder.swift
- only use native apple framwork library
- user need to paste json file in same directory as script file with name "variables.json"

### Generator localize workflow step
1. decode json file into struct 
2. generate Localized.swift files
3. generate xcode localized file (localized.xcstring)

## Step 1: Decoder step: 
1. read json file
2. user can config expected reading file at path for "variables.json"
3. extract available language keys
4. extract LocalizedKeyPaths as in the example
5. print result to match the example

# json structure of variable.json
```
{
  "@localized": {
    "$collection_metadata": {
      "name": "Localized",
      "figmaId": "VariableCollectionId:807:35695",
      "modes": [
        {
          "key": "en",
          "name": "EN"
        },
        {
          "key": "th",
          "name": "TH"
        },
        {
          "key": "my",
          "name": "MY"
        }
      ]
    },
    "$tv_navigation_drawer": {
      "switch_profile": {
        "$type": "unknown",
        "$value": "Switch Profile",
        "$description": "",
        "$variable_metadata": {
          "name": "tv_navigation_drawer/switch_profile",
          "figmaId": "VariableID:7353:158449",
          "modes": {
            "en": "Switch Profile",
            "th": "สลับโปรไฟล์",
            "my": "ပရိုဖိုင်ပြောင်းရန်"
          }
        }
      },
      "search_menu": {
        "$type": "unknown",
        "$value": "Search",
        "$description": "",
        "$variable_metadata": {
          "name": "tv_navigation_drawer/search_menu",
          "figmaId": "VariableID:7353:158450",
          "modes": {
            "en": "Search",
            "th": "ค้นหา",
            "my": "ရှာဖွေရန်"
          }
        }
      },
      "home_menu": {
        "$type": "unknown",
        "$value": "Home",
        "$description": "",
        "$variable_metadata": {
          "name": "tv_navigation_drawer/home_menu",
          "figmaId": "VariableID:7353:158451",
          "modes": {
            "en": "Home",
            "th": "หน้าหลัก",
            "my": "မူလစာမျက်နှာ"
          }
        }
      },
      "live_tv_menu": {
        "$type": "unknown",
        "$value": "Live TV",
        "$description": "",
        "$variable_metadata": {
          "name": "tv_navigation_drawer/live_tv_menu",
          "figmaId": "VariableID:7353:158452",
          "modes": {
            "en": "Live TV",
            "th": "ทีวีออนไลน์",
            "my": "တိုက်ရိုက်ထုတ်လွှင့်တီဗီ"
          }
        }
      },
      "movies_menu": {
        "$type": "unknown",
        "$value": "Movies",
        "$description": "",
        "$variable_metadata": {
          "name": "tv_navigation_drawer/movies_menu",
          "figmaId": "VariableID:8131:11277",
          "modes": {
            "en": "Movies",
            "th": "ภาพยนตร์",
            "my": "ရုပ်ရှင်များ"
          }
        }
      },
      "series_menu": {
        "$type": "unknown",
        "$value": "Series",
        "$description": "",
        "$variable_metadata": {
          "name": "tv_navigation_drawer/series_menu",
          "figmaId": "VariableID:8131:11278",
          "modes": {
            "en": "Series",
            "th": "ซีรีส์",
            "my": "စီးရီးများ"
          }
        }
      },
      "sports_menu": {
        "$type": "unknown",
        "$value": "Sports",
        "$description": "",
        "$variable_metadata": {
          "name": "tv_navigation_drawer/sports_menu",
          "figmaId": "VariableID:8131:11279",
          "modes": {
            "en": "Sports",
            "th": "กีฬา",
            "my": "အားကစားများ"
          }
        }
      },
      "new_on_now_menu": {
        "$type": "unknown",
        "$value": "New on NOW",
        "$description": "",
        "$variable_metadata": {
          "name": "tv_navigation_drawer/new_on_now_menu",
          "figmaId": "VariableID:7353:158453",
          "modes": {
            "en": "New on NOW",
            "th": "ใหม่บน NOW",
            "my": "အသစ်ဆုံး"
          }
        }
      },
      "my_lists_menu": {
        "$type": "unknown",
        "$value": "My Lists",
        "$description": "",
        "$variable_metadata": {
          "name": "tv_navigation_drawer/my_lists_menu",
          "figmaId": "VariableID:7353:158455",
          "modes": {
            "en": "My Lists",
            "th": "รายการของฉัน",
            "my": "ကျွန်ုပ်၏စာရင်းများ"
          }
        }
      }
    },
    "$tv_homepage": {
      "premium_tv": {
        "$type": "unknown",
        "$value": "Subscribe to TrueVisions Now to enjoy this content",
        "$description": "",
        "$variable_metadata": {
          "name": "tv_homepage/premium_tv",
          "figmaId": "VariableID:8177:37425",
          "modes": {
            "en": "Subscribe to TrueVisions Now to enjoy this content",
            "th": "สมัครสมาชิกทรูวิชั่นส์ตอนนี้ เพื่อรับชมคอนเทนต์นี้",
            "my": "ဤအကြောင်းအရာကိုကြည့်ရှုရန် TrueVisions သို့ စာရင်းသွင်းပါ။"
          }
        }
      },
      "live_time": {
        "$type": "unknown",
        "$value": "Live Time {1}",
        "$description": "",
        "$variable_metadata": {
          "name": "tv_homepage/live_time",
          "figmaId": "VariableID:8177:37428",
          "modes": {
            "en": "Live Time {1}",
            "th": "ถ่ายทอดสดเป็นเวลา {1}",
            "my": "တိုက်ရိုက်ထုတ်လွှင့်ချိန် {1}"
          }
        }
      },
      "streaming": {
        "$type": "unknown",
        "$value": "Streaming {1}",
        "$description": "",
        "$variable_metadata": {
          "name": "tv_homepage/streaming",
          "figmaId": "VariableID:8200:88498",
          "modes": {
            "en": "Streaming {1}",
            "th": "สตรีมมิ่ง {1}",
            "my": "စ့်ထရီးမင်း {1}"
          }
        }
      },
      "reminded_me_button": {
        "$type": "unknown",
        "$value": "Remind me",
        "$description": "",
        "$variable_metadata": {
          "name": "tv_homepage/reminded_me_button",
          "figmaId": "VariableID:8177:37431",
          "modes": {
            "en": "Remind me",
            "th": "เตือนฉัน",
            "my": "မှတ်မိစေပါ"
          }
        }
      },
      "reminded_set_button": {
        "$type": "unknown",
        "$value": "Reminder set",
        "$description": "",
        "$variable_metadata": {
          "name": "tv_homepage/reminded_set_button",
          "figmaId": "VariableID:8177:37432",
          "modes": {
            "en": "Reminder set",
            "th": "ตั้งการแจ้งเตือนแล้ว",
            "my": "မေ့မသွားအောင် မှတ်ပေးပါ"
          }
        }
      },
      "watch_now_button": {
        "$type": "unknown",
        "$value": "Watch Now",
        "$description": "",
        "$variable_metadata": {
          "name": "tv_homepage/watch_now_button",
          "figmaId": "VariableID:12586:44389",
          "modes": {
            "en": "Watch Now",
            "th": "รับชมตอนนี้",
            "my": "အခုကြည့်ပါ "
          }
        }
      }
    },
    "$sign_in_qr": {
      "title": {
        "$type": "unknown",
        "$value": "Log in with QR Code",
        "$description": "",
        "$variable_metadata": {
          "name": "sign_in_qr/title",
          "figmaId": "VariableID:7288:31769",
          "modes": {
            "en": "Log in with QR Code",
            "th": "เข้าสู่ระบบด้วย QR Code",
            "my": "QR Code ဖြင့် 로그인 ဝင်ရောက်ပါ။"
          }
        }
      },
      "log_in_desc": {
        "$type": "unknown",
        "$value": "1. Open the TrueVisions NOW app on your device. 2. Navigate to Settings and select Scan QR Code. 3. Use your phone to scan this QR code to confirm your login.",
        "$description": "",
        "$variable_metadata": {
          "name": "sign_in_qr/log_in_desc",
          "figmaId": "VariableID:7288:31770",
          "modes": {
            "en": "1. Open the TrueVisions NOW app on your device. 2. Navigate to Settings and select Scan QR Code. 3. Use your phone to scan this QR code to confirm your login.",
            "th": "1. เปิดแอป TrueVisions NOW บนอุปกรณ์ของคุณ\n2. ไปที่ “การตั้งค่า” และเลือก “สแกน QR Code”\n3. ใช้โทรศัพท์ของคุณสแกน QR Code นี้เพื่อยืนยันการเข้าสู่ระบบ",
            "my": "1. သင့်စက်တွင် TrueVisions NOW အက်ပ်ကိုဖွင့်ပါ။\n2. ဆက်တင်များသို့ သွားပြီး QR ကုဒ်ကို စကင်န်ဖတ်ရန် ရွေးချယ်ပါ။\n3. သင်၏လော့ဂ်အင်ကို အတည်ပြုရန် ဤ QR ကုဒ်ကို သင့်ဖုန်းဖြင့် စကင်န်ဖတ်ပါ။"
          }
        }
      },
      "language_button": {
        "$type": "unknown",
        "$value": "Language",
        "$description": "",
        "$variable_metadata": {
          "name": "sign_in_qr/language_button",
          "figmaId": "VariableID:7288:31773",
          "modes": {
            "en": "Language",
            "th": "เปลี่ยนภาษา",
            "my": "ဘာသာစကားပြောင်းရန်"
          }
        }
      },
      "qr_session_expired": {
        "$type": "unknown",
        "$value": "Session Expired, Please refresh QR Code.",
        "$description": "",
        "$variable_metadata": {
          "name": "sign_in_qr/qr_session_expired",
          "figmaId": "VariableID:7288:42761",
          "modes": {
            "en": "Session Expired, Please refresh QR Code.",
            "th": "เซสชันหมดอายุ\nกรุณารีเฟรช QR Code",
            "my": "စက်ရှင်သက်တမ်းကုန်သွားပါပြီ၊ ကျေးဇူးပြု၍ QR ကုဒ်ကို ပြန်လည်စတင်ပါ။"
          }
        }
      },
      "qr_error": {
        "$type": "unknown",
        "$value": "An error occurred, Refresh QR Code.",
        "$description": "",
        "$variable_metadata": {
          "name": "sign_in_qr/qr_error",
          "figmaId": "VariableID:7288:42762",
          "modes": {
            "en": "An error occurred, Refresh QR Code.",
            "th": "เกิดข้อผิดพลาด\nรีเฟรช QR Code",
            "my": "အမှားအယွင်းတစ်ခု ဖြစ်ပွားခဲ့သည်၊ QR ကုဒ်ကို ပြန်လည်စတင်ပါ။"
          }
        },
        // more possible key path
      }
    }
  }
}
```

# swift struct 
let allAvailableKeys = @localized.$collection_metadata.modes.keys // ["en", "th", "my"]

// swift code
struct Modes: Codable {
        let modes: [String: String]
    }

struct LocalizedKeyPath: Codable {
        let paths: [String]
        let key: String
        let modes: Modes
}
```

# example of decode mapper result
private let foundPaths: [String] = ["tv_navigation_drawer", "switch_profile"]
localizedKeyPath[i].paths = ["tv_navigation_drawer"] // ignore last value of foundPaths
localizedKeyPath[i].key = "tv_navigation_drawer.switch_profile"
localizedKeyPath[i].modes = Modes(modes: ["en": "Switch Profile", "th": "สลับโปรไฟล์", "my": "ပရိုဖိုင်ပြောင်းရန်"])

- foundPaths compute from traverse json file
- paths is array of string from foundPaths but remove last value
- generate key from foundPaths.join(".") // result: tv_navigation_drawer.switch_profile

# handle of edge case 
- on case empty localizedKeyPath[i].paths will insert "Other" inside path

## Step 2: Generate Localized.swift files
1. reading value of localizedKeyPath from Step 1
2. create new or replace exist file with file name "Localized.swift" at same lv of script file
3. user can config expected output file at path for "Localized.swift" 
4. generate struct Localized follow this rule and condition:
- generate nest struct from localizedKeyPath[i].paths, on case many path value this will efect multi nest struct
- nest struct name is CamelCase format // result: "TvNavigationDrawer"
- property key name is camelCase format // result: "switchProfile"
- Localized is store of localize key use for mapping within Localizable.xcstrings's key
```
struct Localized {
   struct TvNavigationDrawer {
        static let switchProfile = "tv_navigation_drawer.switch_profile" // key 
        // more key 
   }

   struct TvHomepage {
        static let premiumTv = "tv_homepage.premium_tv" // key 
        // more key 
   }
}
```
## Step 3: Generate xcode localized file (Localizable.xcstrings)
- user can config expected output file at path for "Localizable.xcstrings" 
# Requirement for Generating Localizable.xcstrings

1. **File Format**:  
   The output must be a valid `.xcstrings` JSON file, following the Apple Xcode localization format.

2. **Key Structure**:  
   - Each localization entry must have a unique key, matching the dot-separated path (e.g., `"tv_navigation_drawer.switch_profile"`).
   - The key should be mapped to an object containing:
     - `"extractionState": "manual"`
     - `"localizations"`: an object with language codes as keys (`"en"`, `"th"`, `"my"`), each mapping to:
       - `"stringUnit"`: an object with:
         - `"state": "translated"`
         - `"value"`: the localized string for that language.

3. **Languages**:  
   - For every key, provide translations for all available languages: English (`"en"`), Thai (`"th"`), and Burmese (`"my"`).
   - The language codes must match the keys in the `modes` dictionary.

4. **Value Mapping**:  
   - The `"value"` for each language is taken from the corresponding value in the `modes` dictionary for that key.

5. **Edge Cases**:  
   - If a key has no path (i.e., `paths` is empty), use `"Other"` as the path in the key (e.g., `"Other.keyName"`).

6. **Output Example**:  
   For a key with `paths = ["tv_navigation_drawer"]`, `key = "tv_navigation_drawer.switch_profile"`, and `modes = ["en": "Switch Profile", "th": "สลับโปรไฟล์", "my": "ပရိုဖိုင်ပြောင်းရန်"]`, the output should be:
   ```
   "tv_navigation_drawer.switch_profile": {
     "extractionState": "manual",
     "localizations": {
       "en": {
         "stringUnit": {
           "state": "translated",
           "value": "Switch Profile"
         }
       },
       "th": {
         "stringUnit": {
           "state": "translated",
           "value": "สลับโปรไฟล์"
         }
       },
       "my": {
         "stringUnit": {
           "state": "translated",
           "value": "ပရိုဖိုင်ပြောင်းရန်"
         }
       }
     }
   }
   ```
   - All entries must be comma-separated within the JSON object.

7. **File Structure**:  
   - The file should be a single JSON object with all keys at the top level.
   - Ensure proper indentation and valid JSON syntax.

8. **General**:  
   - All keys and values must be properly escaped for JSON.
   - The output must be ready to use as a `.xcstrings` file in Xcode.

9. **Sequential Thinking**:  
   - For each entry, process in order: determine the key, map the values for each language, and format as specified above.

10. **Library/Format Updates**:  
    - If the `.xcstrings` format changes, check the latest documentation to ensure compliance.

# Summary:  
Generate a valid `.xcstrings` JSON file where each key is mapped to its localized values for `"en"`, `"th"`, and `"my"`, following the structure and formatting shown in the example above.

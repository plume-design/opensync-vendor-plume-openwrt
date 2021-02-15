##
# Pre-populate WiFi related OVSDB tables
#

generate_onboarding_ssid()
{
    cat << EOF
        "$OS_ONBOARDING_SSID"
EOF
}

generate_onboarding_psk()
{
    cat << EOF
        ["map",
            [
                ["encryption","WPA-PSK"],
                ["key", "$OS_ONBOARDING_PSK"]
            ]
       ]
EOF
}

cat << EOF
[
    "Open_vSwitch",
    {
        "op": "insert",
        "table": "Wifi_Radio_Config",
        "row": {
            "enabled": true,
            "if_name": "wlan0",
            "freq_band": "5GU",
            "channel": 149,
            "channel_mode": "cloud",
            "channel_sync": 0,
            "hw_type": "qca4019",
            "ht_mode": "HT80",
            "hw_mode": "11ac",
            "vif_configs": ["set", [ ["named-uuid", "id0"] ] ]
        }
    },
    {
        "op": "insert",
        "table": "Wifi_Radio_Config",
        "row": {
            "enabled": true,
            "if_name": "wlan1",
            "freq_band": "2.4G",
            "channel": 6,
            "channel_mode": "cloud",
            "channel_sync": 0,
            "hw_type": "qca4019",
            "ht_mode": "HT40",
            "hw_mode": "11n",
            "vif_configs": ["set", [ ["named-uuid", "id1"] ] ]
        }
    },
    {
        "op": "insert",
        "table": "Wifi_Radio_Config",
        "row": {
            "enabled": true,
            "if_name": "wlan2",
            "freq_band": "5GL",
            "channel": 44,
            "channel_mode": "cloud",
            "channel_sync": 0,
            "hw_type": "qca4019",
            "ht_mode": "HT80",
            "hw_mode": "11ac",
            "vif_configs": ["set", [ ["named-uuid", "id2"] ] ]
        }
    },
    {
        "op": "insert",
        "table": "Wifi_VIF_Config",
        "row": {
            "enabled": true,
            "vif_dbg_lvl": 0,
            "ap_bridge": true,
            "bridge": "br-wan",
            "if_name": "bhaul-sta-24",
            "mode": "sta",
            "vif_radio_idx": 6,
            "mac_list_type": "none",
            "ssid": $(generate_onboarding_ssid),
            "security": $(generate_onboarding_psk)
        },
        "uuid-name": "id1"
    },
    {
        "op": "insert",
        "table": "Wifi_VIF_Config",
        "row": {
            "enabled": true,
            "vif_dbg_lvl": 0,
            "ap_bridge": true,
            "bridge": "br-wan",
            "if_name": "bhaul-sta-50l",
            "mode": "sta",
            "vif_radio_idx": 6,
            "mac_list_type": "none",
            "ssid": $(generate_onboarding_ssid),
            "security": $(generate_onboarding_psk)
        },
        "uuid-name": "id2"
    },
    {
        "op": "insert",
        "table": "Wifi_VIF_Config",
        "row": {
            "enabled": true,
            "vif_dbg_lvl": 0,
            "ap_bridge": true,
            "bridge": "br-wan",
            "if_name": "bhaul-sta-50u",
            "mode": "sta",
            "vif_radio_idx": 6,
            "mac_list_type": "none",
            "ssid": $(generate_onboarding_ssid),
            "security": $(generate_onboarding_psk)
        },
        "uuid-name": "id0"
    }
]
EOF

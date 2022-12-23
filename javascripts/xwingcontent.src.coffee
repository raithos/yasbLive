# This must be loaded before any of the card language modules!
exportObj = exports ? this

exportObj.unreleasedExpansions = [
]

exportObj.isReleased = (data) ->
    for source in data.sources
        return true if source not in exportObj.unreleasedExpansions
    false

String::canonicalize = ->
    this.toLowerCase()
        .replace(/[^a-z0-9]/g, '')
        .replace(/\s+/g, '-')

# Returns an independent copy of the data which can be modified by translation
# modules.
exportObj.basicCardData = ->
    ships:
        "T-65 X-wing":
            name: "T-65 X-wing"
            factions: [ "Rebel Alliance" ]
            attack: 3
            agility: 2
            hull: 4
            shields: 2
            actions: [
                "Focus"
                "Lock"
                "Barrel Roll"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                [ 0, 1, 1, 1, 0, 0, 0, 0, 0, 0]
                [ 2, 1, 1, 1, 2, 0, 0, 0, 0, 0]
                [ 2, 2, 2, 2, 2, 0, 0, 0, 3, 3]
                [ 0, 0, 2, 0, 0, 3, 0, 0, 0, 0]
            ]
            autoequip: [
                "Servomotor S-Foils"
            ]
        "BTL-A4 Y-wing":
            name: "BTL-A4 Y-wing"
            factions: [ "Rebel Alliance", "Scum and Villainy" ]
            attack: 2
            agility: 1
            hull: 6
            shields: 2
            actions: [
                "Focus"
                "Lock"
                "R-Barrel Roll"
                "R-Reload"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0]
                [ 0, 1, 1, 1, 0, 0]
                [ 2, 2, 1, 2, 2, 0]
                [ 3, 2, 2, 2, 3, 0]
                [ 0, 0, 3, 0, 0, 3]
            ]
        "RZ-1 A-wing":
            name: "RZ-1 A-wing"
            factions: [ "Rebel Alliance" ]
            attack: 2
            agility: 3
            hull: 2
            shields: 2
            chassis: "Vectored Thrusters"
            actions: [
                "Focus"
                "Evade"
                "Lock"
                "Barrel Roll"
                "Boost"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0, 0, 0]
                [ 2, 0, 0, 0, 2, 0, 0, 0]
                [ 1, 1, 1, 1, 1, 0, 0, 0]
                [ 2, 2, 1, 2, 2, 0, 3, 3]
                [ 0, 0, 1, 0, 0, 0, 0, 0]
                [ 0, 0, 1, 0, 0, 3, 0, 0]
            ]
        "Modified YT-1300 Light Freighter":
            name: "Modified YT-1300 Light Freighter"
            factions: [ "Rebel Alliance" ]
            attackdt: 3
            agility: 1
            hull: 8
            shields: 5
            keyword: ["Freighter"]
            actions: [
                "Focus"
                "Lock"
                "Rotate Arc"
                "R-Boost"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0, 0, 0]
                [ 0, 2, 1, 2, 0, 0, 0, 0]
                [ 2, 1, 1, 1, 2, 0, 0, 0]
                [ 2, 2, 1, 2, 2, 0, 3, 3]
                [ 0, 0, 2, 0, 0, 3, 0, 0]
            ]
            base: "Large"
        "Customized YT-1300 Light Freighter":
            name: "Customized YT-1300 Light Freighter"
            factions: [ "Scum and Villainy" ]
            attackdt: 2
            agility: 1
            hull: 8
            shields: 3
            keyword: ["Freighter"]
            actions: [
                "Focus"
                "Lock"
                "Rotate Arc"
                "R-Boost"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0, 0, 0]
                [ 0, 1, 1, 1, 0, 0, 0, 0]
                [ 2, 2, 1, 2, 2, 0, 0, 0]
                [ 2, 2, 1, 2, 2, 0, 3, 3]
                [ 0, 0, 2, 0, 0, 3, 0, 0]
            ]
            base: "Large"
        "TIE/ln Fighter":
            name: "TIE/ln Fighter"
            factions: ["Rebel Alliance", "Galactic Empire"]
            attack: 2
            agility: 3
            hull: 3
            shields: 0
            actions: [
                "Focus"
                "Barrel Roll"
                "Evade"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0]
                [ 2, 0, 0, 0, 2, 0]
                [ 2, 1, 1, 1, 2, 0]
                [ 2, 2, 1, 2, 2, 3]
                [ 0, 0, 2, 0, 0, 3]
                [ 0, 0, 2, 0, 0, 0]
            ]
        "TIE Advanced x1":
            name: "TIE Advanced x1"
            factions: [ "Galactic Empire" ]
            attack: 2
            agility: 3
            hull: 3
            shields: 2
            chassis: "Advanced Targeting Computer"
            actions: [
                "Focus"
                "R-> Barrel Roll"
                "Lock"
                "Barrel Roll"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                [ 0, 1, 2, 1, 0, 0, 0, 0, 0, 0]
                [ 2, 1, 1, 1, 2, 0, 0, 0, 0, 0]
                [ 2, 2, 1, 2, 2, 0, 0, 0, 3, 3]
                [ 0, 0, 2, 0, 0, 3, 0, 0, 0, 0]
                [ 0, 0, 2, 0, 0, 0, 0, 0, 0, 0]
            ]
        "TIE/in Interceptor":
            name: "TIE/in Interceptor"
            icon: "tieinterceptor"
            factions: [ "Galactic Empire" ]
            attack: 3
            agility: 3
            hull: 3
            shields: 0
            chassis: "Autothrusters"
            actions: [
                "Focus"
                "Barrel Roll"
                "Boost"
                "Evade"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0, 0, 0]
                [ 2, 0, 0, 0, 2, 0, 0, 0]
                [ 1, 1, 1, 1, 1, 0, 0, 0]
                [ 2, 2, 1, 2, 2, 0, 3, 3]
                [ 0, 0, 1, 0, 0, 3, 0, 0]
                [ 0, 0, 2, 0, 0, 0, 0, 0]
            ]
        "Firespray-class Patrol Craft":
            name: "Firespray-class Patrol Craft"
            factions: [ "Scum and Villainy", "Separatist Alliance"]
            attack: 3
            attackb: 3
            agility: 2
            hull: 6
            shields: 4
            base: "Medium"
            actions: [
                "Focus"
                "Lock"
                "Boost"
                "R-Reinforce"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                [ 2, 1, 1, 1, 2, 0, 0, 0, 0, 0]
                [ 2, 2, 1, 2, 2, 0, 0, 0, 0, 0]
                [ 0, 2, 1, 2, 0, 0, 0, 0, 3, 3]
                [ 0, 0, 2, 0, 0, 3, 0, 0, 0, 0]
            ]
        "HWK-290 Light Freighter":
            name: "HWK-290 Light Freighter"
            factions: [ "Rebel Alliance", "Scum and Villainy" ]
            attackt: 2
            agility: 2
            hull: 3
            shields: 2
            keyword: ["Freighter"]
            actions: [
                "Focus"
                "R-> Rotate Arc"
                "Lock"
                "R-> Rotate Arc"
                "Rotate Arc"
                "R-Boost"
                "R-Jam"
            ]
            maneuvers: [
                [ 0, 0, 3, 0, 0]
                [ 0, 1, 1, 1, 0]
                [ 2, 2, 1, 2, 2]
                [ 3, 2, 1, 2, 3]
                [ 0, 0, 2, 0, 0]
            ]
        "Lambda-class T-4a Shuttle":
            name: "Lambda-class T-4a Shuttle"
            factions: [ "Galactic Empire" ]
            attack: 3
            attackb: 2
            agility: 1
            hull: 6
            shields: 4
            actions: [
                "Focus"
                "Coordinate"
                "Reinforce"
                "R-Jam"
            ]
            maneuvers: [
                [ 0, 0, 3, 0, 0]
                [ 0, 1, 1, 1, 0]
                [ 3, 2, 1, 2, 3]
                [ 0, 3, 2, 3, 0]
            ]
            base: "Large"
        "A/SF-01 B-wing":
            name: "A/SF-01 B-wing"
            factions: [ "Rebel Alliance" ]
            attack: 3
            agility: 1
            hull: 4
            shields: 4
            actions: [
                "Focus"
                "R-> Barrel Roll"
                "Lock"
                "Barrel Roll"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                [ 3, 1, 1, 1, 3, 0, 0, 0, 3, 3]
                [ 2, 2, 1, 2, 2, 3, 0, 0, 0, 0]
                [ 0, 3, 1, 3, 0, 0, 0, 0, 0, 0]
                [ 0, 0, 3, 0, 0, 0, 0, 0, 0, 0]
            ]
            autoequip: [
                'Stabilized S-Foils'
            ]
        "TIE/sa Bomber":
            name: "TIE/sa Bomber"
            factions: [ "Galactic Empire" ]
            attack: 2
            agility: 2
            hull: 6
            shields: 0
            chassis: "Nimble Bomber"
            actions: [
                "Focus"
                "Lock"
                "Barrel Roll"
                "R-> Lock"
                "R-Reload"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0]
                [ 0, 2, 1, 2, 0, 0]
                [ 2, 1, 1, 1, 2, 0]
                [ 2, 2, 1, 2, 2, 3]
                [ 0, 0, 2, 0, 0, 0]
                [ 0, 0, 0, 0, 0, 3]
            ]
        "Z-95-AF4 Headhunter":
            name: "Z-95-AF4 Headhunter"
            factions: [ "Rebel Alliance", "Scum and Villainy" ]
            attack: 2
            agility: 2
            hull: 2
            shields: 2
            actions: [
                "Focus"
                "Lock"
                "R-Barrel Roll"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0]
                [ 0, 2, 1, 2, 0, 0]
                [ 2, 1, 1, 1, 2, 0]
                [ 2, 2, 1, 2, 2, 3]
                [ 0, 0, 2, 0, 0, 3]
            ]
        "TIE/d Defender":
            name: "TIE/d Defender"
            factions: [ "Galactic Empire" ]
            attack: 3
            agility: 3
            hull: 3
            shields: 4
            chassis: "Full Throttle"
            actions: [
                "Focus"
                "Evade"
                "Lock"
                "Barrel Roll"
                "Boost"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0]
                [ 3, 1, 0, 1, 3, 0]
                [ 3, 2, 1, 2, 3, 3]
                [ 2, 2, 1, 2, 2, 0]
                [ 0, 0, 1, 0, 0, 2]
                [ 0, 0, 1, 0, 0, 0]
            ]
        "E-wing":
            name: "E-wing"
            factions: [ "Rebel Alliance" ]
            attack: 3
            agility: 3
            hull: 3
            shields: 3
            chassis: "Experimental Scanners"
            actions: [
                "Focus"
                "Evade"
                "Lock"
                "Barrel Roll"
                "R-> Lock"
                "Boost"
                "R-> Lock"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0, 0, 0 ]
                [ 3, 1, 1, 1, 3, 0, 0, 0 ]
                [ 2, 2, 1, 2, 2, 0, 0, 0 ]
                [ 2, 2, 1, 2, 2, 0, 3, 3 ]
                [ 0, 0, 1, 0, 0, 3, 0, 0 ]
                [ 0, 0, 2, 0, 0, 0, 0, 0 ]
            ]
        "TIE/ph Phantom":
            name: "TIE/ph Phantom"
            factions: [ "Galactic Empire" ]
            attack: 3
            agility: 2
            hull: 3
            shields: 2
            chassis: "Stygium Array"
            actions: [
                "Focus"
                "Evade"
                "Barrel Roll"
                "Cloak"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0]
                [ 2, 2, 0, 2, 2, 0]
                [ 2, 1, 1, 1, 2, 0]
                [ 2, 2, 1, 2, 2, 3]
                [ 0, 0, 2, 0, 0, 3]
            ]
        "YT-2400 Light Freighter":
            name: "YT-2400 Light Freighter"
            factions: [ "Rebel Alliance" ]
            attackdt: 4
            agility: 2
            hull: 6
            shields: 4
            keyword: ["Freighter"]
            chassis: "Sensor Blindspot"
            actions: [
                "Focus"
                "Lock"
                "R-Barrel Roll"
                "Rotate Arc"
            ]
            base: "Large"
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0]
                [ 2, 1, 1, 1, 2, 0]
                [ 2, 2, 1, 2, 2, 0]
                [ 2, 2, 2, 2, 2, 0]
                [ 0, 0, 2, 0, 0, 3]
            ]
        "VT-49 Decimator":
            name: "VT-49 Decimator"
            factions: [ "Galactic Empire" ]
            attackdt: 3
            agility: 0
            hull: 12
            shields: 4
            actions: [
                "Focus"
                "Lock"
                "Reinforce"
                "Rotate Arc"
                "R-Coordinate"
            ]
            base: "Large"
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0]
                [ 3, 1, 1, 1, 3, 0]
                [ 2, 2, 1, 2, 2, 0]
                [ 2, 2, 2, 2, 2, 0]
                [ 0, 0, 2, 0, 0, 0]
            ]
        "StarViper-class Attack Platform":
            name: "StarViper-class Attack Platform"
            factions: ["Scum and Villainy"]
            attack: 3
            agility: 3
            hull: 4
            shields: 1
            chassis: "Microthrusters"
            actions: [
                "Focus"
                "Lock"
                "Barrel Roll"
                "R-> Focus"
                "Boost"
                "R-> Focus"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0, 0, 0]
                [ 2, 1, 1, 1, 2, 0, 0, 0]
                [ 2, 1, 1, 1, 2, 0, 0, 0]
                [ 0, 2, 1, 2, 0, 0, 3, 3]
                [ 0, 0, 2, 0, 0, 0, 0, 0]
            ]
        "M3-A Interceptor":
            name: "M3-A Interceptor"
            factions: [ "Scum and Villainy" ]
            attack: 2
            agility: 3
            hull: 3
            shields: 1
            chassis: "Weapon Hardpoint"
            actions: [
                "Focus"
                "Evade"
                "Lock"
                "Barrel Roll"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0 ]
                [ 2, 1, 0, 1, 2, 0 ]
                [ 2, 2, 1, 2, 2, 0 ]
                [ 0, 2, 1, 2, 0, 3 ]
                [ 0, 0, 2, 0, 0, 0 ]
                [ 0, 0, 2, 0, 0, 3 ]
            ]
        "Aggressor Assault Fighter":
            name: "Aggressor Assault Fighter"
            factions: [ "Scum and Villainy" ]
            attack: 3
            agility: 3
            hull: 5
            shields: 3
            chassis: "Advanced Droid Brain"
            actions: [
                "Calculate"
                "Evade"
                "Lock"
                "Boost"
            ]
            base: "Medium"
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0, 0, 0 ]
                [ 2, 1, 1, 1, 2, 0, 0, 0 ]
                [ 2, 1, 1, 1, 2, 0, 0, 0 ]
                [ 0, 1, 1, 1, 0, 0, 3, 3 ]
                [ 0, 0, 2, 0, 0, 3, 0, 0 ]
            ]
        "YV-666 Light Freighter":
            name: "YV-666 Light Freighter"
            factions: [ "Scum and Villainy" ]
            attackf: 3
            agility: 1
            hull: 9
            shields: 3
            base: "Large"
            actions: [
                "Focus"
                "Reinforce"
                "Lock"
            ]
            maneuvers: [
                [ 0, 0, 3, 0, 0, 0 ]
                [ 0, 1, 1, 1, 0, 0 ]
                [ 3, 2, 1, 2, 3, 0 ]
                [ 2, 2, 1, 2, 2, 0 ]
                [ 0, 0, 2, 0, 0, 0 ]
            ]
        "Kihraxz Fighter":
            name: "Kihraxz Fighter"
            factions: ["Scum and Villainy"]
            attack: 3
            agility: 2
            hull: 5
            shields: 1
            actions: [
                "Focus"
                "Lock"
                "Barrel Roll"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
                [ 2, 1, 0, 1, 2, 0, 0, 0, 0, 0 ]
                [ 2, 1, 1, 1, 2, 0, 0, 0, 3, 3 ]
                [ 0, 2, 1, 2, 0, 0, 0, 0, 0, 0 ]
                [ 0, 0, 2, 0, 0, 3, 0, 0, 0, 0 ]
            ]
        "BTL-S8 K-wing":
            name: "BTL-S8 K-wing"
            factions: ["Rebel Alliance"]
            attackdt: 2
            agility: 1
            hull: 6
            shields: 3
            base: "Medium"
            actions: [
                "Focus"
                "Lock"
                "Slam"
                "Rotate Arc"
                "Reload"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0 ]
                [ 0, 1, 1, 1, 0, 0 ]
                [ 2, 2, 1, 2, 2, 0 ]
                [ 0, 2, 2, 2, 0, 0 ]
            ]
        "TIE/ca Punisher":
            name: "TIE/ca Punisher"
            factions: ["Galactic Empire"]
            attack: 2
            agility: 1
            hull: 6
            shields: 3
            base: "Medium"
            actions: [
                "Focus"
                "Lock"
                "R-Barrel Roll"
                "Boost"
                "R-> Lock"
                "Reload"
            ]
            maneuvers: [
                [ 0, 0, 3, 0, 0, 0 ]
                [ 0, 1, 1, 1, 0, 0 ]
                [ 2, 2, 1, 2, 2, 0 ]
                [ 3, 2, 2, 2, 3, 0 ]
                [ 0, 0, 0, 0, 0, 3 ]
            ]
        "VCX-100 Light Freighter":
            name: "VCX-100 Light Freighter"
            factions: ["Rebel Alliance"]
            attack: 4
            agility: 0
            hull: 10
            shields: 4
            base: "Large"
            keyword: ["Freighter"]
            chassis: "Tail Gun"
            actions: [
                "Focus"
                "Lock"
                "Reinforce"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0 ]
                [ 3, 2, 1, 2, 3, 0 ]
                [ 2, 1, 1, 1, 2, 0 ]
                [ 3, 2, 2, 2, 3, 0 ]
                [ 0, 0, 2, 0, 0, 3 ]
            ]
        "Attack Shuttle":
            name: "Attack Shuttle"
            factions: ["Rebel Alliance"]
            attack: 3
            agility: 2
            hull: 3
            shields: 1
            chassis: "Locked and Loaded"
            actions: [
                "Focus"
                "Evade"
                "Barrel Roll"
                "R-> Evade"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0 ]
                [ 3, 1, 1, 1, 3, 0 ]
                [ 2, 2, 1, 2, 2, 0 ]
                [ 3, 2, 2, 2, 3, 0 ]
                [ 0, 0, 2, 0, 0, 3 ]
            ]
        "TIE Advanced v1":
            name: "TIE Advanced v1"
            factions: ["Galactic Empire"]
            attack: 2
            agility: 3
            hull: 2
            shields: 2
            actions: [
                "Focus"
                "Evade"
                "Lock"
                "Barrel Roll"
                "R-> Focus"
                "Boost"
                "R-> Focus"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
                [ 1, 1, 0, 1, 1, 0, 0, 0, 0, 0 ]
                [ 2, 2, 1, 2, 2, 0, 0, 0, 3, 3 ]
                [ 2, 2, 1, 2, 2, 0, 0, 0, 0, 0 ]
                [ 0, 0, 2, 0, 0, 3, 0, 0, 0, 0 ]
                [ 0, 0, 2, 0, 0, 0, 0, 0, 0, 0 ]
            ]
        "G-1A Starfighter":
            name: "G-1A Starfighter"
            factions: ["Scum and Villainy"]
            attack: 3
            agility: 1
            hull: 5
            shields: 4
            base: "Medium"
            actions: [
                "Focus"
                "Lock"
                "Jam"
            ]
            maneuvers: [
                [ 0, 0, 3, 0, 0, 0 ]
                [ 3, 1, 1, 1, 3, 0 ]
                [ 2, 2, 1, 2, 2, 3 ]
                [ 0, 3, 2, 3, 0, 0 ]
                [ 0, 0, 3, 0, 0, 3 ]
            ]
        "JumpMaster 5000":
            name: "JumpMaster 5000"
            factions: ["Scum and Villainy"]
            base: "Large"
            attackt: 2
            agility: 2
            hull: 6
            shields: 3
            actions: [
                "Focus"
                "R-> Rotate Arc"
                "Lock"
                "R-> Rotate Arc"
                "R-Barrel Roll"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0, 0, 0 ]
                [ 2, 1, 1, 2, 3, 0, 0, 0 ]
                [ 2, 1, 1, 2, 3, 0, 0, 0 ]
                [ 0, 1, 1, 2, 0, 0, 3, 0 ]
                [ 0, 0, 2, 0, 0, 3, 0, 0 ]
            ]
        "ARC-170 Starfighter":
            name: "ARC-170 Starfighter"
            factions: ["Rebel Alliance","Galactic Republic"]
            attack: 3
            attackb: 2
            agility: 1
            hull: 6
            shields: 3
            base: "Medium"
            actions: [
                "Focus"
                "Lock"
                "R-Barrel Roll"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0 ]
                [ 0, 1, 1, 1, 0, 0 ]
                [ 2, 1, 1, 1, 2, 0 ]
                [ 3, 2, 2, 2, 3, 0 ]
                [ 0, 0, 3, 0, 0, 3 ]
            ]
        "Fang Fighter":
            name: "Fang Fighter"
            factions: ["Scum and Villainy", "Rebel Alliance"]
            attack: 3
            agility: 3
            hull: 4
            shields: 0
            chassis: "Concordia Faceoff"
            actions: [
                "Focus"
                "Lock"
                "Barrel Roll"
                "R-> Focus"
                "Boost"
                "R-> Focus"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
                [ 2, 0, 0, 0, 2, 0, 0, 0, 0, 0 ]
                [ 1, 1, 1, 1, 1, 0, 0, 0, 3, 3 ]
                [ 2, 2, 1, 2, 2, 0, 0, 0, 0, 0 ]
                [ 0, 0, 2, 0, 0, 3, 0, 0, 0, 0 ]
                [ 0, 0, 2, 0, 0, 0, 0, 0, 0, 0 ]
            ]
        "Lancer-Class Pursuit Craft":
            name: "Lancer-Class Pursuit Craft"
            factions: ["Scum and Villainy"]
            base: "Large"
            attack: 3
            attackt: 2
            agility: 2
            hull: 8
            shields: 2
            actions: [
                "Focus"
                "Evade"
                "Lock"
                "Rotate Arc"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0]
                [ 0, 2, 2, 2, 0, 0]
                [ 2, 2, 1, 2, 2, 0]
                [ 1, 1, 1, 1, 1, 0]
                [ 0, 0, 1, 0, 0, 0]
                [ 0, 0, 2, 0, 0, 3]
            ]
        "Quadrijet Transfer Spacetug":
            name: "Quadrijet Transfer Spacetug"
            factions: ["Scum and Villainy"]
            attack: 2
            agility: 2
            hull: 5
            shields: 0
            chassis: "Spacetug Tractor Array"
            actions: [
                "Focus"
                "R-Evade"
                "Barrel Roll"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
                [ 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 3, 0, 3 ]
                [ 2, 1, 1, 1, 2, 0, 3, 3, 0, 0, 0, 3, 0 ]
                [ 0, 2, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
            ]
        "UT-60D U-wing":
            name: "UT-60D U-wing"
            factions: ["Rebel Alliance"]
            base: "Medium"
            attack: 3
            agility: 2
            hull: 5
            shields: 3
            actions: [
                "Focus"
                "Lock"
                "R-Coordinate"
            ]
            maneuvers: [
                [ 0, 0, 3, 0, 0 ]
                [ 0, 1, 1, 1, 0 ]
                [ 2, 1, 1, 1, 2 ]
                [ 0, 2, 2, 2, 0 ]
                [ 0, 0, 2, 0, 0 ]
            ]
            autoequip: [
                "Pivot Wing"
            ]
        "TIE/sk Striker":
            name: "TIE/sk Striker"
            factions: ["Galactic Empire"]
            attack: 3
            agility: 2
            hull: 4
            shields: 0
            chassis: "Adaptive Ailerons"
            actions: [
                "Focus"
                "Evade"
                "Barrel Roll"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0, 0, 0 ]
                [ 2, 1, 1, 1, 2, 3, 0, 0 ]
                [ 2, 1, 1, 1, 2, 0, 3, 3 ]
                [ 0, 2, 1, 2, 0, 0, 0, 0 ]
            ]
        "Auzituck Gunship":
            name: "Auzituck Gunship"
            factions: ["Rebel Alliance"]
            attackf: 3
            agility: 1
            hull: 6
            shields: 2
            actions: [
                "Focus"
                "R-Barrel Roll"
                "Reinforce"
            ]
            maneuvers: [
                [ 0, 0, 3, 0, 0, 0, 0, 0 ]
                [ 0, 1, 1, 1, 0, 0, 0, 0 ]
                [ 2, 2, 1, 2, 2, 0, 0, 0 ]
                [ 2, 2, 1, 2, 2, 0, 0, 0 ]
                [ 0, 0, 2, 0, 0, 0, 0, 0 ]
            ]
        "Scurrg H-6 Bomber":
            name: "Scurrg H-6 Bomber"
            factions: ["Scum and Villainy"]
            attack: 3
            agility: 1
            hull: 6
            shields: 4
            base: "Medium"
            actions: [
                "Focus"
                "Lock"
                "R-Barrel Roll"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
                [ 0, 1, 1, 1, 0, 0, 0, 0, 0, 0 ]
                [ 2, 2, 1, 2, 2, 0, 0, 0, 0, 0 ]
                [ 3, 2, 2, 2, 3, 0, 0, 0, 3, 3 ]
                [ 0, 0, 3, 0, 0, 0, 0, 0, 0, 0 ]
            ]
        "TIE/ag Aggressor":
            name: "TIE/ag Aggressor"
            factions: ["Galactic Empire"]
            attack: 2
            agility: 2
            hull: 4
            shields: 1
            actions: [
                "Focus"
                "Lock"
                "Barrel Roll"
                "R-> Evade"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
                [ 0, 2, 1, 2, 0, 0, 0, 0, 0, 0 ]
                [ 2, 1, 1, 1, 2, 0, 0, 0, 0, 0 ]
                [ 2, 2, 1, 2, 2, 0, 0, 0, 0, 0 ]
                [ 0, 0, 2, 0, 0, 3, 0, 0, 0, 0 ]
            ]
        "Alpha-Class Star Wing":
            name: "Alpha-Class Star Wing"
            factions: ["Galactic Empire"]
            attack: 2
            agility: 2
            hull: 4
            shields: 3
            actions: [
                "Focus"
                "Lock"
                "Slam"
                "Reload"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0, 0, 0 ]
                [ 0, 2, 1, 2, 0, 0, 0, 0 ]
                [ 2, 1, 1, 1, 2, 0, 0, 0 ]
                [ 2, 2, 2, 2, 2, 0, 0, 0 ]
                [ 0, 0, 3, 0, 0, 0, 0, 0 ]
            ]
        "M12-L Kimogila Fighter":
            name: "M12-L Kimogila Fighter"
            factions: ["Scum and Villainy"]
            attack: 3
            agility: 1
            hull: 7
            shields: 2
            base: "Medium"
            chassis: "Dead to Rights"
            actions: [
                "Focus"
                "Lock"
                "R-Barrel Roll"
                "Reload"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0]
                [ 3, 2, 1, 2, 3, 0]
                [ 2, 1, 1, 1, 2, 0]
                [ 2, 2, 1, 2, 2, 0]
                [ 0, 0, 0, 0, 0, 3]
            ]
        "Sheathipede-Class Shuttle":
            name: "Sheathipede-Class Shuttle"
            factions: ["Rebel Alliance"]
            attack: 2
            attackb: 2
            agility: 2
            hull: 4
            shields: 1
            chassis: "Comms Shuttle"
            actions: [
                "Focus"
                "Coordinate"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                [ 0, 2, 1, 2, 0, 0, 0, 0, 0, 0, 0, 3, 0]
                [ 2, 1, 1, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0]
                [ 3, 2, 1, 2, 3, 3, 0, 0, 0, 0, 0, 0, 0]
                [ 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
            ]
        "TIE Reaper":
            name: "TIE Reaper"
            factions: ["Galactic Empire"]
            attack: 3
            agility: 1
            hull: 6
            shields: 2
            base: "Medium"
            chassis: "Controlled Ailerons"
            actions: [
                "Focus"
                "Evade"
                "Jam"
                "R-Coordinate"
            ]
            maneuvers: [
                [ 0, 0, 3, 0, 0, 0, 0, 0 ]
                [ 3, 1, 1, 1, 3, 0, 3, 3 ]
                [ 3, 2, 1, 2, 3, 0, 0, 0 ]
                [ 0, 2, 1, 2, 0, 0, 0, 0 ]
            ]
        "Escape Craft":
            name: "Escape Craft"
            factions: ["Scum and Villainy"]
            attack: 2
            agility: 2
            hull: 2
            shields: 2
            chassis: "Co-Pilot"
            actions: [
                "Focus"
                "Barrel Roll"
                "R-Coordinate"
            ]
            maneuvers: [
                [ 0, 0, 3, 0, 0, 0, 0, 0 ]
                [ 0, 1, 1, 1, 0, 0, 0, 0 ]
                [ 3, 2, 1, 2, 3, 0, 0, 0 ]
                [ 0, 2, 2, 2, 0, 3, 0, 0 ]
            ]
        "T-70 X-wing":
            name: "T-70 X-wing"
            factions: [ "Resistance"]
            attack: 3
            agility: 2
            hull: 4
            shields: 3
            chassis: "Weapon Hardpoint"
            actions: [
                "Focus"
                "Lock"
                "Boost"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                [ 0, 1, 1, 1, 0, 0, 0, 0, 0, 0]
                [ 2, 1, 1, 1, 2, 0, 0, 0, 0, 0]
                [ 2, 2, 1, 2, 2, 0, 0, 0, 3, 3]
                [ 0, 0, 2, 0, 0, 3, 0, 0, 0, 0]
            ]
            autoequip: [
                "Integrated S-Foils"
            ]
        "RZ-2 A-wing":
            name: "RZ-2 A-wing"
            factions: ["Resistance"]
            attackt: 2
            agility: 3
            hull: 2
            shields: 2
            chassis: "Refined Gyrostabilizers"
            actions: [
                "Focus"
                "Evade"
                "Lock"
                "Barrel Roll"
                "Boost"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0, 0, 0]
                [ 2, 0, 0, 0, 2, 0, 0, 0]
                [ 1, 1, 1, 1, 1, 0, 0, 0]
                [ 2, 1, 1, 1, 2, 0, 3, 3]
                [ 0, 0, 1, 0, 0, 0, 0, 0]
                [ 0, 0, 1, 0, 0, 3, 0, 0]
            ]
        "TIE/fo Fighter":
            name: "TIE/fo Fighter"
            factions: ["First Order"]
            attack: 2
            agility: 3
            hull: 3
            shields: 1
            actions: [
                "Focus"
                "Evade"
                "Lock"
                "Barrel Roll"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0, 0, 0]
                [ 2, 0, 0, 0, 2, 0, 0, 0]
                [ 1, 1, 1, 1, 1, 0, 3, 3]
                [ 2, 2, 1, 2, 2, 0, 0, 0]
                [ 0, 0, 2, 0, 0, 3, 0, 0]
                [ 0, 0, 2, 0, 0, 0, 0, 0]
            ]
        "TIE/vn Silencer":
            name: "TIE/vn Silencer"
            factions: ["First Order"]
            attack: 3
            agility: 3
            hull: 4
            shields: 2
            chassis: "Autothrusters"
            actions: [
                "Focus"
                "Boost"
                "Lock"
                "Barrel Roll"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                [ 2, 0, 0, 0, 2, 0, 0, 0, 0, 0]
                [ 1, 1, 1, 1, 1, 0, 0, 0, 0, 0]
                [ 2, 2, 1, 2, 2, 0, 0, 0, 3, 3]
                [ 0, 0, 1, 0, 0, 3, 0, 0, 0, 0]
                [ 0, 0, 1, 0, 0, 0, 0, 0, 0, 0]
            ]
        "TIE/sf Fighter":
            name: "TIE/sf Fighter"
            factions: ["First Order"]
            attack: 2
            attackt: 2
            agility: 2
            hull: 3
            shields: 3
            chassis: "Heavy Weapon Turret"
            actions: [
                "Focus"
                "> Rotate Arc"
                "Evade"
                "> Rotate Arc"
                "Lock"
                "> Rotate Arc"
                "Barrel Roll"
                "> Rotate Arc"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                [ 3, 1, 1, 1, 3, 0, 0, 0, 0, 0]
                [ 2, 1, 1, 1, 2, 0, 0, 0, 0, 0]
                [ 2, 2, 1, 2, 2, 0, 3, 3, 0, 0]
                [ 0, 0, 2, 0, 0, 0, 0, 0, 0, 0]
                [ 0, 0, 2, 0, 0, 0, 0, 0, 0, 0]
            ]
        "Upsilon-Class Command Shuttle":
            name: "Upsilon-Class Command Shuttle"
            factions: ["First Order"]
            attack: 4
            agility: 1
            hull: 6
            shields: 6
            chassis: "Linked Battery"
            actions: [
                "Focus"
                "Lock"
                "Reinforce"
                "Coordinate"
                "Jam"
            ]
            maneuvers: [
                [ 0, 0, 3, 0, 0, 0, 0, 0, 0, 0]
                [ 3, 2, 1, 2, 3, 0, 0, 0, 0, 0]
                [ 2, 1, 1, 1, 2, 0, 0, 0, 0, 0]
                [ 3, 2, 2, 2, 3, 0, 0, 0, 0, 0]
                [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
            ]
            base: "Large"
        "MG-100 StarFortress":
            name: "MG-100 StarFortress"
            factions: ["Resistance"]
            attack: 3
            attackdt: 2
            agility: 1
            hull: 9
            shields: 3
            actions: [
                "Focus"
                "Lock"
                "Rotate Arc"
                "Reload"
            ]
            maneuvers: [
                [ 0, 0, 3, 0, 0, 0, 0, 0, 0, 0]
                [ 3, 1, 1, 1, 3, 0, 0, 0, 0, 0]
                [ 2, 2, 1, 2, 2, 0, 0, 0, 0, 0]
                [ 0, 3, 2, 3, 0, 0, 0, 0, 0, 0]
                [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
            ]
            base: "Large"
        "Scavenged YT-1300":
            name: "Scavenged YT-1300"
            factions: [ "Resistance" ]
            attackdt: 3
            agility: 1
            hull: 8
            shields: 3
            keyword: ["Freighter"]
            actions: [
                "Focus"
                "Lock"
                "R-Boost"
                "R-Rotate Arc"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0, 0, 0]
                [ 0, 2, 1, 2, 0, 0, 0, 0]
                [ 2, 1, 1, 1, 2, 0, 0, 0]
                [ 2, 2, 2, 2, 2, 0, 3, 3]
                [ 0, 0, 3, 0, 0, 0, 0, 0]
            ]
            base: "Large"
        "Modified TIE/ln Fighter":
            name: "Modified TIE/ln Fighter"
            factions: ["Scum and Villainy"]
            attack: 2
            agility: 3
            hull: 3
            shields: 0
            chassis: "Notched Stabilizers"
            actions: [
                "Focus"
                "Barrel Roll"
                "Evade"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0]
                [ 2, 0, 0, 0, 2, 0]
                [ 2, 1, 1, 1, 2, 0]
                [ 2, 2, 1, 2, 2, 3]
                [ 0, 0, 2, 0, 0, 0]
                [ 0, 0, 3, 0, 0, 0]
            ]
        "V-19 Torrent Starfighter":
            name: "V-19 Torrent Starfighter"
            factions: ["Galactic Republic"]
            attack: 2
            agility: 2
            hull: 5
            shields: 0
            actions: [
                "Focus"
                "Evade"
                "Lock"
                "Barrel Roll"
                "R-> Evade"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                [ 3, 1, 1, 1, 3, 0, 0, 0, 0, 0]
                [ 2, 2, 1, 2, 2, 0, 0, 0, 3, 3]
                [ 0, 3, 1, 3, 0, 3, 0, 0, 0, 0]
                [ 0, 0, 2, 0, 0, 0, 0, 0, 0, 0]
                [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
            ]
        "Delta-7 Aethersprite":
            name: "Delta-7 Aethersprite"
            factions: ["Galactic Republic"]
            attack: 2
            agility: 3
            hull: 3
            shields: 1
            chassis: "Fine-Tuned Controls"
            actions: [
                "Focus"
                "F-Evade"
                "Lock"
                "Barrel Roll"
                "Boost"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                [ 2, 1, 0, 1, 2, 0, 0, 0, 0, 0]
                [ 2, 1, 1, 1, 2, 0, 3, 3, 0, 0]
                [ 0, 2, 1, 2, 0, 0, 0, 0, 0, 0]
                [ 0, 0, 2, 0, 0, 3, 0, 0, 0, 0]
                [ 0, 0, 2, 0, 0, 3, 0, 0, 0, 0]
            ]
            autoequip: [
                "Calibrated Laser Targeting"
            ]
        "Delta-7b Aethersprite":
            name: "Delta-7b Aethersprite"
            icon: "delta7aethersprite"
            factions: ["Galactic Republic"]
            attack: 3
            agility: 2
            hull: 3
            shields: 3
            chassis: "Fine-Tuned Controls"
            actions: [
                "Focus"
                "F-Evade"
                "Lock"
                "Barrel Roll"
                "Boost"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                [ 2, 1, 0, 1, 2, 0, 0, 0, 0, 0]
                [ 2, 1, 1, 1, 2, 0, 3, 3, 0, 0]
                [ 0, 2, 1, 2, 0, 0, 0, 0, 0, 0]
                [ 0, 0, 2, 0, 0, 3, 0, 0, 0, 0]
                [ 0, 0, 2, 0, 0, 3, 0, 0, 0, 0]
            ]
        "Sith Infiltrator":
            name: "Sith Infiltrator"
            factions: ["Separatist Alliance"]
            attack: 3
            agility: 1
            hull: 6
            base: "Large"
            shields: 4
            actions: [
                "Focus"
                "Lock"
                "R-Barrel Roll"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                [ 3, 1, 1, 1, 3, 0, 0, 0, 0, 0]
                [ 2, 1, 1, 1, 2, 0, 3, 3, 0, 0]
                [ 2, 2, 1, 2, 2, 0, 0, 0, 0, 0]
                [ 0, 0, 2, 0, 0, 0, 0, 0, 0, 0]
                [ 0, 0, 0, 0, 0, 3, 0, 0, 0, 0]
            ]
        "Vulture-class Droid Fighter":
            name: "Vulture-class Droid Fighter"
            factions: ["Separatist Alliance"]
            attack: 2
            agility: 2
            hull: 3
            shields: 0
            chassis: "Networked Calculations"
            actions: [
                "Calculate"
                "Lock"
                "Barrel Roll"
                "R-> Calculate"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                [ 2, 0, 0, 0, 2, 3, 0, 0, 0, 0]
                [ 1, 2, 1, 2, 1, 0, 0, 0, 3, 3]
                [ 2, 3, 1, 3, 2, 0, 0, 0, 0, 0]
                [ 0, 0, 1, 0, 0, 0, 0, 0, 0, 0]
                [ 0, 0, 2, 0, 0, 0, 0, 0, 0, 0]
            ]
            autoequip: [
                'Grappling Struts'
            ]
        "Belbullab-22 Starfighter":
            name: "Belbullab-22 Starfighter"
            factions: ["Separatist Alliance"]
            attack: 3
            agility: 2
            hull: 3
            shields: 2
            actions: [
                "Focus"
                "Lock"
                "Barrel Roll"
                "R-> Focus"
                "Boost"
                "R-> Focus"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                [ 2, 2, 0, 2, 2, 0, 0, 0, 0, 0]
                [ 2, 1, 1, 1, 2, 0, 0, 0, 0, 0]
                [ 3, 2, 1, 2, 3, 0, 3, 3, 0, 0]
                [ 0, 0, 2, 0, 0, 0, 0, 0, 0, 0]
                [ 0, 0, 2, 0, 0, 0, 0, 0, 0, 0]
            ]
        "Naboo Royal N-1 Starfighter":
            name: "Naboo Royal N-1 Starfighter"
            factions: ["Galactic Republic"]
            attack: 2
            agility: 2
            hull: 3
            shields: 2
            chassis: "Full Throttle"
            actions: [
                "Focus"
                "Lock"
                "Barrel Roll"
                "Boost"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                [ 0, 2, 2, 2, 0, 0, 0, 0, 0, 0]
                [ 2, 1, 1, 1, 2, 0, 0, 0, 0, 0]
                [ 2, 1, 1, 1, 2, 0, 0, 0, 3, 3]
                [ 0, 0, 2, 0, 0, 0, 0, 0, 0, 0]
                [ 0, 0, 2, 0, 0, 0, 0, 0, 0, 0]
            ]
        "Hyena-class Droid Bomber":
            name: "Hyena-class Droid Bomber"
            factions: ["Separatist Alliance"]
            attack: 2
            agility: 2
            hull: 5
            shields: 0
            chassis: "Networked Calculations"
            actions: [
                "Calculate"
                "Lock"
                "Barrel Roll"
                "R-> Lock"
                "R-Reload"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                [ 2, 3, 2, 3, 2, 0, 0, 0, 0, 0]
                [ 1, 2, 1, 2, 1, 3, 0, 0, 3, 3]
                [ 2, 0, 1, 0, 2, 0, 0, 0, 0, 0]
                [ 0, 0, 2, 0, 0, 0, 0, 0, 0, 0]
                [ 0, 0, 3, 0, 0, 0, 0, 0, 0, 0]
            ]
            autoequip: [
                'Landing Struts'
            ]
        "Resistance Transport Pod":
            name: "Resistance Transport Pod"
            factions: ["Resistance"]
            attack: 2
            agility: 2
            hull: 3
            shields: 1
            actions: [
                "Focus"
                "R-Lock"
                "R-Barrel Roll"
                "R-Jam"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                [ 3, 1, 1, 1, 3, 0, 0, 0, 0, 0]
                [ 2, 2, 1, 2, 2, 0, 0, 0, 0, 0]
                [ 0, 3, 2, 3, 0, 3, 0, 0, 0, 0]
                [ 0, 0, 3, 0, 0, 0, 0, 0, 0, 0]
            ]
        "Resistance Transport":
            name: "Resistance Transport"
            factions: ["Resistance"]
            attack: 2
            agility: 1
            hull: 5
            shields: 3
            actions: [
                "Focus"
                "Lock"
                "R-Coordinate"
                "R-Jam"
            ]
            maneuvers: [
                [ 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
                [ 3, 1, 1, 1, 3, 0, 0, 0, 0, 0, 3, 0, 3 ]
                [ 2, 2, 1, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0 ]
                [ 0, 3, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
                [ 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
            ]
        "Nantex-Class Starfighter":
            name: "Nantex-Class Starfighter"
            factions: ["Separatist Alliance"]
            attackbull: 3
            attackt: 2
            agility: 3
            hull: 4
            shields: 0
            chassis: "Pinpoint Tractor Array"
            actions: [
                "Focus"
                "Evade"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0, 0, 0]
                [ 2, 1, 0, 1, 2, 0, 0, 0]
                [ 2, 1, 1, 1, 2, 0, 0, 0]
                [ 2, 1, 1, 1, 2, 0, 3, 3]
                [ 0, 0, 2, 0, 0, 0, 0, 0]
                [ 0, 0, 2, 0, 0, 3, 0, 0]
            ]
        "BTL-B Y-wing":
            name: "BTL-B Y-wing"
            factions: ["Galactic Republic"]
            attack: 2
            agility: 1
            hull: 5
            shields: 3
            chassis: "Plated Hull"
            actions: [
                "Focus"
                "Lock"
                "R-Barrel Roll"
                "R-Reload"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0]
                [ 0, 2, 1, 2, 0, 0]
                [ 2, 2, 1, 2, 2, 0]
                [ 3, 2, 2, 2, 3, 0]
                [ 0, 0, 3, 0, 0, 3]
                [ 0, 0, 0, 0, 0, 0]
            ]
        "Fireball":
            name: "Fireball"
            factions: ["Resistance"]
            attack: 2
            agility: 2
            hull: 6
            shields: 0
            chassis: "Explosion with Wings"
            actions: [
                "Focus"
                "Evade"
                "Barrel Roll"
                "Slam"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
                [ 2, 1, 1, 1, 2, 0, 0, 0, 0, 0 ]
                [ 2, 2, 1, 2, 2, 0, 0, 0, 0, 0 ]
                [ 3, 2, 2, 2, 3, 0, 0, 0, 3, 3 ]
                [ 0, 0, 3, 0, 0, 0, 0, 0, 0, 0 ]
                [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
            ]
        "TIE/ba Interceptor":
            name: "TIE/ba Interceptor"
            factions: ["First Order"]
            attack: 3
            agility: 3
            hull: 2
            shields: 2
            chassis: "Fine-Tuned Thrusters"
            actions: [
                "Focus"
                "Evade"
                "Lock"
                "Barrel Roll"
                "Boost"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
                [ 1, 1, 0, 1, 1, 0, 0, 0, 0, 0 ]
                [ 2, 1, 1, 1, 2, 0, 3, 3, 0, 0 ]
                [ 2, 2, 1, 2, 2, 0, 0, 0, 0, 0 ]
                [ 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 ]
                [ 0, 0, 2, 0, 0, 3, 0, 0, 0, 0 ]
            ]
        "Xi-class Light Shuttle":
            name: "Xi-class Light Shuttle"
            factions: ["First Order"]
            attack: 2
            agility: 2
            hull: 5
            shields: 2
            base: "Medium"
            actions: [
                "Focus"
                "R-Lock"
                "R-Coordinate"
                "Jam"
            ]
            maneuvers: [
                [ 0, 0, 3, 0, 0, 0, 0, 0, 0, 0 ]
                [ 0, 1, 1, 1, 0, 0, 0, 0, 0, 0 ]
                [ 2, 1, 1, 1, 2, 0, 0, 0, 0, 0 ]
                [ 3, 2, 2, 2, 3, 0, 0, 0, 0, 0 ]
                [ 0, 0, 2, 0, 0, 0, 0, 0, 0, 0 ]
                [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
            ]
        "HMP Droid Gunship":
            name: "HMP Droid Gunship"
            factions: ["Separatist Alliance"]
            attackf: 2
            agility: 1
            hull: 5
            shields: 3
            chassis: "Networked Aim"
            actions: [
                "Calculate"
                "Lock"
                "R-Barrel Roll"
                "Reload"
                "R-> Calculate"
            ]
            maneuvers: [
                [ 0, 0, 3, 0, 0, 0, 0, 0, 0, 0 ]
                [ 0, 3, 1, 3, 0, 0, 0, 0, 0, 0 ]
                [ 1, 2, 1, 2, 1, 0, 0, 0, 0, 0 ]
                [ 2, 3, 2, 3, 2, 0, 0, 0, 0, 0 ]
                [ 0, 0, 3, 0, 0, 0, 0, 0, 0, 0 ]
                [ 0, 0, 3, 0, 0, 0, 0, 0, 0, 0 ]
            ]
            autoequip: [
                'Repulsorlift Stabilizers'
            ]
        "LAAT/i Gunship":
            name: "LAAT/i Gunship"
            factions: ["Galactic Republic"]
            attackdt: 2
            agility: 1
            hull: 8
            shields: 2
            base: "Medium"
            chassis: "Fire Convergence"
            actions: [
                "Focus"
                "Lock"
                "Rotate Arc"
                "R-Reinforce"
                "Reload"
            ]
            maneuvers: [
                [ 0, 0, 3, 0, 0, 0, 0, 0, 0, 0 ]
                [ 0, 2, 1, 2, 0, 0, 0, 0, 0, 0 ]
                [ 2, 2, 1, 2, 2, 0, 0, 0, 0, 0 ]
                [ 3, 2, 2, 2, 3, 0, 0, 0, 0, 0 ]
                [ 0, 0, 3, 0, 0, 0, 0, 0, 0, 0 ]
                [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
            ]
        "TIE/rb Heavy":
            name: "TIE/rb Heavy"
            factions: ["Galactic Empire"]
            attackt: 2
            agility: 1
            hull: 8
            shields: 0
            base: "Medium"
            chassis: "Rotating Cannons"
            actions: [
                "Focus"
                "Reinforce"
                "Lock"
                "R-Barrel Roll"
                "Rotate Arc"
                "R-> Calculate"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
                [ 3, 2, 1, 2, 3, 0, 0, 0, 0, 0 ]
                [ 2, 1, 1, 1, 2, 0, 0, 0, 0, 0 ]
                [ 3, 2, 2, 2, 3, 0, 0, 0, 3, 3 ]
                [ 0, 0, 2, 0, 0, 0, 0, 0, 0, 0 ]
                [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
            ]
        "Droid Tri-fighter":
            name: "Droid Tri-fighter"
            factions: ["Separatist Alliance"]
            attack: 3
            agility: 3
            hull: 3
            shields: 0
            chassis: "Networked Calculations"
            actions: [
                "Calculate"
                "Evade"
                "Lock"
                "Barrel Roll"
                "R-> Evade"
                "Boost"
                "R-> Calculate"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
                [ 2, 0, 0, 0, 2, 0, 0, 0, 3, 3 ]
                [ 1, 2, 1, 2, 1, 0, 0, 0, 0, 0 ]
                [ 1, 2, 1, 2, 1, 3, 0, 0, 0, 0 ]
                [ 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 ]
                [ 0, 0, 2, 0, 0, 3, 0, 0, 0, 0 ]
            ]
        "Nimbus-class V-wing":
            name: "Nimbus-class V-wing"
            factions: ["Galactic Republic"]
            attack: 2
            agility: 3
            hull: 2
            shields: 2
            keyword: ["TIE"]
            chassis: "Twin Ion Engines"
            actions: [
                "Focus"
                "Lock"
                "R-Barrel Roll"
                "Boost"
                "R-> Lock"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
                [ 2, 3, 0, 3, 2, 0, 0, 0, 0, 0 ]
                [ 1, 1, 1, 1, 1, 3, 0, 0, 0, 0 ]
                [ 2, 2, 1, 2, 2, 0, 0, 0, 0, 0 ]
                [ 0, 0, 2, 0, 0, 3, 0, 0, 0, 0 ]
                [ 0, 0, 2, 0, 0, 0, 0, 0, 0, 0 ]
            ]
        "Eta-2 Actis":
            name: "Eta-2 Actis"
            factions: ["Galactic Republic"]
            attackbull: 3
            attack: 2
            agility: 3
            hull: 3
            shields: 0
            chassis: "Intuitive Controls"
            actions: [
                "Focus"
                "Evade"
                "F-Lock"
                "Barrel Roll"
                "Boost"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
                [ 2, 0, 0, 0, 2, 0, 0, 0, 0, 0 ]
                [ 2, 1, 1, 1, 2, 0, 0, 0, 4, 4 ]
                [ 2, 1, 1, 1, 2, 0, 0, 0, 0, 0 ]
                [ 0, 0, 1, 0, 0, 3, 0, 0, 0, 0 ]
                [ 0, 0, 2, 0, 0, 0, 0, 0, 0, 0 ]
            ]
        "Syliure-class Hyperspace Ring":
            name: "Syliure-class Hyperspace Ring"
            factions: ["Galactic Republic"]
            agility: 1
            hull: 1
            shields: 2
            actions: [
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
            ]
        "BTA-NR2 Y-wing":
            name: "BTA-NR2 Y-wing"
            factions: ["Resistance"]
            attack: 2
            agility: 1
            hull: 4
            shields: 3
            chassis: "Intuitive Interface"
            actions: [
                "Focus"
                "R-Lock"
                "R-Barrel Roll"
                "R-Boost"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0]
                [ 0, 1, 1, 1, 0, 0]
                [ 2, 2, 1, 2, 2, 0]
                [ 3, 2, 1, 2, 3, 0]
                [ 0, 0, 3, 0, 0, 0]
                [ 0, 0, 0, 0, 0, 3]
            ]
        "TIE/wi Whisper Modified Interceptor":
            name: "TIE/wi Whisper Modified Interceptor"
            factions: ["First Order"]
            attackbull: 3
            attackt: 2
            agility: 2
            hull: 3
            shields: 2
            chassis: "Heavy Weapon Turret"
            actions: [
                "Focus"
                "> Rotate Arc"
                "Evade"
                "Lock"
                "Barrel Roll"
                "> Rotate Arc"
                "Boost"
                "> Rotate Arc"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
                [ 2, 0, 0, 0, 2, 0, 0, 0, 0, 0 ]
                [ 2, 1, 1, 1, 2, 0, 0, 0, 0, 0 ]
                [ 2, 1, 1, 1, 2, 0, 3, 3, 0, 0 ]
                [ 0, 0, 1, 0, 0, 3, 0, 0, 0, 0 ]
                [ 0, 0, 1, 0, 0, 3, 0, 0, 0, 0 ]
            ]
            autoequip: [
                "Enhanced Jamming Suite"
            ]
        "TIE/se Bomber":
            name: "TIE/se Bomber"
            factions: ["First Order"]
            attack: 2
            agility: 2
            hull: 4
            shields: 2
            chassis: "Pursuit Thrusters"
            actions: [
                "Focus"
                "Lock"
                "Barrel Roll"
                "R-> Lock"
                "R-Boost"
                "Reload"
                "R-> Evade"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
                [ 3, 2, 1, 2, 3, 0, 0, 0, 0, 0 ]
                [ 2, 2, 1, 2, 2, 0, 0, 0, 0, 0 ]
                [ 2, 2, 1, 2, 2, 0, 3, 3, 0, 0 ]
                [ 0, 0, 2, 0, 0, 0, 0, 0, 0, 0 ]
                [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
            ]
        "Gauntlet Fighter":
            name: "Gauntlet Fighter"
            factions: ["Rebel Alliance", "Galactic Empire", "Scum and Villainy", "Galactic Republic", "Separatist Alliance"]
            attack: 3
            attackb: 2
            agility: 2
            hull: 9
            shields: 2
            base: "Large"
            actions: [
                "Focus"
                "R-Reinforce"
                "Lock"
                "R-Coordinate"
            ]
            autoequip: [
                "Swivel Wing"
            ]
            maneuvers: [
                [ 0, 0, 3, 0, 0, 0, 0, 0, 0, 0 ]
                [ 0, 1, 0, 1, 0, 0, 0, 0, 0, 0 ]
                [ 2, 1, 1, 1, 2, 0, 0, 0, 0, 0 ]
                [ 3, 2, 2, 2, 3, 0, 0, 0, 0, 0 ]
                [ 0, 0, 2, 0, 0, 0, 0, 0, 0, 0 ]
                [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
            ]
        "ST-70 Assault Ship":
            name: "ST-70 Assault Ship"
            factions: ["Scum and Villainy"]
            attack: 3
            agility: 2
            hull: 7
            shields: 2
            base: "Medium"
            actions: [
                "Focus"
                "Evade"
                "Lock"
                "R-Barrel Roll"
            ]
            maneuvers: [
                [ 0, 0, 3, 0, 0, 0, 0, 0, 0, 0 ]
                [ 3, 2, 1, 2, 3, 0, 0, 0, 0, 0 ]
                [ 2, 2, 1, 2, 2, 0, 0, 0, 3, 3 ]
                [ 3, 2, 1, 2, 3, 0, 0, 0, 0, 0 ]
                [ 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 ]
                [ 0, 0, 0, 0, 0, 3, 0, 0, 0, 0 ]
            ]
        "Clone Z-95 Headhunter":
            name: "Clone Z-95 Headhunter"
            factions: [ "Galactic Republic" ]
            attack: 2
            agility: 2
            hull: 2
            shields: 2
            chassis: "Versatile Frame"
            actions: [
                "Focus"
                "Lock"
                "R-Barrel Roll"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0]
                [ 0, 2, 1, 2, 0, 0]
                [ 2, 1, 1, 1, 2, 0]
                [ 2, 2, 1, 2, 2, 3]
                [ 0, 0, 2, 0, 0, 3]
            ]
        "Rogue-class Starfighter":
            name: "Rogue-class Starfighter"
            factions: [ "Separatist Alliance", "Scum and Villainy" ]
            attack: 2
            agility: 2
            hull: 5
            shields: 2
            chassis: "Dead to Rights"
            actions: [
                "Focus"
                "R-> Boost"
                "Focus"
                "R-> Barrel Roll"
                "Evade"
                "R-> Barrel Roll"
                "Lock"
                "R-Boost"
            ]
            maneuvers: [
                [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
                [ 2, 1, 0, 1, 2, 0, 0, 0, 0, 0 ]
                [ 2, 1, 1, 1, 2, 0, 0, 0, 3, 3 ]
                [ 3, 2, 1, 2, 3, 0, 0, 0, 0, 0 ]
                [ 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 ]
                [ 0, 0, 2, 0, 0, 3, 0, 0, 0, 0 ]
            ]

        # Epic Section
        "CR90 Corellian Corvette":
            name: "CR90 Corellian Corvette"
            icon: "cr90corvette"
            factions: ["Galactic Republic", "Rebel Alliance"]
            base: "Huge"
            attackl: 4
            attackr: 4
            agility: 0
            hull: 18
            shields: 7
            shieldrecurr: 2
            energy: 7
            energyrecurr: 2
            actions: [
                "Focus"
                "Reinforce"
                "Lock"
                "R-Coordinate"
                "Jam"
            ]
            maneuvers: [
                [ 0, 3, 3, 3, 0]
                [ 0, 2, 2, 2, 0]
                [ 0, 1, 1, 1, 0]
                [ 0, 3, 1, 3, 0]
                [ 0, 0, 3, 0, 0]
                [ 0, 0, 3, 0, 0]
            ]
        "Raider-class Corvette":
            name: "Raider-class Corvette"
            factions: ["Galactic Empire", "First Order"]
            base: "Huge"
            attackf: 4
            agility: 0
            hull: 20
            shields: 8
            shieldrecurr: 2
            energy: 6
            energyrecurr: 2
            actions: [
                "Focus"
                "Reinforce"
                "Lock"
                "Coordinate"
                "Jam"
            ]
            maneuvers: [
                [ 0, 3, 3, 3, 0]
                [ 0, 1, 2, 1, 0]
                [ 0, 2, 1, 2, 0]
                [ 0, 3, 1, 3, 0]
                [ 0, 0, 2, 0, 0]
                [ 0, 0, 3, 0, 0]
            ]
        "GR-75 Medium Transport":
            name: "GR-75 Medium Transport"
            factions: ["Rebel Alliance", "Resistance"]
            base: "Huge"
            attack: 2
            agility: 0
            hull: 12
            shields: 3
            shieldrecurr: 1
            energy: 4
            energyrecurr: 1
            actions: [
                "Focus"
                "R-Lock"
                "Coordinate"
                "R-Reinforce"
                "Jam"
            ]
            maneuvers: [
                [ 0, 3, 3, 3, 0]
                [ 0, 1, 1, 1, 0]
                [ 0, 2, 2, 2, 0]
                [ 0, 0, 3, 0, 0]
                [ 0, 0, 3, 0, 0]
            ]
        "Gozanti-class Cruiser":
            name: "Gozanti-class Cruiser"
            factions: ["Galactic Empire", "First Order"]
            base: "Huge"
            attack: 3
            agility: 0
            hull: 11
            shields: 5
            shieldrecurr: 1
            energy: 3
            energyrecurr: 1
            actions: [
                "Focus"
                "Reinforce"
                "Lock"
                "Coordinate"
                "Jam"
            ]
            maneuvers: [
                [ 0, 3, 3, 3, 0]
                [ 0, 2, 1, 2, 0]
                [ 0, 3, 1, 3, 0]
                [ 0, 0, 1, 0, 0]
                [ 0, 0, 3, 0, 0]
            ]
        "C-ROC Cruiser":
            name: "C-ROC Cruiser"
            factions: ["Separatist Alliance", "Scum and Villainy"]
            base: "Huge"
            attack: 3
            agility: 0
            hull: 12
            shields: 4
            shieldrecurr: 1
            energy: 4
            energyrecurr: 1
            actions: [
                "Focus"
                "Reinforce"
                "Lock"
                "R-Coordinate"
                "Jam"
            ]
            maneuvers: [
                [ 0, 3, 3, 3, 0]
                [ 0, 2, 1, 2, 0]
                [ 0, 2, 1, 2, 0]
                [ 0, 3, 2, 3, 0]
                [ 0, 0, 3, 0, 0]
                [ 0, 0, 3, 0, 0]
            ]
        "Trident-class Assault Ship":
            name: "Trident-class Assault Ship"
            factions: ["Separatist Alliance", "Scum and Villainy"]
            base: "Huge"
            attack: 3
            agility: 0
            hull: 10
            shields: 4
            shieldrecurr: 1
            energy: 3
            energyrecurr: 2
            actions: [
                "Focus"
                "R-Evade"
                "R-Reinforce"
                "Lock"
                "R-Coordinate"
            ]
            maneuvers: [
                [ 0, 3, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
                [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0 ]
                [ 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 3, 0 ]
                [ 0, 2, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
                [ 0, 0, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0 ]
                [ 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
            ]
            autoequip: [
                'Tractor Tentacles'
            ]

    # name field is for convenience only
    pilotsById: [
        {
            name: "Cavern Angels Zealot"
            id: 0
            faction: "Rebel Alliance"
            ship: "T-65 X-wing"
            keyword: ["Partisan"]
            skill: 1
            points: 5
            loadout: 4
            slots: [
                "Astromech"
                "Illicit"
                "Configuration"
            ]
        }
        {
            name: "Blue Squadron Escort"
            id: 1
            faction: "Rebel Alliance"
            ship: "T-65 X-wing"
            skill: 2
            points: 5
            loadout: 4
            slots: [
                "Astromech"
                "Configuration"
            ]
        }
        {
            name: "Red Squadron Veteran"
            id: 2
            faction: "Rebel Alliance"
            ship: "T-65 X-wing"
            skill: 3
            points: 5
            loadout: 3
            slots: [
                "Talent"
                "Astromech"
                "Configuration"
            ]
        }
        {
            name: "Jek Porkins"
            id: 3
            unique: true
            faction: "Rebel Alliance"
            ship: "T-65 X-wing"
            skill: 4
            points: 5
            loadout: 15
            slots: [
                "Talent"
                "Torpedo"
                "Astromech"
                "Configuration"
            ]
        }
        {
            name: "Luke Skywalker"
            id: 4
            unique: true
            faction: "Rebel Alliance"
            ship: "T-65 X-wing"
            skill: 5
            keyword: ["Light Side"]
            force: 2
            points: 6
            loadout: 22
            slots: [
                "Force"
                "Talent"
                "Torpedo"
                "Astromech"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Wedge Antilles"
            id: 5
            unique: true
            faction: "Rebel Alliance"
            ship: "T-65 X-wing"
            skill: 6
            points: 6
            loadout: 18
            slots: [
                "Talent"
                "Talent"
                "Torpedo"
                "Astromech"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Garven Dreis (X-Wing)"
            canonical_name: 'Garven Dreis'.canonicalize()
            id: 6
            unique: true
            xws: "garvendreis-t65xwing"
            faction: "Rebel Alliance"
            ship: "T-65 X-wing"
            skill: 4
            points: 5
            loadout: 16
            slots: [
                "Talent"
                "Torpedo"
                "Astromech"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Biggs Darklighter"
            id: 7
            unique: true
            faction: "Rebel Alliance"
            ship: "T-65 X-wing"
            skill: 3
            points: 5
            loadout: 18
            slots: [
                "Torpedo"
                "Astromech"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Edrio Two Tubes"
            id: 8
            unique: true
            faction: "Rebel Alliance"
            ship: "T-65 X-wing"
            skill: 2
            points: 4
            loadout: 10
            keyword: ["Partisan"]
            slots: [
                "Missile"
                "Illicit"
                "Configuration"
            ]
        }
        {
            name: "Thane Kyrell"
            id: 9
            unique: true
            faction: "Rebel Alliance"
            ship: "T-65 X-wing"
            skill: 5
            points: 5
            loadout: 14
            slots: [
                "Talent"
                "Torpedo"
                "Astromech"
                "Configuration"
            ]
        }
        {
            name: "Leevan Tenza"
            id: 10
            unique: true
            faction: "Rebel Alliance"
            ship: "T-65 X-wing"
            skill: 3
            points: 4
            loadout: 8
            keyword: ["Partisan"]
            slots: [
                "Talent"
                "Missile"
                "Astromech"
                "Illicit"
                "Configuration"
            ]
        }
        {
            name: "whoops"
            id: 11
            skip: true
        }
        {
            name: "Kullbee Sperado"
            id: 12
            unique: true
            faction: "Rebel Alliance"
            ship: "T-65 X-wing"
            skill: 4
            points: 4
            loadout: 7
            keyword: ["Partisan"]
            slots: [
                "Talent"
                "Missile"
                "Astromech"
                "Illicit"
                "Configuration"
            ]
        }
        {
            name: "Sabine Wren (TIE Fighter)"
            canonical_name: 'Sabine Wren'.canonicalize()
            id: 13
            unique: true
            xws: "sabinewren-tielnfighter"
            faction: "Rebel Alliance"
            ship: "TIE/ln Fighter"
            skill: 3
            points: 3
            loadout: 7
            keyword: ["Spectre", "Mandalorian"]
            slots: [
                "Talent"
                "Missile"
                "Modification"
            ]
        }
        {
            name: "Ezra Bridger (TIE Fighter)"
            canonical_name: 'Ezra Bridger'.canonicalize()
            id: 14
            unique: true
            xws: "ezrabridger-tielnfighter"
            faction: "Rebel Alliance"
            ship: "TIE/ln Fighter"
            skill: 3
            force: 1
            points: 3
            loadout: 6
            keyword: ["Light Side","Spectre"]
            slots: [
                "Force"
                "Crew"
                "Modification"
            ]
        }
        {
            name: '"Zeb" Orrelios (TIE Fighter)'
            canonical_name: '"Zeb" Orrelios'.canonicalize()
            id: 15
            unique: true
            xws: "zeborrelios-tielnfighter"
            faction: "Rebel Alliance"
            ship: "TIE/ln Fighter"
            skill: 2
            points: 3
            loadout: 8
            keyword: ["Spectre"]
            slots: [
                "Crew"
                "Modification"
            ]
        }
        {
            name: "Captain Rex"
            id: 16
            unique: true
            faction: "Rebel Alliance"
            ship: "TIE/ln Fighter"
            skill: 2
            points: 3
            loadout: 8
            keyword: ["Clone"]
            slots: [
                "Talent"
                "Talent"
                "Modification"
            ]
            applies_condition: 'Suppressive Fire'.canonicalize()
        }
        {
            name: "Miranda Doni"
            id: 17
            unique: true
            faction: "Rebel Alliance"
            ship: "BTL-S8 K-wing"
            skill: 4
            points: 5
            loadout: 14
            slots: [
                "Torpedo"
                "Missile"
                "Gunner"
                "Crew"
                "Device"
                "Device"
                "Modification"
            ]
        }
        {
            name: "Esege Tuketu"
            id: 18
            unique: true
            faction: "Rebel Alliance"
            ship: "BTL-S8 K-wing"
            skill: 3
            points: 5
            loadout: 16
            slots: [
                "Torpedo"
                "Missile"
                "Missile"
                "Gunner"
                "Crew"
                "Device"
                "Modification"
            ]
        }
        {
            name: "empty"
            id: 19
            skip: true
        }
        {
            name: "Warden Squadron Pilot"
            id: 20
            faction: "Rebel Alliance"
            ship: "BTL-S8 K-wing"
            skill: 2
            points: 5
            loadout: 7
            slots: [
                "Torpedo"
                "Missile"
                "Gunner"
                "Device"
                "Device"
            ]
        }
        {
            name: "Corran Horn"
            id: 21
            unique: true
            faction: "Rebel Alliance"
            ship: "E-wing"
            skill: 5
            points: 7
            loadout: 20
            slots: [
                "Talent"
                "Tech"
                "Sensor"
                "Sensor"
                "Torpedo"
                "Astromech"
                "Modification"
            ]
        }
        {
            name: "Gavin Darklighter"
            id: 22
            unique: true
            faction: "Rebel Alliance"
            ship: "E-wing"
            skill: 4
            points: 6
            loadout: 18
            slots: [
                "Talent"
                "Tech"
                "Sensor"
                "Torpedo"
                "Astromech"
                "Modification"
            ]
        }
        {
            name: "Rogue Squadron Escort"
            id: 23
            faction: "Rebel Alliance"
            ship: "E-wing"
            skill: 4
            points: 6
            loadout: 12
            slots: [
                "Sensor"
                "Torpedo"
                "Astromech"
                "Modification"
            ]
        }
        {
            name: "Knave Squadron Escort"
            id: 24
            faction: "Rebel Alliance"
            ship: "E-wing"
            skill: 2
            points: 6
            loadout: 14
            slots: [
                "Tech"
                "Torpedo"
                "Astromech"
                "Modification"
            ]
        }
        {
            name: "Norra Wexley (Y-Wing)"
            id: 25
            unique: true
            canonical_name: 'Norra Wexley'.canonicalize()
            xws: "norrawexley-btla4ywing"
            faction: "Rebel Alliance"
            ship: "BTL-A4 Y-wing"
            skill: 5
            points: 5
            loadout: 18
            slots: [
                "Talent"
                "Turret"
                "Torpedo"
                "Astromech"
                "Modification"
                "Device"
            ]
        }
        {
            name: "Horton Salm"
            id: 26
            unique: true
            faction: "Rebel Alliance"
            ship: "BTL-A4 Y-wing"
            skill: 4
            points: 4
            loadout: 14
            slots: [
                "Talent"
                "Turret"
                "Torpedo"
                "Missile"
                "Astromech"
                "Device"
                "Modification"
            ]
        }
        {
            name: '"Dutch" Vander'
            id: 27
            unique: true
            faction: "Rebel Alliance"
            ship: "BTL-A4 Y-wing"
            skill: 4
            points: 4
            loadout: 12
            slots: [
                "Talent"
                "Turret"
                "Torpedo"
                "Missile"
                "Astromech"
                "Device"
                "Device"
                "Modification"
            ]
        }
        {
            name: "Evaan Verlaine"
            id: 28
            unique: true
            faction: "Rebel Alliance"
            ship: "BTL-A4 Y-wing"
            skill: 3
            points: 4
            loadout: 15
            slots: [
                "Talent"
                "Turret"
                "Torpedo"
                "Missile"
                "Astromech"
                "Device"
                "Modification"
                "Modification"
            ]
        }
        {
            name: "Gold Squadron Veteran"
            id: 29
            faction: "Rebel Alliance"
            ship: "BTL-A4 Y-wing"
            skill: 3
            points: 4
            loadout: 6
            slots: [
                "Turret"
                "Missile"
                "Modification"
            ]
        }
        {
            name: "Gray Squadron Bomber"
            id: 30
            faction: "Rebel Alliance"
            ship: "BTL-A4 Y-wing"
            skill: 2
            points: 4
            loadout: 8
            slots: [
                "Device"
                "Missile"
                "Modification"
            ]
        }
        {
            name: "Bodhi Rook"
            id: 31
            unique: true
            faction: "Rebel Alliance"
            ship: "UT-60D U-wing"
            skill: 4
            points: 5
            loadout: 10
            slots: [
                "Sensor"
                "Crew"
                "Crew"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Cassian Andor"
            id: 32
            unique: true
            faction: "Rebel Alliance"
            ship: "UT-60D U-wing"
            skill: 3
            points: 5
            loadout: 12
            slots: [
                "Talent"
                "Sensor"
                "Crew"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Heff Tobber"
            id: 33
            unique: true
            faction: "Rebel Alliance"
            ship: "UT-60D U-wing"
            skill: 2
            points: 5
            loadout: 9
            slots: [
                "Talent"
                "Sensor"
                "Crew"
                "Crew"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Magva Yarro"
            id: 34
            unique: true
            faction: "Rebel Alliance"
            ship: "UT-60D U-wing"
            skill: 3
            points: 5
            loadout: 14
            keyword: ["Partisan"]
            slots: [
                "Talent"
                "Sensor"
                "Crew"
                "Crew"
                "Illicit"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Saw Gerrera"
            id: 35
            unique: true
            faction: "Rebel Alliance"
            ship: "UT-60D U-wing"
            skill: 4
            points: 5
            loadout: 18
            keyword: ["Partisan"]
            slots: [
                "Talent"
                "Sensor"
                "Crew"
                "Crew"
                "Illicit"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Benthic Two Tubes"
            id: 36
            unique: true
            faction: "Rebel Alliance"
            ship: "UT-60D U-wing"
            skill: 2
            points: 5
            loadout: 16
            keyword: ["Partisan"]
            slots: [
                "Talent"
                "Sensor"
                "Crew"
                "Crew"
                "Illicit"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Blue Squadron Scout"
            id: 37
            faction: "Rebel Alliance"
            ship: "UT-60D U-wing"
            skill: 2
            points: 5
            loadout: 6
            slots: [
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Partisan Renegade"
            id: 38
            faction: "Rebel Alliance"
            ship: "UT-60D U-wing"
            skill: 1
            points: 5
            loadout: 6
            keyword: ["Partisan"]
            slots: [
                "Illicit"
                "Configuration"
            ]
        }
        {
            name: "Dash Rendar"
            id: 39
            unique: true
            faction: "Rebel Alliance"
            ship: "YT-2400 Light Freighter"
            skill: 5
            points: 10
            loadout: 22
            slots: [
                "Talent"
                "Missile"
                "Crew"
                "Illicit"
                "Illicit"
                "Modification"
                "Title"
            ]
        }
        {
            name: '"Leebo"'
            id: 40
            unique: true
            faction: "Rebel Alliance"
            ship: "YT-2400 Light Freighter"
            skill: 3
            points: 8
            loadout: 16
            keyword: ["Droid"]
            slots: [
                "Talent"
                "Missile"
                "Illicit"
                "Illicit"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Wild Space Fringer"
            id: 41
            faction: "Rebel Alliance"
            ship: "YT-2400 Light Freighter"
            skill: 1
            points: 8
            loadout: 7
            slots: [
                "Missile"
                "Illicit"
            ]
        }
        {
            name: "Han Solo"
            id: 42
            unique: true
            xws: "hansolo-modifiedyt1300lightfreighter"
            faction: "Rebel Alliance"
            ship: "Modified YT-1300 Light Freighter"
            skill: 6
            points: 8
            loadout: 20
            slots: [
                "Talent"
                "Missile"
                "Crew"
                "Crew"
                "Gunner"
                "Illicit"
                "Modification"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Lando Calrissian"
            id: 43
            unique: true
            xws: "landocalrissian-modifiedyt1300lightfreighter"
            faction: "Rebel Alliance"
            ship: "Modified YT-1300 Light Freighter"
            skill: 5
            points: 8
            loadout: 21
            slots: [
                "Talent"
                "Missile"
                "Crew"
                "Crew"
                "Gunner"
                "Illicit"
                "Modification"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Chewbacca"
            id: 44
            unique: true
            faction: "Rebel Alliance"
            ship: "Modified YT-1300 Light Freighter"
            skill: 4
            charge: 1
            recurring: 1
            points: 7
            loadout: 18
            slots: [
                "Talent"
                "Missile"
                "Crew"
                "Crew"
                "Gunner"
                "Illicit"
                "Modification"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Outer Rim Smuggler"
            id: 45
            faction: "Rebel Alliance"
            ship: "Modified YT-1300 Light Freighter"
            skill: 1
            points: 7
            loadout: 6
            slots: [
                "Missile"
                "Gunner"
            ]
        }
        {
            name: "Jan Ors"
            id: 46
            unique: true
            faction: "Rebel Alliance"
            ship: "HWK-290 Light Freighter"
            skill: 5
            points: 6
            loadout: 10
            slots: [
                "Talent"
                "Crew"
                "Device"
                "Device"
                "Modification"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Roark Garnet"
            id: 47
            unique: true
            faction: "Rebel Alliance"
            ship: "HWK-290 Light Freighter"
            skill: 4
            points: 6
            loadout: 15
            slots: [
                "Talent"
                "Crew"
                "Device"
                "Modification"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Kyle Katarn"
            id: 48
            unique: true
            faction: "Rebel Alliance"
            ship: "HWK-290 Light Freighter"
            skill: 3
            points: 6
            loadout: 12
            slots: [
                "Talent"
                "Talent"
                "Crew"
                "Device"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Rebel Scout"
            id: 49
            faction: "Rebel Alliance"
            ship: "HWK-290 Light Freighter"
            skill: 2
            points: 4
            loadout: 6
            slots: [
                "Device"
                "Modification"
            ]
        }
        {
            name: "Jake Farrell"
            id: 50
            unique: true
            faction: "Rebel Alliance"
            ship: "RZ-1 A-wing"
            skill: 4
            points: 4
            loadout: 8
            slots: [
                "Talent"
                "Talent"
                "Missile"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Arvel Crynyd"
            id: 51
            unique: true
            faction: "Rebel Alliance"
            ship: "RZ-1 A-wing"
            skill: 3
            points: 3
            loadout: 5
            slots: [
                "Talent"
                "Talent"
                "Configuration"
            ]
        }
        {
            name: "Green Squadron Pilot"
            id: 52
            faction: "Rebel Alliance"
            ship: "RZ-1 A-wing"
            skill: 3
            points: 4
            loadout: 4
            slots: [
                "Talent"
                "Talent"
                "Configuration"
            ]
        }
        {
            name: "Phoenix Squadron Pilot"
            id: 53
            faction: "Rebel Alliance"
            ship: "RZ-1 A-wing"
            skill: 1
            points: 4
            loadout: 3
            slots: [
                "Talent"
                "Configuration"
            ]
        }
        {
            name: "Airen Cracken"
            id: 54
            unique: true
            faction: "Rebel Alliance"
            ship: "Z-95-AF4 Headhunter"
            skill: 5
            points: 3
            loadout: 9
            slots: [
                "Talent"
                "Sensor"
                "Torpedo"
                "Modification"
            ]
        }
        {
            name: "Lieutenant Blount"
            id: 55
            unique: true
            faction: "Rebel Alliance"
            ship: "Z-95-AF4 Headhunter"
            skill: 4
            points: 3
            loadout: 6
            slots: [
                "Talent"
                "Talent"
                "Modification"
            ]
        }
        {
            name: "Tala Squadron Pilot"
            id: 56
            faction: "Rebel Alliance"
            ship: "Z-95-AF4 Headhunter"
            skill: 2
            points: 3
            loadout: 4
            slots: [
                "Talent"
                "Modification"
            ]
        }
        {
            name: "Bandit Squadron Pilot"
            id: 57
            faction: "Rebel Alliance"
            ship: "Z-95-AF4 Headhunter"
            skill: 1
            points: 3
            loadout: 5
            slots: [
                "Missile"
                "Modification"
            ]
        }
        {
            name: "Wullffwarro"
            id: 58
            unique: true
            faction: "Rebel Alliance"
            ship: "Auzituck Gunship"
            skill: 4
            points: 5
            loadout: 11
            slots: [
                "Talent"
                "Crew"
                "Crew"
                "Modification"
            ]
        }
        {
            name: "Lowhhrick"
            id: 59
            unique: true
            faction: "Rebel Alliance"
            ship: "Auzituck Gunship"
            skill: 3
            points: 5
            loadout: 10
            slots: [
                "Talent"
                "Crew"
                "Crew"
                "Modification"
            ]
        }
        {
            name: "Kashyyyk Defender"
            id: 60
            faction: "Rebel Alliance"
            ship: "Auzituck Gunship"
            skill: 1
            points: 5
            loadout: 6
            slots: [
                "Crew"
                "Modification"
            ]
        }
        {
            name: "Hera Syndulla (VCX-100)"
            id: 61
            unique: true
            canonical_name: 'Hera Syndulla'.canonicalize()
            xws: "herasyndulla-vcx100lightfreighter"
            faction: "Rebel Alliance"
            ship: "VCX-100 Light Freighter"
            skill: 5
            points: 7
            loadout: 20
            keyword: ["Spectre"]
            slots: [
                "Talent"
                "Sensor"
                "Turret"
                "Torpedo"
                "Crew"
                "Crew"
                "Gunner"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Kanan Jarrus"
            id: 62
            unique: true
            faction: "Rebel Alliance"
            ship: "VCX-100 Light Freighter"
            skill: 3
            keyword: ["Light Side", "Jedi", "Spectre"]
            force: 2
            points: 8
            loadout: 20
            slots: [
                "Force"
                "Sensor"
                "Turret"
                "Torpedo"
                "Crew"
                "Crew"
                "Gunner"
                "Modification"
                "Title"
            ]
        }
        {
            name: '"Chopper"'
            id: 63
            unique: true
            faction: "Rebel Alliance"
            ship: "VCX-100 Light Freighter"
            skill: 2
            points: 7
            loadout: 18
            keyword: ["Droid","Spectre"]
            slots: [
                "Sensor"
                "Turret"
                "Torpedo"
                "Crew"
                "Crew"
                "Gunner"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Lothal Rebel"
            id: 64
            faction: "Rebel Alliance"
            ship: "VCX-100 Light Freighter"
            skill: 2
            points: 7
            loadout: 8
            slots: [
                "Turret"
                "Torpedo"
                "Gunner"
            ]
        }
        {
            name: "Hera Syndulla"
            id: 65
            unique: true
            faction: "Rebel Alliance"
            ship: "Attack Shuttle"
            skill: 5
            points: 4
            loadout: 9
            keyword: ["Spectre"]
            slots: [
                "Talent"
                "Turret"
                "Crew"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Sabine Wren"
            canonical_name: 'Sabine Wren'.canonicalize()
            id: 66
            unique: true
            faction: "Rebel Alliance"
            ship: "Attack Shuttle"
            skill: 3
            points: 4
            loadout: 6
            keyword: ["Mandalorian","Spectre"]
            slots: [
                "Talent"
                "Turret"
                "Crew"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Ezra Bridger"
            id: 67
            unique: true
            faction: "Rebel Alliance"
            ship: "Attack Shuttle"
            skill: 3
            keyword: ["Light Side","Spectre"]
            force: 1
            points: 4
            loadout: 7
            slots: [
                "Force"
                "Turret"
                "Crew"
                "Modification"
                "Title"
            ]
        }

        {
            name: '"Zeb" Orrelios'
            id: 68
            unique: true
            faction: "Rebel Alliance"
            ship: "Attack Shuttle"
            skill: 2
            points: 3
            loadout: 10
            keyword: ["Spectre"]
            slots: [
                "Talent"
                "Turret"
                "Crew"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Fenn Rau (Sheathipede)"
            id: 69
            unique: true
            canonical_name: 'Fenn Rau'.canonicalize()
            xws: "fennrau-sheathipedeclassshuttle"
            faction: "Rebel Alliance"
            ship: "Sheathipede-Class Shuttle"
            skill: 6
            points: 4
            loadout: 9
            keyword: ["Mandalorian","Spectre"]
            slots: [
                "Talent"
                "Crew"
                "Astromech"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Ezra Bridger (Sheathipede)"
            canonical_name: 'Ezra Bridger'.canonicalize()
            id: 70
            unique: true
            xws: "ezrabridger-sheathipedeclassshuttle"
            faction: "Rebel Alliance"
            ship: "Sheathipede-Class Shuttle"
            skill: 3
            force: 1
            points: 4
            loadout: 6
            keyword: ["Light Side","Spectre"]
            slots: [
                "Force"
                "Crew"
                "Astromech"
                "Modification"
                "Title"
            ]
        }
        {
            name: '"Zeb" Orrelios (Sheathipede)'
            canonical_name: '"Zeb" Orrelios'.canonicalize()
            id: 71
            unique: true
            xws: "zeborrelios-sheathipedeclassshuttle"
            faction: "Rebel Alliance"
            ship: "Sheathipede-Class Shuttle"
            skill: 2
            points: 4
            loadout: 11
            keyword: ["Spectre"]
            slots: [
                "Talent"
                "Crew"
                "Astromech"
                "Modification"
                "Title"
            ]
        }
        {
            name: "AP-5"
            id: 72
            unique: true
            faction: "Rebel Alliance"
            ship: "Sheathipede-Class Shuttle"
            skill: 1
            points: 4
            loadout: 4
            keyword: ["Droid","Spectre"]
            slots: [
                "Crew"
                "Modification"
                "Astromech"
                "Title"
            ]
        }
        {
            name: "Braylen Stramm"
            id: 73
            unique: true
            faction: "Rebel Alliance"
            ship: "A/SF-01 B-wing"
            skill: 4
            points: 5
            loadout: 12
            slots: [
                "Talent"
                "Sensor"
                "Cannon"
                "Cannon"
                "Torpedo"
                "Device"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Ten Numb"
            id: 74
            unique: true
            faction: "Rebel Alliance"
            ship: "A/SF-01 B-wing"
            skill: 4
            points: 5
            loadout: 14
            slots: [
                "Talent"
                "Sensor"
                "Cannon"
                "Cannon"
                "Torpedo"
                "Device"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Blade Squadron Veteran"
            id: 75
            faction: "Rebel Alliance"
            ship: "A/SF-01 B-wing"
            skill: 3
            points: 5
            loadout: 6
            slots: [
                "Sensor"
                "Cannon"
                "Cannon"
                "Torpedo"
                "Configuration"
            ]
        }
        {
            name: "Blue Squadron Pilot"
            id: 76
            faction: "Rebel Alliance"
            ship: "A/SF-01 B-wing"
            skill: 2
            points: 5
            loadout: 6
            slots: [
                "Sensor"
                "Cannon"
                "Cannon"
                "Device"
                "Configuration"
            ]
        }
        {
            name: "Norra Wexley"
            id: 77
            unique: true
            faction: "Rebel Alliance"
            ship: "ARC-170 Starfighter"
            skill: 5
            points: 6
            loadout: 16
            slots: [
                "Talent"
                "Torpedo"
                "Crew"
                "Crew"
                "Gunner"
                "Astromech"
                "Modification"
            ]
        }
        {
            name: "Shara Bey"
            id: 78
            unique: true
            faction: "Rebel Alliance"
            ship: "ARC-170 Starfighter"
            skill: 4
            points: 5
            loadout: 12
            slots: [
                "Talent"
                "Torpedo"
                "Missile"
                "Crew"
                "Crew"
                "Gunner"
                "Astromech"
                "Modification"
            ]
        }
        {
            name: "Garven Dreis"
            id: 79
            unique: true
            faction: "Rebel Alliance"
            ship: "ARC-170 Starfighter"
            skill: 4
            points: 5
            loadout: 11
            slots: [
                "Talent"
                "Cannon"
                "Missile"
                "Crew"
                "Crew"
                "Gunner"
                "Astromech"
                "Modification"
            ]
        }
        {
            name: "Ibtisam"
            id: 80
            unique: true
            faction: "Rebel Alliance"
            ship: "ARC-170 Starfighter"
            skill: 3
            points: 5
            loadout: 14
            slots: [
                "Talent"
                "Torpedo"
                "Crew"
                "Crew"
                "Gunner"
                "Astromech"
                "Modification"
            ]
        }
        {
            name: "IG-88A"
            id: 81
            unique: true
            faction: "Scum and Villainy"
            ship: "Aggressor Assault Fighter"
            skill: 4
            points: 7
            loadout: 16
            keyword: ["Bounty Hunter","Droid"]
            slots: [
                "Talent"
                "Sensor"
                "Cannon"
                "Cannon"
                "Device"
                "Illicit"
                "Modification"
                "Title"
            ]
        }
        {
            name: "IG-88B"
            id: 82
            unique: true
            faction: "Scum and Villainy"
            ship: "Aggressor Assault Fighter"
            skill: 4
            points: 7
            loadout: 16
            keyword: ["Bounty Hunter","Droid"]
            slots: [
                "Talent"
                "Sensor"
                "Cannon"
                "Cannon"
                "Device"
                "Illicit"
                "Modification"
                "Title"
                ]
        }
        {
            name: "IG-88C"
            id: 83
            unique: true
            faction: "Scum and Villainy"
            ship: "Aggressor Assault Fighter"
            skill: 4
            points: 7
            loadout: 16
            keyword: ["Bounty Hunter","Droid"]
            slots: [
                "Talent"
                "Sensor"
                "Cannon"
                "Cannon"
                "Device"
                "Illicit"
                "Modification"
                "Title"
            ]
        }
        {
            name: "IG-88D"
            id: 84
            unique: true
            faction: "Scum and Villainy"
            ship: "Aggressor Assault Fighter"
            skill: 4
            points: 6
            loadout: 13
            keyword: ["Bounty Hunter","Droid"]
            slots: [
                "Talent"
                "Sensor"
                "Cannon"
                "Cannon"
                "Device"
                "Illicit"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Kavil"
            id: 85
            unique: true
            faction: "Scum and Villainy"
            ship: "BTL-A4 Y-wing"
            skill: 5
            points: 5
            loadout: 18
            slots: [
                "Talent"
                "Turret"
                "Torpedo"
                "Missile"
                "Astromech"
                "Device"
                "Illicit"
                "Modification"
            ]
        }
        {
            name: "Drea Renthal"
            id: 86
            unique: true
            faction: "Scum and Villainy"
            ship: "BTL-A4 Y-wing"
            skill: 4
            points: 5
            loadout: 10
            slots: [
                "Talent"
                "Turret"
                "Torpedo"
                "Missile"
                "Astromech"
                "Device"
                "Illicit"
                "Modification"
            ]
        }
        {
            name: "Hired Gun"
            id: 87
            faction: "Scum and Villainy"
            ship: "BTL-A4 Y-wing"
            skill: 2
            points: 4
            loadout: 6
            slots: [
                "Turret"
                "Torpedo"
                "Missile"
                "Device"
                "Illicit"
            ]
        }
        {
            name: "Crymorah Goon"
            id: 88
            faction: "Scum and Villainy"
            ship: "BTL-A4 Y-wing"
            skill: 1
            points: 4
            loadout: 4
            slots: [
                "Turret"
                "Missile"
                "Device"
                "Illicit"
            ]
        }
        {
            name: "Han Solo (Scum)"
            id: 89
            unique: true
            xws: "hansolo"
            faction: "Scum and Villainy"
            ship: "Customized YT-1300 Light Freighter"
            skill: 6
            points: 6
            loadout: 20
            slots: [
                "Talent"
                "Missile"
                "Crew"
                "Crew"
                "Gunner"
                "Illicit"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Lando Calrissian (Scum)"
            id: 90
            unique: true
            xws: "landocalrissian"
            faction: "Scum and Villainy"
            ship: "Customized YT-1300 Light Freighter"
            skill: 4
            points: 6
            loadout: 17
            slots: [
                "Talent"
                "Missile"
                "Crew"
                "Gunner"
                "Illicit"
                "Illicit"
                "Modification"
                "Title"
            ]
        }
        {
            name: "L3-37"
            id: 91
            unique: true
            faction: "Scum and Villainy"
            ship: "Customized YT-1300 Light Freighter"
            skill: 2
            points: 6
            loadout: 15
            keyword: ["Droid"]
            slots: [
                "Missile"
                "Crew"
                "Crew"
                "Gunner"
                "Illicit"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Freighter Captain"
            id: 92
            faction: "Scum and Villainy"
            ship: "Customized YT-1300 Light Freighter"
            skill: 1
            points: 6
            loadout: 6
            slots: [
                "Missile"
                "Gunner"
                "Illicit"
            ]
        }
        {
            name: "Lando Calrissian (Scum) (Escape Craft)"
            canonical_name: 'Lando Calrissian (Scum)'.canonicalize()
            id: 93
            unique: true
            xws: "landocalrissian-escapecraft"
            faction: "Scum and Villainy"
            ship: "Escape Craft"
            skill: 4
            points: 3
            loadout: 4
            slots: [
                "Talent"
                "Crew"
                "Modification"
            ]
        }
        {
            name: "Outer Rim Pioneer"
            id: 94
            unique: true
            faction: "Scum and Villainy"
            ship: "Escape Craft"
            skill: 3
            points: 3
            loadout: 4
            slots: [
                "Talent"
                "Crew"
                "Modification"
            ]
        }
        {
            name: "L3-37 (Escape Craft)"
            canonical_name: 'L3-37'.canonicalize()
            id: 95
            unique: true
            xws: "l337-escapecraft"
            faction: "Scum and Villainy"
            ship: "Escape Craft"
            skill: 2
            points: 3
            loadout: 4
            keyword: ["Droid"]
            slots: [
                "Talent"
                "Crew"
                "Modification"
            ]
        }
        {
            name: "Autopilot Drone"
            id: 96
            unique: true
            faction: "Scum and Villainy"
            ship: "Escape Craft"
            skill: 1
            charge: 3
            points: 2
            loadout: 0
            keyword: ["Droid"]
            chassis: "Rigged Energy Cells"
            slots: [
            ]
        }
        {
            name: "Fenn Rau"
            id: 97
            unique: true
            faction: "Scum and Villainy"
            ship: "Fang Fighter"
            skill: 6
            points: 7
            loadout: 18
            keyword: ["Mandalorian"]
            slots: [
                "Talent"
                "Talent"
                "Torpedo"
                "Modification"
            ]
        }
        {
            name: "Old Teroch"
            id: 98
            unique: true
            faction: "Scum and Villainy"
            ship: "Fang Fighter"
            skill: 5
            points: 6
            loadout: 16
            keyword: ["Mandalorian"]
            slots: [
                "Talent"
                "Talent"
                "Torpedo"
                "Modification"
            ]
        }
        {
            name: "Kad Solus"
            id: 99
            unique: true
            faction: "Scum and Villainy"
            ship: "Fang Fighter"
            skill: 4
            points: 5
            loadout: 12
            keyword: ["Mandalorian"]
            slots: [
                "Talent"
                "Missile"
                "Modification"
            ]
        }
        {
            name: "Joy Rekkoff"
            id: 100
            unique: true
            faction: "Scum and Villainy"
            ship: "Fang Fighter"
            skill: 4
            points: 5
            loadout: 11
            keyword: ["Mandalorian"]
            slots: [
                "Talent"
                "Missile"
                "Torpedo"
                "Modification"
            ]
        }
        {
            name: "Skull Squadron Pilot"
            id: 101
            faction: "Scum and Villainy"
            ship: "Fang Fighter"
            skill: 4
            points: 5
            loadout: 6
            keyword: ["Mandalorian"]
            slots: [
                "Torpedo"
                "Modification"
            ]
        }
        {
            name: "Zealous Recruit"
            id: 102
            faction: "Scum and Villainy"
            ship: "Fang Fighter"
            skill: 1
            points: 5
            loadout: 8
            keyword: ["Mandalorian"]
            slots: [
                "Modification"
                "Modification"
            ]
        }
        {
            name: "Boba Fett"
            id: 103
            unique: true
            faction: "Scum and Villainy"
            ship: "Firespray-class Patrol Craft"
            skill: 5
            points: 9
            loadout: 22
            keyword: ["Bounty Hunter"]
            slots: [
                "Talent"
                "Cannon"
                "Missile"
                "Device"
                "Illicit"
                "Modification"
                "Modification"
                "Title"
                "Crew"
            ]
        }
        {
            name: "Emon Azzameen"
            id: 104
            unique: true
            faction: "Scum and Villainy"
            ship: "Firespray-class Patrol Craft"
            skill: 4
            points: 7
            loadout: 17
            slots: [
                "Talent"
                "Cannon"
                "Missile"
                "Crew"
                "Device"
                "Illicit"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Kath Scarlet"
            id: 105
            unique: true
            faction: "Scum and Villainy"
            ship: "Firespray-class Patrol Craft"
            skill: 4
            points: 7
            loadout: 18
            slots: [
                "Talent"
                "Cannon"
                "Missile"
                "Crew"
                "Device"
                "Illicit"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Koshka Frost"
            id: 106
            unique: true
            faction: "Scum and Villainy"
            ship: "Firespray-class Patrol Craft"
            skill: 3
            points: 7
            loadout: 16
            keyword: ["Bounty Hunter"]
            slots: [
                "Talent"
                "Cannon"
                "Missile"
                "Crew"
                "Device"
                "Illicit"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Krassis Trelix"
            id: 107
            unique: true
            faction: "Scum and Villainy"
            ship: "Firespray-class Patrol Craft"
            skill: 3
            points: 7
            loadout: 18
            slots: [
                "Talent"
                "Cannon"
                "Cannon"
                "Missile"
                "Crew"
                "Device"
                "Illicit"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Bounty Hunter"
            id: 108
            faction: "Scum and Villainy"
            ship: "Firespray-class Patrol Craft"
            skill: 2
            points: 7
            loadout: 10
            keyword: ["Bounty Hunter"]
            slots: [
                "Cannon"
                "Missile"
                "Device"
                "Illicit"
            ]
        }
        {
            name: "4-LOM"
            id: 109
            unique: true
            faction: "Scum and Villainy"
            ship: "G-1A Starfighter"
            skill: 3
            points: 5
            loadout: 14
            keyword: ["Bounty Hunter","Droid"]
            slots: [
                "Talent"
                "Sensor"
                "Crew"
                "Illicit"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Zuckuss"
            id: 110
            unique: true
            faction: "Scum and Villainy"
            ship: "G-1A Starfighter"
            skill: 3
            points: 5
            loadout: 10
            keyword: ["Bounty Hunter"]
            slots: [
                "Talent"
                "Sensor"
                "Crew"
                "Illicit"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Gand Findsman"
            id: 111
            faction: "Scum and Villainy"
            ship: "G-1A Starfighter"
            skill: 1
            points: 5
            loadout: 3
            keyword: ["Bounty Hunter"]
            slots: [
                "Illicit"

            ]
        }
        {
            name: "Palob Godalhi"
            id: 112
            unique: true
            faction: "Scum and Villainy"
            ship: "HWK-290 Light Freighter"
            skill: 3
            points: 5
            loadout: 10
            slots: [
                "Talent"
                "Crew"
                "Device"
                "Illicit"
                "Modification"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Dace Bonearm"
            id: 113
            unique: true
            faction: "Scum and Villainy"
            ship: "HWK-290 Light Freighter"
            skill: 4
            charge: 3
            recurring: 1
            points: 5
            loadout: 14
            slots: [
                "Talent"
                "Crew"
                "Device"
                "Illicit"
                "Illicit"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Torkil Mux"
            id: 114
            unique: true
            faction: "Scum and Villainy"
            ship: "HWK-290 Light Freighter"
            skill: 2
            points: 4
            loadout: 10
            slots: [
                "Crew"
                "Device"
                "Illicit"
                "Modification"
                "Modification"
            ]
        }
        {
            name: "Dengar"
            id: 115
            unique: true
            faction: "Scum and Villainy"
            ship: "JumpMaster 5000"
            skill: 6
            charge: 1
            recurring: 1
            points: 7
            loadout: 22
            keyword: ["Bounty Hunter"]
            slots: [
                "Talent"
                "Torpedo"
                "Cannon"
                "Crew"
                "Gunner"
                "Illicit"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Tel Trevura"
            id: 116
            unique: true
            faction: "Scum and Villainy"
            ship: "JumpMaster 5000"
            skill: 4
            charge: 1
            points: 6
            loadout: 20
            slots: [
                "Talent"
                "Cannon"
                "Cannon"
                "Torpedo"
                "Crew"
                "Gunner"
                "Illicit"
                "Modification"
            ]
        }
        {
            name: "Manaroo"
            id: 117
            unique: true
            faction: "Scum and Villainy"
            ship: "JumpMaster 5000"
            skill: 3
            points: 5
            loadout: 15
            keyword: ["Bounty Hunter"]
            slots: [
                "Talent"
                "Torpedo"
                "Cannon"
                "Crew"
                "Gunner"
                "Illicit"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Contracted Scout"
            id: 118
            faction: "Scum and Villainy"
            ship: "JumpMaster 5000"
            skill: 2
            points: 5
            loadout: 4
            slots: [
                "Torpedo"
                "Cannon"
                "Illicit"

            ]
        }
        {
            name: "Talonbane Cobra"
            id: 119
            unique: true
            faction: "Scum and Villainy"
            ship: "Kihraxz Fighter"
            skill: 5
            points: 5
            loadout: 12
            slots: [
                "Talent"
                "Missile"
                "Illicit"
                "Illicit"
                "Modification"
                "Modification"
            ]
        }
        {
            name: "Graz"
            id: 120
            unique: true
            faction: "Scum and Villainy"
            ship: "Kihraxz Fighter"
            skill: 4
            points: 4
            loadout: 8
            keyword: ["Bounty Hunter"]
            slots: [
                "Talent"
                "Missile"
                "Illicit"
                "Illicit"
                "Modification"
                "Modification"
            ]
        }
        {
            name: "Viktor Hel"
            id: 121
            unique: true
            faction: "Scum and Villainy"
            ship: "Kihraxz Fighter"
            skill: 4
            points: 4
            loadout: 10
            keyword: ["Bounty Hunter"]
            slots: [
                "Talent"
                "Missile"
                "Illicit"
                "Illicit"
                "Modification"
                "Modification"
            ]
        }
        {
            name: "Captain Jostero"
            id: 122
            unique: true
            faction: "Scum and Villainy"
            ship: "Kihraxz Fighter"
            skill: 3
            points: 4
            loadout: 12
            slots: [
                "Missile"
                "Illicit"
                "Illicit"
                "Modification"
                "Modification"
            ]
        }
        {
            name: "Black Sun Ace"
            id: 123
            faction: "Scum and Villainy"
            ship: "Kihraxz Fighter"
            skill: 3
            points: 4
            loadout: 3
            slots: [
                "Talent"
            ]
        }
        {
            name: "Cartel Marauder"
            id: 124
            faction: "Scum and Villainy"
            ship: "Kihraxz Fighter"
            skill: 2
            points: 4
            loadout: 7
            slots: [
                "Illicit"
            ]
        }
        {
            name: "Asajj Ventress"
            id: 125
            unique: true
            faction: "Scum and Villainy"
            ship: "Lancer-Class Pursuit Craft"
            skill: 4
            points: 8
            loadout: 20
            force: 2
            keyword: ["Bounty Hunter","Dark Side"]
            slots: [
                "Force"
                "Talent"
                "Crew"
                "Illicit"
                "Illicit"
                "Modification"
            ]
        }
        {
            name: "Ketsu Onyo"
            id: 126
            unique: true
            faction: "Scum and Villainy"
            ship: "Lancer-Class Pursuit Craft"
            skill: 5
            points: 7
            loadout: 15
            keyword: ["Bounty Hunter","Mandalorian"]
            slots: [
                "Talent"
                "Crew"
                "Illicit"
                "Illicit"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Sabine Wren (Scum)"
            id: 127
            unique: true
            xws: "sabinewren-lancerclasspursuitcraft"
            faction: "Scum and Villainy"
            ship: "Lancer-Class Pursuit Craft"
            skill: 3
            points: 6
            loadout: 9
            keyword: ["Bounty Hunter","Mandalorian"]
            slots: [
                "Talent"
                "Crew"
                "Illicit"
                "Illicit"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Shadowport Hunter"
            id: 128
            faction: "Scum and Villainy"
            ship: "Lancer-Class Pursuit Craft"
            skill: 2
            points: 6
            loadout: 6
            keyword: ["Bounty Hunter"]
            slots: [
                "Illicit"
                "Illicit"
            ]
        }
        {
            name: "Torani Kulda"
            id: 129
            unique: true
            faction: "Scum and Villainy"
            ship: "M12-L Kimogila Fighter"
            skill: 4
            points: 5
            loadout: 10
            keyword: ["Bounty Hunter"]
            slots: [
                "Talent"
                "Torpedo"
                "Missile"
                "Astromech"
                "Illicit"
                "Modification"
            ]
        }
        {
            name: "Dalan Oberos"
            id: 130
            unique: true
            faction: "Scum and Villainy"
            ship: "M12-L Kimogila Fighter"
            skill: 3
            charge: 2
            points: 5
            loadout: 12
            keyword: ["Bounty Hunter"]
            slots: [
                "Talent"
                "Torpedo"
                "Missile"
                "Astromech"
                "Illicit"
                "Modification"
            ]
        }
        {
            name: "Cartel Executioner"
            id: 131
            faction: "Scum and Villainy"
            ship: "M12-L Kimogila Fighter"
            skill: 3
            points: 5
            loadout: 3
            slots: [
                "Missile"
            ]
        }
        {
            name: "Serissu"
            id: 132
            unique: true
            faction: "Scum and Villainy"
            ship: "M3-A Interceptor"
            skill: 5
            points: 4
            loadout: 12
            slots: [
                "Talent"
                "Talent"
                "Modification"
                "Modification"
                "HardpointShip"
            ]
        }
        {
            name: "Genesis Red"
            id: 133
            unique: true
            faction: "Scum and Villainy"
            ship: "M3-A Interceptor"
            skill: 4
            points: 4
            loadout: 14
            slots: [
                "Talent"
                "Modification"
                "HardpointShip"
            ]
        }
        {
            name: "Laetin A'shera"
            id: 134
            unique: true
            faction: "Scum and Villainy"
            ship: "M3-A Interceptor"
            skill: 3
            points: 3
            loadout: 7
            slots: [
                "Talent"
                "Modification"
                "HardpointShip"
            ]
        }
        {
            name: "Quinn Jast"
            id: 135
            unique: true
            faction: "Scum and Villainy"
            ship: "M3-A Interceptor"
            skill: 3
            points: 3
            loadout: 7
            keyword: ["Bounty Hunter"]
            slots: [
                "Talent"
                "Modification"
                "HardpointShip"
            ]
        }
        {
            name: "Tansarii Point Veteran"
            id: 136
            faction: "Scum and Villainy"
            ship: "M3-A Interceptor"
            skill: 3
            points: 3
            loadout: 3
            slots: [
                "Modification"
                "HardpointShip"
            ]
        }
        {
            name: "Inaldra"
            id: 137
            unique: true
            faction: "Scum and Villainy"
            ship: "M3-A Interceptor"
            skill: 2
            points: 3
            loadout: 6
            slots: [
                "Modification"
                "HardpointShip"
            ]
        }
        {
            name: "Sunny Bounder"
            id: 138
            unique: true
            faction: "Scum and Villainy"
            ship: "M3-A Interceptor"
            skill: 1
            points: 3
            loadout: 5
            slots: [
                "Modification"
                "HardpointShip"
            ]
        }
        {
            name: "Cartel Spacer"
            id: 139
            faction: "Scum and Villainy"
            ship: "M3-A Interceptor"
            skill: 1
            points: 3
            loadout: 4
            slots: [
                "Modification"
                "HardpointShip"
            ]
        }
        {
            name: "Constable Zuvio"
            id: 140
            unique: true
            faction: "Scum and Villainy"
            ship: "Quadrijet Transfer Spacetug"
            skill: 4
            points: 4
            loadout: 13
            slots: [
                "Talent"
                "Tech"
                "Device"
                "Device"
                "Illicit"
                "Modification"
            ]
        }
        {
            name: "Sarco Plank"
            id: 141
            unique: true
            faction: "Scum and Villainy"
            ship: "Quadrijet Transfer Spacetug"
            skill: 2
            points: 4
            loadout: 6
            keyword: ["Bounty Hunter"]
            slots: [
                "Tech"
                "Crew"
                "Device"
                "Illicit"
                "Illicit"
                "Modification"
            ]
        }
        {
            name: "Unkar Plutt"
            id: 142
            unique: true
            faction: "Scum and Villainy"
            ship: "Quadrijet Transfer Spacetug"
            skill: 2
            points: 4
            loadout: 7
            slots: [
                "Tech"
                "Crew"
                "Device"
                "Illicit"
                "Modification"
            ]
        }
        {
            name: "Jakku Gunrunner"
            id: 143
            faction: "Scum and Villainy"
            ship: "Quadrijet Transfer Spacetug"
            skill: 1
            points: 4
            loadout: 4
            slots: [
                "Device"
                "Illicit"
                "Illicit"
            ]
        }
        {
            name: "Captain Nym"
            id: 144
            unique: true
            faction: "Scum and Villainy"
            ship: "Scurrg H-6 Bomber"
            skill: 5
            charge: 1
            recurring: 1
            points: 6
            loadout: 17
            slots: [
                "Talent"
                "Turret"
                "Crew"
                "Gunner"
                "Device"
                "Device"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Sol Sixxa"
            id: 145
            unique: true
            faction: "Scum and Villainy"
            ship: "Scurrg H-6 Bomber"
            skill: 3
            points: 5
            loadout: 12
            slots: [
                "Talent"
                "Turret"
                "Crew"
                "Gunner"
                "Device"
                "Device"
                "Modification"
            ]
        }
        {
            name: "Lok Revenant"
            id: 146
            faction: "Scum and Villainy"
            ship: "Scurrg H-6 Bomber"
            skill: 2
            points: 5
            loadout: 7
            slots: [
                "Turret"
                "Gunner"
                "Device"
                "Device"
            ]
        }
        {
            name: "Guri"
            id: 147
            unique: true
            faction: "Scum and Villainy"
            ship: "StarViper-class Attack Platform"
            skill: 5
            points: 7
            loadout: 20
            keyword: ["Droid"]
            slots: [
                "Talent"
                "Tech"
                "Torpedo"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Prince Xizor"
            id: 148
            unique: true
            faction: "Scum and Villainy"
            ship: "StarViper-class Attack Platform"
            skill: 4
            points: 5
            loadout: 7
            slots: [
                "Talent"
                "Tech"
                "Torpedo"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Dalan Oberos (StarViper)"
            canonical_name: 'Dalan Oberos'.canonicalize()
            id: 149
            unique: true
            xws: "dalanoberos-starviperclassattackplatform"
            faction: "Scum and Villainy"
            ship: "StarViper-class Attack Platform"
            skill: 4
            points: 5
            loadout: 10
            keyword: ["Bounty Hunter"]
            slots: [
                "Talent"
                "Tech"
                "Torpedo"
                "Modification"
            ]
        }
        {
            name: "Black Sun Assassin"
            id: 150
            faction: "Scum and Villainy"
            ship: "StarViper-class Attack Platform"
            skill: 3
            points: 5
            loadout: 6
            slots: [
                "Tech"
            ]
        }
        {
            name: "Black Sun Enforcer"
            id: 151
            faction: "Scum and Villainy"
            ship: "StarViper-class Attack Platform"
            skill: 2
            points: 5
            loadout: 6
            slots: [
                "Tech"
            ]
        }
        {
            name: "Moralo Eval"
            id: 152
            unique: true
            faction: "Scum and Villainy"
            ship: "YV-666 Light Freighter"
            skill: 4
            charge: 2
            points: 7
            loadout: 20
            slots: [
                "Talent"
                "Cannon"
                "Missile"
                "Crew"
                "Crew"
                "Gunner"
                "Illicit"
                "Modification"
            ]
        }
        {
            name: "Bossk"
            id: 153
            unique: true
            faction: "Scum and Villainy"
            ship: "YV-666 Light Freighter"
            skill: 4
            points: 7
            loadout: 22
            keyword: ["Bounty Hunter"]
            slots: [
                "Talent"
                "Cannon"
                "Missile"
                "Crew"
                "Crew"
                "Gunner"
                "Illicit"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Latts Razzi"
            id: 154
            unique: true
            faction: "Scum and Villainy"
            ship: "YV-666 Light Freighter"
            skill: 3
            points: 6
            loadout: 16
            keyword: ["Bounty Hunter"]
            slots: [
                "Talent"
                "Cannon"
                "Missile"
                "Crew"
                "Crew"
                "Gunner"
                "Illicit"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Trandoshan Slaver"
            id: 155
            faction: "Scum and Villainy"
            ship: "YV-666 Light Freighter"
            skill: 2
            points: 6
            loadout: 6
            slots: [
                "Cannon"
                "Missile"
                "Modification"
            ]
        }
        {
            name: "N'dru Suhlak"
            id: 156
            unique: true
            faction: "Scum and Villainy"
            ship: "Z-95-AF4 Headhunter"
            skill: 4
            points: 3
            loadout: 7
            slots: [
                "Talent"
                "Missile"
                "Missile"
                "Illicit"
            ]
        }
        {
            name: "Kaa'to Leeachos"
            id: 157
            unique: true
            faction: "Scum and Villainy"
            ship: "Z-95-AF4 Headhunter"
            skill: 3
            points: 3
            loadout: 11
            keyword: ["Bounty Hunter"]
            slots: [
                "Talent"
                "Missile"
                "Illicit"
                "Modification"
            ]
        }
        {
            name: "Black Sun Soldier"
            id: 158
            faction: "Scum and Villainy"
            ship: "Z-95-AF4 Headhunter"
            skill: 3
            points: 3
            loadout: 4
            slots: [
                "Missile"
                "Illicit"
                "Modification"
            ]
        }
        {
            name: "Binayre Pirate"
            id: 159
            faction: "Scum and Villainy"
            ship: "Z-95-AF4 Headhunter"
            skill: 1
            points: 3
            loadout: 2
            slots: [
                "Illicit"
            ]
        }
        {
            name: "Nashtah Pup"
            id: 160
            unique: true
            faction: "Scum and Villainy"
            ship: "Z-95-AF4 Headhunter"
            skill: "*"
            points: 1
            loadout: 0
            slots: [
            ]
            restrictions: [
                ["Unique", "Hound's Tooth"]
            ]
            restriction_func: (ship) ->
                builder = ship.builder
                for t, things of builder.uniques_in_use
                    if t != 'Slot'
                        if 'houndstooth' in (thing.canonical_name.getXWSBaseName() for thing in things)
                            for shiplist in ship.builder.ships
                                for upgrade in shiplist.upgrades
                                    if upgrade.data? and ship.pilot?
                                        if upgrade.data.name == "Hound's Tooth"
                                            ship.pilot.skill = shiplist.pilot.skill
                                            break
                            return true 
                false

        }
        {
            name: "Major Vynder"
            id: 161
            unique: true
            faction: "Galactic Empire"
            ship: "Alpha-Class Star Wing"
            skill: 4
            points: 6
            loadout: 21
            slots: [
                "Talent"
                "Sensor"
                "Torpedo"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Lieutenant Karsabi"
            id: 162
            unique: true
            faction: "Galactic Empire"
            ship: "Alpha-Class Star Wing"
            skill: 3
            points: 5
            loadout: 11
            slots: [
                "Talent"
                "Sensor"
                "Missile"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Rho Squadron Pilot"
            id: 163
            faction: "Galactic Empire"
            ship: "Alpha-Class Star Wing"
            skill: 3
            points: 5
            loadout: 9
            slots: [
                "Talent"
                "Sensor"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Nu Squadron Pilot"
            id: 164
            faction: "Galactic Empire"
            ship: "Alpha-Class Star Wing"
            skill: 2
            points: 5
            loadout: 7
            slots: [
                "Sensor"
                "Cannon"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Captain Kagi"
            id: 165
            unique: true
            faction: "Galactic Empire"
            ship: "Lambda-class T-4a Shuttle"
            skill: 4
            points: 6
            loadout: 22
            slots: [
                "Sensor"
                "Cannon"
                "Crew"
                "Crew"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Lieutenant Sai"
            id: 166
            unique: true
            faction: "Galactic Empire"
            ship: "Lambda-class T-4a Shuttle"
            skill: 3
            points: 5
            loadout: 14
            slots: [
                "Sensor"
                "Cannon"
                "Crew"
                "Crew"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Colonel Jendon"
            id: 167
            unique: true
            faction: "Galactic Empire"
            ship: "Lambda-class T-4a Shuttle"
            skill: 3
            charge: 2
            points: 6
            loadout: 20
            slots: [
                "Sensor"
                "Cannon"
                "Cannon"
                "Crew"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Omicron Group Pilot"
            id: 168
            faction: "Galactic Empire"
            ship: "Lambda-class T-4a Shuttle"
            skill: 1
            points: 5
            loadout: 8
            slots: [
                "Sensor"
                "Cannon"
                "Modification"
            ]
        }
        {
            name: "Grand Inquisitor"
            id: 169
            unique: true
            faction: "Galactic Empire"
            ship: "TIE Advanced v1"
            skill: 5
            points: 6
            loadout: 17
            force: 2
            keyword: ["Dark Side"]
            slots: [
                "Force"
                "Force"
                "Talent"
                "Sensor"
                "Missile"
            ]
        }
        {
            name: "Seventh Sister"
            id: 170
            unique: true
            faction: "Galactic Empire"
            ship: "TIE Advanced v1"
            skill: 4
            points: 5
            loadout: 14
            force: 2
            keyword: ["Dark Side"]
            slots: [
                "Force"
                "Talent"
                "Talent"
                "Sensor"
                "Missile"
            ]
        }
        {
            name: "Inquisitor"
            id: 171
            faction: "Galactic Empire"
            ship: "TIE Advanced v1"
            skill: 3
            points: 4
            loadout: 5
            force: 1
            keyword: ["Dark Side"]
            slots: [
                "Force"
                "Sensor"
            ]
        }
        {
            name: "Baron of the Empire"
            id: 172
            faction: "Galactic Empire"
            ship: "TIE Advanced v1"
            skill: 3
            points: 4
            loadout: 4
            slots: [
                "Talent"
                "Sensor"
                "Missile"
            ]
        }
        {
            name: "Darth Vader"
            id: 173
            unique: true
            faction: "Galactic Empire"
            ship: "TIE Advanced x1"
            skill: 6
            keyword: ["Dark Side","Sith"]
            points: 7
            loadout: 21
            force: 3
            slots: [
                "Force"
                "Force"
                "Talent"
                "Tech"
                "Sensor"
                "Missile"
                "Modification"
                "Modification"
            ]
        }
        {
            name: "Maarek Stele"
            id: 174
            unique: true
            faction: "Galactic Empire"
            ship: "TIE Advanced x1"
            skill: 5
            points: 5
            loadout: 14
            slots: [
                "Talent"
                "Talent"
                "Sensor"
                "Missile"
                "Modification"
            ]
        }
        {
            name: "Ved Foslo"
            id: 175
            unique: true
            faction: "Galactic Empire"
            ship: "TIE Advanced x1"
            skill: 4
            points: 4
            loadout: 8
            slots: [
                "Talent"
                "Sensor"
                "Missile"
                "Modification"
            ]
        }
        {
            name: "Zertik Strom"
            id: 176
            unique: true
            faction: "Galactic Empire"
            ship: "TIE Advanced x1"
            skill: 3
            points: 4
            loadout: 6
            slots: [
                "Sensor"
                "Missile"
                "Modification"
            ]
        }
        {
            name: "Storm Squadron Ace"
            id: 177
            faction: "Galactic Empire"
            ship: "TIE Advanced x1"
            skill: 3
            points: 4
            loadout: 2
            slots: [
                "Talent"
                "Sensor"
                "Modification"
            ]
        }
        {
            name: "Tempest Squadron Pilot"
            id: 178
            faction: "Galactic Empire"
            ship: "TIE Advanced x1"
            skill: 2
            points: 4
            loadout: 4
            slots: [
                "Sensor"
                "Modification"
            ]
        }
        {
            name: "Soontir Fel"
            id: 179
            unique: true
            faction: "Galactic Empire"
            ship: "TIE/in Interceptor"
            skill: 6
            points: 6
            loadout: 15
            slots: [
                "Talent"
                "Talent"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Turr Phennir"
            id: 180
            unique: true
            faction: "Galactic Empire"
            ship: "TIE/in Interceptor"
            skill: 4
            points: 4
            loadout: 9
            slots: [
                "Talent"
                "Talent"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Saber Squadron Ace"
            id: 181
            faction: "Galactic Empire"
            ship: "TIE/in Interceptor"
            skill: 4
            points: 4
            loadout: 3
            slots: [
                "Talent"
                "Configuration"
            ]
        }
        {
            name: "Alpha Squadron Pilot"
            id: 182
            faction: "Galactic Empire"
            ship: "TIE/in Interceptor"
            skill: 1
            points: 4
            loadout: 2
            slots: [
                "Talent"
                "Configuration"
            ]
        }
        {
            name: "Major Vermeil"
            id: 183
            unique: true
            faction: "Galactic Empire"
            ship: "TIE Reaper"
            skill: 4
            points: 5
            loadout: 16
            slots: [
                "Talent"
                "Crew"
                "Crew"
                "Modification"
            ]
        }
        {
            name: "Captain Feroph"
            id: 184
            unique: true
            faction: "Galactic Empire"
            ship: "TIE Reaper"
            skill: 3
            points: 4
            loadout: 9
            slots: [
                "Talent"
                "Crew"
                "Modification"
                "Modification"
            ]
        }
        {
            name: '"Vizier"'
            id: 185
            unique: true
            faction: "Galactic Empire"
            ship: "TIE Reaper"
            skill: 2
            points: 4
            loadout: 12
            slots: [
                "Crew"
                "Crew"
                "Modification"
            ]
        }
        {
            name: "Scarif Base Pilot"
            id: 186
            faction: "Galactic Empire"
            ship: "TIE Reaper"
            skill: 1
            points: 4
            loadout: 6
            slots: [
                "Crew"
                "Modification"
            ]
        }
        {
            name: "Lieutenant Kestal"
            id: 187
            unique: true
            faction: "Galactic Empire"
            ship: "TIE/ag Aggressor"
            skill: 4
            points: 5
            loadout: 19
            slots: [
                "Talent"
                "Turret"
                "Missile"
                "Missile"
                "Gunner"
                "Modification"
                "Modification"
            ]
        }
        {
            name: '"Double Edge"'
            id: 188
            unique: true
            faction: "Galactic Empire"
            ship: "TIE/ag Aggressor"
            skill: 2
            points: 4
            loadout: 13
            slots: [
                "Talent"
                "Turret"
                "Missile"
                "Missile"
                "Gunner"
                "Modification"
            ]
        }
        {
            name: "Onyx Squadron Scout"
            id: 189
            faction: "Galactic Empire"
            ship: "TIE/ag Aggressor"
            skill: 3
            points: 4
            loadout: 12
            slots: [
                "Talent"
                "Turret"
                "Missile"
                "Gunner"
            ]
        }
        {
            name: "Sienar Specialist"
            id: 190
            faction: "Galactic Empire"
            ship: "TIE/ag Aggressor"
            skill: 2
            points: 4
            loadout: 8
            slots: [
                "Turret"
                "Missile"
                "Gunner"
                "Modification"
            ]
        }
        {
            name: '"Redline"'
            id: 191
            unique: true
            faction: "Galactic Empire"
            ship: "TIE/ca Punisher"
            skill: 5
            points: 7
            loadout: 25
            slots: [
                "Sensor"
                "Torpedo"
                "Missile"
                "Missile"
                "Gunner"
                "Device"
                "Modification"
                "Modification"
            ]
        }
        {
            name: '"Deathrain"'
            id: 192
            unique: true
            faction: "Galactic Empire"
            ship: "TIE/ca Punisher"
            skill: 4
            points: 6
            loadout: 20
            slots: [
                "Talent"
                "Sensor"
                "Torpedo"
                "Missile"
                "Gunner"
                "Device"
                "Device"
                "Modification"
            ]
        }
        {
            name: "Cutlass Squadron Pilot"
            id: 193
            faction: "Galactic Empire"
            ship: "TIE/ca Punisher"
            skill: 2
            points: 5
            loadout: 6
            slots: [
                "Sensor"
                "Torpedo"
                "Missile"
                "Gunner"
                "Device"
                "Modification"
            ]
        }
        {
            name: "Colonel Vessery"
            id: 194
            unique: true
            faction: "Galactic Empire"
            ship: "TIE/d Defender"
            skill: 4
            points: 7
            loadout: 10
            slots: [
                "Talent"
                "Sensor"
                "Cannon"
                "Missile"
                "Configuration"
            ]
        }
        {
            name: "Countess Ryad"
            id: 195
            unique: true
            faction: "Galactic Empire"
            ship: "TIE/d Defender"
            skill: 4
            points: 7
            loadout: 12
            slots: [
                "Talent"
                "Sensor"
                "Sensor"
                "Cannon"
                "Missile"
                "Configuration"
            ]
        }
        {
            name: "Rexler Brath"
            id: 196
            unique: true
            faction: "Galactic Empire"
            ship: "TIE/d Defender"
            skill: 5
            points: 7
            loadout: 13
            slots: [
                "Talent"
                "Sensor"
                "Cannon"
                "Missile"
                "Missile"
                "Configuration"
            ]
        }
        {
            name: "Onyx Squadron Ace"
            id: 197
            faction: "Galactic Empire"
            ship: "TIE/d Defender"
            skill: 4
            points: 7
            loadout: 6
            slots: [
                "Talent"
                "Sensor"
                "Cannon"
                "Missile"
                "Configuration"
            ]
        }
        {
            name: "Delta Squadron Pilot"
            id: 198
            faction: "Galactic Empire"
            ship: "TIE/d Defender"
            skill: 1
            points: 7
            loadout: 4
            slots: [
                "Sensor"
                "Cannon"
                "Configuration"
            ]
        }
        {
            name: '"Whisper"'
            id: 199
            unique: true
            faction: "Galactic Empire"
            ship: "TIE/ph Phantom"
            skill: 5
            points: 7
            loadout: 15
            slots: [
                "Talent"
                "Sensor"
                "Gunner"
                "Modification"
                "Modification"
            ]
        }
        {
            name: '"Echo"'
            id: 200
            unique: true
            faction: "Galactic Empire"
            ship: "TIE/ph Phantom"
            skill: 4
            points: 6
            loadout: 11
            slots: [
                "Talent"
                "Talent"
                "Sensor"
                "Gunner"
                "Modification"
            ]
        }
        {
            name: "Sigma Squadron Ace"
            id: 201
            faction: "Galactic Empire"
            ship: "TIE/ph Phantom"
            skill: 4
            points: 6
            loadout: 9
            slots: [
                "Talent"
                "Sensor"
                "Gunner"
                "Modification"
            ]
        }
        {
            name: "Imdaar Test Pilot"
            id: 202
            faction: "Galactic Empire"
            ship: "TIE/ph Phantom"
            skill: 3
            points: 5
            loadout: 6
            slots: [
                "Sensor"
                "Gunner"
                "Modification"
            ]
        }
        {
            name: "Captain Jonus"
            id: 203
            unique: true
            faction: "Galactic Empire"
            ship: "TIE/sa Bomber"
            skill: 4
            points: 5
            loadout: 10
            slots: [
                "Talent"
                "Torpedo"
                "Missile"
                "Missile"
                "Gunner"
                "Device"
                "Device"
                "Modification"
            ]
        }
        {
            name: "Major Rhymer"
            id: 204
            unique: true
            faction: "Galactic Empire"
            ship: "TIE/sa Bomber"
            skill: 4
            points: 5
            loadout: 12
            slots: [
                "Talent"
                "Torpedo"
                "Missile"
                "Missile"
                "Gunner"
                "Device"
                "Device"
                "Modification"
            ]
        }
        {
            name: "Tomax Bren"
            id: 205
            unique: true
            faction: "Galactic Empire"
            ship: "TIE/sa Bomber"
            skill: 5
            points: 4
            loadout: 10
            slots: [
                "Talent"
                "Talent"
                "Missile"
                "Missile"
                "Gunner"
                "Device"
                "Device"
                "Modification"
            ]
        }
        {
            name: '"Deathfire"'
            id: 206
            unique: true
            faction: "Galactic Empire"
            ship: "TIE/sa Bomber"
            skill: 2
            points: 4
            loadout: 11
            slots: [
                "Torpedo"
                "Torpedo"
                "Missile"
                "Gunner"
                "Device"
                "Modification"
            ]
        }
        {
            name: "Gamma Squadron Ace"
            id: 207
            faction: "Galactic Empire"
            ship: "TIE/sa Bomber"
            skill: 3
            points: 4
            loadout: 10
            slots: [
                "Torpedo"
                "Gunner"
                "Device"
                "Device"
                "Modification"
            ]
        }
        {
            name: "Scimitar Squadron Pilot"
            id: 208
            faction: "Galactic Empire"
            ship: "TIE/sa Bomber"
            skill: 2
            points: 4
            loadout: 6
            slots: [
                "Missile"
                "Gunner"
                "Device"
                "Device"
                "Modification"
            ]
        }
        {
            name: '"Countdown"'
            id: 209
            unique: true
            faction: "Galactic Empire"
            ship: "TIE/sk Striker"
            skill: 4
            points: 4
            loadout: 8
            slots: [
                "Talent"
                "Talent"
                "Gunner"
                "Device"
                "Modification"
            ]
        }
        {
            name: '"Pure Sabacc"'
            id: 210
            unique: true
            faction: "Galactic Empire"
            ship: "TIE/sk Striker"
            skill: 4
            points: 4
            loadout: 7
            slots: [
                "Talent"
                "Gunner"
                "Device"
                "Modification"
            ]
        }
        {
            name: '"Duchess"'
            id: 211
            unique: true
            faction: "Galactic Empire"
            ship: "TIE/sk Striker"
            skill: 5
            points: 5
            loadout: 15
            slots: [
                "Talent"
                "Talent"
                "Gunner"
                "Device"
                "Modification"
            ]
        }
        {
            name: "Black Squadron Scout"
            id: 212
            faction: "Galactic Empire"
            ship: "TIE/sk Striker"
            skill: 3
            points: 4
            loadout: 5
            slots: [
                "Talent"
                "Gunner"
                "Device"
            ]
        }
        {
            name: "Planetary Sentinel"
            id: 213
            faction: "Galactic Empire"
            ship: "TIE/sk Striker"
            skill: 1
            points: 4
            loadout: 4
            slots: [
                "Gunner"
                "Device"
                "Modification"
            ]
        }
        {
            name: "Rear Admiral Chiraneau"
            id: 214
            unique: true
            faction: "Galactic Empire"
            ship: "VT-49 Decimator"
            skill: 5
            points: 8
            loadout: 26
            slots: [
                "Talent"
                "Torpedo"
                "Crew"
                "Crew"
                "Crew"
                "Gunner"
                "Device"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Captain Oicunn"
            id: 215
            unique: true
            faction: "Galactic Empire"
            ship: "VT-49 Decimator"
            skill: 3
            points: 7
            loadout: 19
            slots: [
                "Talent"
                "Talent"
                "Torpedo"
                "Crew"
                "Crew"
                "Gunner"
                "Device"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Patrol Leader"
            id: 216
            faction: "Galactic Empire"
            ship: "VT-49 Decimator"
            skill: 2
            points: 7
            loadout: 12
            slots: [
                "Torpedo"
                "Crew"
                "Gunner"
                "Device"
                "Modification"
            ]
        }
        {
            name: '"Howlrunner"'
            id: 217
            unique: true
            faction: "Galactic Empire"
            ship: "TIE/ln Fighter"
            skill: 5
            points: 4
            loadout: 8
            slots: [
                "Talent"
                "Talent"
                "Modification"
            ]
        }
        {
            name: "Iden Versio"
            id: 218
            unique: true
            faction: "Galactic Empire"
            ship: "TIE/ln Fighter"
            skill: 4
            charge: 1
            points: 3
            loadout: 8
            slots: [
                "Talent"
                "Talent"
                "Cannon"
                "Missile"
                "Modification"
            ]
        }
        {
            name: '"Mauler" Mithel'
            id: 219
            unique: true
            faction: "Galactic Empire"
            ship: "TIE/ln Fighter"
            skill: 5
            points: 3
            loadout: 4
            slots: [
                "Talent"
                "Cannon"
            ]
        }
        {
            name: '"Scourge" Skutu'
            id: 220
            unique: true
            faction: "Galactic Empire"
            ship: "TIE/ln Fighter"
            skill: 5
            points: 3
            loadout: 3
            slots: [
                "Talent"
            ]
        }
        {
            name: '"Wampa"'
            id: 221
            unique: true
            faction: "Galactic Empire"
            ship: "TIE/ln Fighter"
            skill: 1
            recurring: 1
            charge: 1
            points: 3
            loadout: 5
            slots: [
                "Talent"
                "Modification"
            ]
        }
        {
            name: "Del Meeko"
            id: 222
            unique: true
            faction: "Galactic Empire"
            ship: "TIE/ln Fighter"
            skill: 4
            points: 3
            loadout: 6
            slots: [
                "Talent"
                "Cannon"
            ]
        }
        {
            name: "Gideon Hask"
            id: 223
            unique: true
            faction: "Galactic Empire"
            ship: "TIE/ln Fighter"
            skill: 4
            points: 3
            loadout: 8
            slots: [
                "Talent"
                "Talent"
                "Missile"
                "Modification"
            ]
        }
        {
            name: "Seyn Marana"
            id: 224
            unique: true
            faction: "Galactic Empire"
            ship: "TIE/ln Fighter"
            skill: 4
            points: 3
            loadout: 8
            slots: [
                "Talent"
                "Modification"
            ]
        }
        {
            name: "Valen Rudor"
            id: 225
            unique: true
            faction: "Galactic Empire"
            ship: "TIE/ln Fighter"
            skill: 3
            points: 3
            loadout: 5
            slots: [
                "Talent"
                "Talent"
            ]
        }
        {
            name: '"Night Beast"'
            id: 226
            unique: true
            faction: "Galactic Empire"
            ship: "TIE/ln Fighter"
            skill: 2
            points: 3
            loadout: 4
            slots: [
                "Talent"
                "Talent"
            ]
        }
        {
            name: "Black Squadron Ace"
            id: 227
            faction: "Galactic Empire"
            ship: "TIE/ln Fighter"
            skill: 3
            points: 2
            loadout: 0
            slots: [
            ]
        }
        {
            name: "Obsidian Squadron Pilot"
            id: 228
            faction: "Galactic Empire"
            ship: "TIE/ln Fighter"
            skill: 2
            points: 2
            loadout: 0
            slots: [
            ]
        }
        {
            name: "Academy Pilot"
            id: 229
            faction: "Galactic Empire"
            ship: "TIE/ln Fighter"
            skill: 1
            points: 2
            loadout: 0
            slots: [
            ]
        }
        {
            name: "Spice Runner"
            id: 230
            faction: "Scum and Villainy"
            ship: "HWK-290 Light Freighter"
            skill: 1
            points: 3
            loadout: 4
            slots: [
                "Device"
                "Illicit"
            ]
        }
        {
            name: "Poe Dameron"
            id: 231
            unique: true
            faction: "Resistance"
            ship: "T-70 X-wing"
            skill: 6
            points: 7
            loadout: 25
            charge: 1
            recurring: 1
            slots: [
                "Talent"
                "Astromech"
                "Tech"
                "Torpedo"
                "Modification"
                "Modification"
                "Configuration"
                "Title"
                "HardpointShip"
            ]
        }
        {
            id: 232 # duplicate, has been removed
            skip: true
        }
        {
            name: '"Midnight"'
            id: 233
            unique: true
            faction: "First Order"
            ship: "TIE/fo Fighter"
            skill: 6
            points: 4
            loadout: 15
            slots: [
                "Talent"
                "Talent"
                "Missile"
                "Tech"
                "Modification"
                "Modification"
            ]
        }
        {
            name: '"Longshot"'
            id: 234
            skip: true
            unique: true
            faction: "First Order"
            ship: "TIE/fo Fighter"
            skill: 3
            points: 3
            loadout: 3
            slots: [
                "Talent"
                "Tech"
                "Tech"
                "Modification"
            ]
        }
        {
            name: '"Muse"'
            id: 235
            unique: true
            faction: "First Order"
            ship: "TIE/fo Fighter"
            skill: 2
            points: 3
            loadout: 9
            slots: [
                "Tech"
                "Modification"
            ]
        }
        {
            name: "Kylo Ren"
            id: 236
            unique: true
            faction: "First Order"
            ship: "TIE/vn Silencer"
            skill: 5
            force: 2
            keyword: ["Dark Side"]
            points: 7
            loadout: 16
            applies_condition: '''I'll Show You the Dark Side'''.canonicalize()
            slots: [
                "Force"
                "Tech"
                "Torpedo"
                "Missile"
                "Configuration"
            ]
        }
        {
            name: '"Blackout"'
            id: 237
            unique: true
            faction: "First Order"
            ship: "TIE/vn Silencer"
            skill: 5
            points: 6
            loadout: 20
            slots: [
                "Talent"
                "Tech"
                "Tech"
                "Torpedo"
                "Missile"
                "Configuration"
            ]
        }
        {
            name: "Lieutenant Dormitz"
            id: 238
            unique: true
            faction: "First Order"
            ship: "Upsilon-Class Command Shuttle"
            skill: 2
            points: 8
            loadout: 20
            slots: [
                "Sensor"
                "Sensor"
                "Tech"
                "Tech"
                "Crew"
                "Crew"
                "Crew"
                "Cannon"
                "Modification"
            ]
        }
        {
            name: "L'ulo L'ampar"
            id: 239
            unique: true
            faction: "Resistance"
            ship: "RZ-2 A-wing"
            skill: 5
            points: 4
            loadout: 12
            slots: [
                "Talent"
                "Talent"
                "Tech"
                "Modification"
            ]
        }
        {
            name: "Tallissan Lintra"
            id: 240
            unique: true
            faction: "Resistance"
            ship: "RZ-2 A-wing"
            skill: 5
            charge: 1
            recurring: 1
            points: 4
            loadout: 12
            slots: [
                "Talent"
                "Talent"
                "Talent"
                "Torpedo"
                "Tech"
                "Modification"
            ]
        }
        {
            name: "blanks"
            id: 241
            skip: true
        }
        {
            name: '"Backdraft"'
            id: 242
            unique: true
            faction: "First Order"
            ship: "TIE/sf Fighter"
            skill: 4
            points: 4
            loadout: 12
            slots: [
                "Talent"
                "Sensor"
                "Tech"
                "Missile"
                "Gunner"
                "Modification"
            ]
        }
        {
            name: '"Quickdraw"'
            id: 243
            unique: true
            faction: "First Order"
            ship: "TIE/sf Fighter"
            skill: 6
            charge: 1
            recurring: 1
            points: 6
            loadout: 25
            slots: [
                "Talent"
                "Talent"
                "Tech"
                "Gunner"
                "Sensor"
                "Modification"
            ]
        }
        {
            name: "Rey"
            id: 244
            unique: true
            faction: "Resistance"
            ship: "Scavenged YT-1300"
            keyword: ["Light Side"]
            skill: 5
            points: 8
            loadout: 25
            force: 2
            slots: [
                "Force"
                "Talent"
                "Missile"
                "Crew"
                "Crew"
                "Gunner"
                "Illicit"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Han Solo (Resistance)"
            id: 245
            unique: true
            xws: "hansolo-scavengedyt1300"
            faction: "Resistance"
            ship: "Scavenged YT-1300"
            skill: 6
            points: 6
            loadout: 15
            slots: [
                "Talent"
                "Missile"
                "Crew"
                "Crew"
                "Gunner"
                "Illicit"
                "Illicit"
                "Modification"
                "Modification"
            ]
        }
        {
            name: "Chewbacca (Resistance)"
            id: 246
            unique: true
            faction: "Resistance"
            xws: "chewbacca-scavengedyt1300"
            ship: "Scavenged YT-1300"
            skill: 4
            points: 7
            loadout: 18
            slots: [
                "Talent"
                "Talent"
                "Missile"
                "Crew"
                "Crew"
                "Gunner"
                "Illicit"
                "Illicit"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Captain Seevor"
            id: 247
            unique: true
            faction: "Scum and Villainy"
            ship: "Modified TIE/ln Fighter"
            skill: 3
            charge: 1
            recurring: 1
            points: 4
            loadout: 10
            slots: [
                "Talent"
                "Cannon"
                "Missile"
                "Modification"
            ]
        }
        {
            name: "Mining Guild Surveyor"
            id: 248
            faction: "Scum and Villainy"
            ship: "Modified TIE/ln Fighter"
            skill: 2
            points: 3
            loadout: 1
            slots: [
                "Talent"
            ]
        }
        {
            name: "Ahhav"
            id: 249
            unique: true
            faction: "Scum and Villainy"
            ship: "Modified TIE/ln Fighter"
            skill: 3
            points: 3
            loadout: 8
            slots: [
                "Talent"
                "Illicit"
                "Illicit"
                "Modification"
            ]
        }
        {
            name: "Finch Dallow"
            id: 250
            unique: true
            faction: "Resistance"
            ship: "MG-100 StarFortress"
            skill: 4
            points: 6
            loadout: 14
            slots: [
                "Sensor"
                "Tech"
                "Missile"
                "Crew"
                "Gunner"
                "Gunner"
                "Device"
                "Device"
                "Modification"
            ]
        }
        {
            name: "Major Stridan"
            id: 251
            unique: true
            faction: "First Order"
            ship: "Upsilon-Class Command Shuttle"
            skill: 4
            points: 7
            loadout: 13
            slots: [
                "Tech"
                "Tech"
                "Crew"
                "Crew"
                "Crew"
                "Cannon"
                "Sensor"
                "Modification"
            ]
        }
        {
            name: "Kare Kun"
            id: 252
            unique: true
            faction: "Resistance"
            ship: "T-70 X-wing"
            skill: 4
            points: 5
            loadout: 10
            slots: [
                "Talent"
                "Astromech"
                "Tech"
                "Cannon"
                "Modification"
                "Configuration"
                "HardpointShip"
            ]
        }
        {
            name: "Joph Seastriker"
            id: 253
            unique: true
            faction: "Resistance"
            ship: "T-70 X-wing"
            skill: 3
            points: 5
            loadout: 9
            slots: [
                "Talent"
                "Astromech"
                "Tech"
                "Modification"
                "Configuration"
                "HardpointShip"
            ]
        }
        {
            name: "Lieutenant Bastian"
            id: 254
            unique: true
            faction: "Resistance"
            ship: "T-70 X-wing"
            skill: 2
            points: 5
            loadout: 10
            slots: [
                "Astromech"
                "Tech"
                "Modification"
                "Configuration"
                "HardpointShip"
            ]
        }
        {
            name: "Jaycris Tubbs"
            id: 255
            unique: true
            faction: "Resistance"
            ship: "T-70 X-wing"
            skill: 1
            points: 5
            loadout: 13
            slots: [
                "Astromech"
                "Tech"
                "Modification"
                "Configuration"
                "HardpointShip"
            ]
        }
        {
            name: "Black Squadron Ace (T-70)"
            id: 256
            faction: "Resistance"
            xws: "blacksquadronace-t70xwing"
            ship: "T-70 X-wing"
            skill: 4
            points: 5
            loadout: 10
            slots: [
                "Talent"
                "Astromech"
                "Tech"
                "Modification"
                "Configuration"
                "HardpointShip"
            ]
        }
        {
            name: "Red Squadron Expert"
            id: 257
            faction: "Resistance"
            ship: "T-70 X-wing"
            skill: 3
            points: 5
            loadout: 2
            slots: [
                "Talent"
                "Astromech"
                "Tech"
                "Modification"
                "Configuration"
                "HardpointShip"
            ]
        }
        {
            name: "Blue Squadron Rookie"
            id: 258
            faction: "Resistance"
            ship: "T-70 X-wing"
            skill: 1
            points: 5
            loadout: 4
            slots: [
                "Astromech"
                "Tech"
                "Modification"
                "Configuration"
                "HardpointShip"
            ]
        }
        {
            name: "Zeta Squadron Survivor"
            id: 259
            faction: "First Order"
            ship: "TIE/sf Fighter"
            skill: 2
            points: 4
            loadout: 4
            slots: [
                "Talent"
                "Tech"
                "Gunner"
                "Sensor"
            ]
        }
        {
            name: "Cobalt Squadron Bomber"
            id: 260
            faction: "Resistance"
            ship: "MG-100 StarFortress"
            skill: 1
            points: 6
            loadout: 11
            slots: [
                "Sensor"
                "Tech"
                "Gunner"
                "Gunner"
                "Device"
                "Device"
                "Modification"
            ]
        }
        {
            name: "TN-3465"
            id: 261
            unique: true
            faction: "First Order"
            ship: "TIE/fo Fighter"
            skill: 2
            points: 3
            loadout: 5
            slots: [
                "Tech"
                "Modification"
            ]
        }
        {
            name: '"Scorch"'
            id: 262
            unique: true
            faction: "First Order"
            ship: "TIE/fo Fighter"
            skill: 4
            points: 3
            loadout: 8
            slots: [
                "Talent"
                "Talent"
                "Tech"
                "Modification"
            ]
        }
        {
            name: '"Longshot"'
            id: 263
            unique: true
            faction: "First Order"
            ship: "TIE/fo Fighter"
            skill: 3
            points: 3
            loadout: 8
            slots: [
                "Talent"
                "Tech"
                "Tech"
                "Modification"
            ]
        }
        {
            name: '"Static"'
            id: 264
            unique: true
            faction: "First Order"
            ship: "TIE/fo Fighter"
            skill: 4
            points: 3
            loadout: 8
            slots: [
                "Talent"
                "Talent"
                "Tech" 
                "Cannon"
                "Modification"
            ]
        }
        {
            name: "Lieutenant Rivas"
            id: 265
            unique: true
            faction: "First Order"
            ship: "TIE/fo Fighter"
            skill: 1
            points: 3
            loadout: 4
            slots: [ 
                "Talent"
                "Tech" 
                "Modification"
            ]
        }
        {
            name: "Commander Malarus"
            id: 266
            unique: true
            faction: "First Order"
            ship: "TIE/fo Fighter"
            skill: 5
            points: 3
            loadout: 4
            charge: 2
            slots: [
                "Talent"
                "Talent"
                "Missile"
                "Tech"
                "Modification"
            ]
        }
        {
            name: "Omega Squadron Ace"
            id: 267
            faction: "First Order"
            ship: "TIE/fo Fighter"
            skill: 3
            points: 3
            loadout: 4
            slots: [
                "Talent"
                "Tech"
                "Modification"
                "Modification"
            ]
        }
        {
            name: "Zeta Squadron Pilot"
            id: 268
            faction: "First Order"
            ship: "TIE/fo Fighter"
            skill: 2
            points: 3
            loadout: 3
            slots: [
                "Tech"
                "Modification"
            ]
        }
        {
            name: "Epsilon Squadron Cadet"
            id: 269
            faction: "First Order"
            ship: "TIE/fo Fighter"
            skill: 1
            points: 3
            loadout: 2
            slots: [
                "Tech"
            ]
        }
        {
            name: "Greer Sonnel"
            id: 270
            unique: true
            faction: "Resistance"
            ship: "RZ-2 A-wing"
            skill: 4
            points: 4
            loadout: 7
            slots: [
                "Talent"
                "Missile"
                "Tech"
                "Modification"
            ]
        }
        {
            name: "Zari Bangel"
            id: 271
            unique: true
            faction: "Resistance"
            ship: "RZ-2 A-wing"
            skill: 3
            points: 4
            loadout: 11
            slots: [
                "Talent"
                "Talent"
                "Missile"
                "Tech"
                "Tech"
                "Modification"
            ]
        }
        {
            name: "Darth Maul"
            id: 272
            unique: true
            faction: "Separatist Alliance"
            ship: "Sith Infiltrator"
            skill: 5
            force: 3
            keyword: ["Dark Side","Sith"]
            points: 8
            loadout: 20
            slots: [
                "Force"
                "Force"
                "Cannon"
                "Torpedo"
                "Crew"
                "Crew"
                "Device"
                "Modification"
                "Title"
                "Tactical Relay"
            ]
        }
        {
            name: "Anakin Skywalker"
            id: 273
            unique: true
            faction: "Galactic Republic"
            ship: "Delta-7 Aethersprite"
            skill: 6
            force: 3
            points: 6
            loadout: 10
            keyword: ["Jedi","Light Side"]
            slots: [
                "Force"
                "Force"
                "Talent"
                "Astromech"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Luminara Unduli"
            id: 274
            unique: true
            faction: "Galactic Republic"
            ship: "Delta-7 Aethersprite"
            skill: 4
            force: 2
            points: 4
            loadout: 7
            keyword: ["Jedi","Light Side"]
            slots: [
                "Force"
                "Astromech"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Barriss Offee"
            id: 275
            unique: true
            faction: "Galactic Republic"
            ship: "Delta-7 Aethersprite"
            skill: 4
            force: 1
            points: 4
            loadout: 9
            keyword: ["Jedi","Light Side"]
            slots: [
                "Force"
                "Astromech"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Ahsoka Tano"
            id: 276
            unique: true
            faction: "Galactic Republic"
            ship: "Delta-7 Aethersprite"
            skill: 3
            force: 2
            points: 4
            loadout: 7
            keyword: ["Jedi","Light Side"]
            slots: [
                "Force"
                "Astromech"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Jedi Knight"
            id: 277
            faction: "Galactic Republic"
            ship: "Delta-7 Aethersprite"
            skill: 3
            force: 1
            points: 4
            loadout: 3
            keyword: ["Jedi","Light Side"]
            slots: [
                "Force"
                "Astromech"
                "Configuration"
                "Modification"
            ]
        }
        {
            name: "Obi-Wan Kenobi"
            id: 278
            unique: true
            faction: "Galactic Republic"
            ship: "Delta-7 Aethersprite"
            skill: 5
            force: 3
            points: 5
            loadout: 10
            keyword: ["Jedi","Light Side"]
            slots: [
                "Force"
                "Force"
                "Talent"
                "Astromech"
                "Configuration"
                "Modification"
                "Modification"
            ]
        }
        {
            name: "Trade Federation Drone"
            id: 279
            faction: "Separatist Alliance"
            ship: "Vulture-class Droid Fighter"
            skill: 1
            points: 2
            loadout: 0
            keyword: ["Droid"]
            slots: [
                "Configuration"
                "Modification"
            ]
        }
        {
            name: '"Sinker"'
            id: 280
            unique: true
            faction: "Galactic Republic"
            ship: "ARC-170 Starfighter"
            skill: 3
            points: 6
            loadout: 18
            keyword: ["Clone"]
            slots: [
                "Talent"
                "Torpedo"
                "Crew"
                "Gunner"
                "Gunner"
                "Astromech"
                "Modification"
            ]
        }
        {
            name: "Petty Officer Thanisson"
            id: 281
            unique: true
            faction: "First Order"
            ship: "Upsilon-Class Command Shuttle"
            skill: 1
            points: 7
            loadout: 14
            charge: 1
            recurring: 1
            slots: [
                "Tech"
                "Tech"
                "Crew"
                "Crew"
                "Crew"
                "Cannon"
                "Cannon"
                "Sensor"
                "Modification"
            ]
        }
        {
            name: "Captain Cardinal"
            id: 282
            unique: true
            faction: "First Order"
            ship: "Upsilon-Class Command Shuttle"
            skill: 4
            points: 7
            loadout: 12
            charge: 2
            slots: [
                "Talent"
                "Tech"
                "Tech"
                "Crew"
                "Crew"
                "Crew"
                "Cannon"
                "Sensor"
                "Modification"
            ]
        }
        {
            name: '"Avenger"'
            id: 283
            unique: true
            faction: "First Order"
            ship: "TIE/vn Silencer"
            skill: 3
            points: 5
            loadout: 6
            slots: [
                "Talent"
                "Tech"
                "Torpedo"
                "Missile"
                "Configuration"
            ]
        }
        {
            name: '"Recoil"'
            id: 284
            unique: true
            faction: "First Order"
            ship: "TIE/vn Silencer"
            skill: 4
            points: 5
            loadout: 6
            slots: [
                "Talent"
                "Tech"
                "Torpedo"
                "Missile"
                "Configuration"
            ]
        }
        {
            name: "Omega Squadron Expert"
            id: 285
            faction: "First Order"
            ship: "TIE/sf Fighter"
            skill: 3
            points: 4
            loadout: 10
            slots: [
                "Tech"
                "Missile"
                "Gunner"
                "Sensor"
                "Modification"
            ]
        }
        {
            name: "Sienar-Jaemus Engineer"
            id: 286
            faction: "First Order"
            ship: "TIE/vn Silencer"
            skill: 1
            points: 5
            loadout: 5
            slots: [
                "Tech"
                "Torpedo"
                "Missile"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "First Order Test Pilot"
            id: 287
            faction: "First Order"
            ship: "TIE/vn Silencer"
            skill: 4
            points: 5
            loadout: 5
            slots: [
                "Talent"
                "Tech"
                "Torpedo"
                "Missile"
                "Configuration"
            ]
        }
        {
            name: "Starkiller Base Pilot"
            id: 288
            faction: "First Order"
            ship: "Upsilon-Class Command Shuttle"
            skill: 2
            points: 7
            loadout: 8
            slots: [
                "Tech"
                "Tech"
                "Crew"
                "Crew"
                "Cannon"
                "Sensor"
                "Modification"
            ]
        }
        {
            name: "Lieutenant Tavson"
            id: 289
            unique: true
            faction: "First Order"
            ship: "Upsilon-Class Command Shuttle"
            skill: 3
            charge: 2
            recurring: 1
            points: 8
            loadout: 17
            slots: [
                "Tech"
                "Tech"
                "Crew"
                "Crew"
                "Cannon"
                "Sensor"
                "Modification"
            ]
        }
        {
            name: '"Null"'
            id: 290
            unique: true
            faction: "First Order"
            ship: "TIE/fo Fighter"
            skill: 0
            points: 3
            loadout: 5
            slots: [
                "Talent"
                "Talent"
                "Tech"
                "Tech"
            ]
        }
        {
            name: "Cat"
            id: 291
            unique: true
            faction: "Resistance"
            ship: "MG-100 StarFortress"
            skill: 1
            points: 5
            loadout: 7
            slots: [
                "Talent"
                "Sensor"
                "Tech"
                "Crew"
                "Gunner"
                "Gunner"
                "Device"
                "Device"
                "Modification"
            ]
        }
        {
            name: "Ben Teene"
            id: 292
            unique: true
            faction: "Resistance"
            ship: "MG-100 StarFortress"
            skill: 3
            points: 5
            loadout: 9
            slots: [
                "Sensor"
                "Tech"
                "Tech"
                "Crew"
                "Gunner"
                "Gunner"
                "Device"
                "Device"
                "Modification"
            ]
            applies_condition: 'Rattled'.canonicalize()
        }
        {
            name: "Edon Kappehl"
            id: 293
            unique: true
            faction: "Resistance"
            ship: "MG-100 StarFortress"
            skill: 3
            points: 6
            loadout: 14
            slots: [
                "Sensor"
                "Tech"
                "Cannon"
                "Crew"
                "Gunner"
                "Gunner"
                "Device"
                "Device"
                "Modification"
            ]
        }
        {
            name: "Vennie"
            id: 294
            unique: true
            faction: "Resistance"
            ship: "MG-100 StarFortress"
            skill: 2
            points: 6
            loadout: 14
            slots: [
                "Sensor"
                "Torpedo"
                "Crew"
                "Gunner"
                "Gunner"
                "Device"
                "Device"
                "Modification"
            ]
        }
        {
            name: "Resistance Sympathizer"
            id: 295
            faction: "Resistance"
            ship: "Scavenged YT-1300"
            skill: 2
            points: 6
            loadout: 10
            slots: [
                "Talent"
                "Missile"
                "Gunner"
                "Modification"
                "Modification"
            ]
        }
        {
            name: "Jessika Pava"
            id: 296
            unique: true
            faction: "Resistance"
            ship: "T-70 X-wing"
            skill: 3
            points: 5
            loadout: 11
            charge: 1
            recurring: 1
            slots: [
                "Tech"
                "Astromech"
                "Modification"
                "Configuration"
                "HardpointShip"
            ]
        }
        {
            name: "Temmin Wexley"
            id: 297
            unique: true
            faction: "Resistance"
            ship: "T-70 X-wing"
            skill: 4
            points: 5
            loadout: 11
            slots: [
                "Talent"
                "Tech"
                "Astromech"
                "Modification"
                "Modification"
                "Configuration"
                "HardpointShip"
            ]
        }
        {
            name: "Nien Nunb"
            id: 298
            unique: true
            faction: "Resistance"
            ship: "T-70 X-wing"
            skill: 5
            points: 5
            loadout: 10
            slots: [
                "Talent"
                "Tech"
                "Missile"
                "Astromech"
                "Modification"
                "Configuration"
                "HardpointShip"
            ]
        }
        {
            name: "Ello Asty"
            id: 299
            unique: true
            faction: "Resistance"
            ship: "T-70 X-wing"
            skill: 5
            points: 5
            loadout: 11
            slots: [
                "Talent"
                "Talent"
                "Tech"
                "Astromech"
                "Modification"
                "Configuration"
                "HardpointShip"
            ]
        }
        {
            name: "Green Squadron Expert"
            id: 300
            faction: "Resistance"
            ship: "RZ-2 A-wing"
            skill: 3
            points: 4
            loadout: 2
            slots: [
                "Talent"
                "Talent"
                "Tech"
            ]
        }
        {
            name: "Blue Squadron Recruit"
            id: 301
            faction: "Resistance"
            ship: "RZ-2 A-wing"
            skill: 1
            points: 4
            loadout: 4
            slots: [
                "Talent"
                "Tech"
            ]
        }
        {
            name: "Foreman Proach"
            id: 302
            unique: true
            faction: "Scum and Villainy"
            ship: "Modified TIE/ln Fighter"
            skill: 4
            points: 3
            loadout: 6
            slots: [
                "Talent"
                "Talent"
                "Modification"
            ]
        }
        {
            name: "Overseer Yushyn"
            id: 303
            unique: true
            faction: "Scum and Villainy"
            ship: "Modified TIE/ln Fighter"
            skill: 2
            loadout: 7
            charge: 1
            recurring: 1
            points: 3
            slots: [
                "Talent"
                "Modification"
            ]
        }
        {
            name: "Mining Guild Sentry"
            id: 304
            faction: "Scum and Villainy"
            ship: "Modified TIE/ln Fighter"
            skill: 1
            points: 3
            loadout: 3
            slots: [
                "Illicit"
            ]
        }
        {
            name: "General Grievous"
            id: 305
            faction: "Separatist Alliance"
            ship: "Belbullab-22 Starfighter"
            unique: true
            skill: 4
            points: 5
            loadout: 12
            slots: [
                "Talent"
                "Missile"
                "Modification"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Wat Tambor"
            id: 306
            faction: "Separatist Alliance"
            ship: "Belbullab-22 Starfighter"
            unique: true
            skill: 3
            points: 4
            loadout: 7
            slots: [
                "Talent"
                "Tactical Relay"
                "Modification"
                "Modification"
            ]
        }
        {
            name: "Feethan Ottraw Autopilot"
            id: 307
            faction: "Separatist Alliance"
            ship: "Belbullab-22 Starfighter"
            skill: 1
            points: 4
            loadout: 5
            keyword: ["Droid"]
            slots: [
                "Tactical Relay"
                "Modification"
            ]
        }
        {
            name: "Captain Sear"
            id: 308
            faction: "Separatist Alliance"
            ship: "Belbullab-22 Starfighter"
            unique: true
            skill: 2
            points: 5
            loadout: 15
            slots: [
                "Tactical Relay"
                "Modification"
                "Modification"
            ]
        }
        {
            name: "Precise Hunter"
            id: 309
            faction: "Separatist Alliance"
            ship: "Vulture-class Droid Fighter"
            skill: 3
            points: 3
            loadout: 8
            max_per_squad: 3
            keyword: ["Droid"]
            slots: [
                "Cannon"
                "Configuration"
                "Modification"
            ]
        }
        {
            name: "Haor Chall Prototype"
            id: 310
            faction: "Separatist Alliance"
            ship: "Vulture-class Droid Fighter"
            skill: 1
            points: 2
            loadout: 4
            max_per_squad: 2
            keyword: ["Droid"]
            slots: [
                "Missile"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "DFS-081"
            id: 311
            faction: "Separatist Alliance"
            ship: "Vulture-class Droid Fighter"
            skill: 3
            points: 2
            loadout: 7
            unique: true
            keyword: ["Droid"]
            slots: [
                "Missile"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Plo Koon"
            id: 312
            unique: true
            faction: "Galactic Republic"
            ship: "Delta-7 Aethersprite"
            skill: 5
            force: 2
            points: 5
            loadout: 8
            keyword: ["Jedi","Light Side"]
            slots: [
                "Force"
                "Talent"
                "Astromech"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Saesee Tiin"
            id: 313
            unique: true
            faction: "Galactic Republic"
            ship: "Delta-7 Aethersprite"
            skill: 4
            force: 2
            points: 4
            loadout: 8
            keyword: ["Jedi","Light Side"]
            slots: [
                "Force"
                "Astromech"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Mace Windu"
            id: 314
            unique: true
            faction: "Galactic Republic"
            ship: "Delta-7 Aethersprite"
            skill: 4
            force: 3
            points: 4
            loadout: 7
            keyword: ["Jedi","Light Side"]
            slots: [
                "Force"
                "Force"
                "Astromech"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: '"Kickback"'
            id: 315
            unique: true
            faction: "Galactic Republic"
            ship: "V-19 Torrent Starfighter"
            skill: 4
            points: 3
            loadout: 8
            keyword: ["Clone"]
            slots: [
                "Talent"
                "Missile"
                "Modification"
            ]
        }
        {
            name: '"Odd Ball"'
            id: 316
            unique: true
            faction: "Galactic Republic"
            ship: "V-19 Torrent Starfighter"
            skill: 5
            points: 4
            loadout: 16
            keyword: ["Clone"]
            slots: [
                "Talent"
                "Torpedo"
                "Missile"
                "Modification"
            ]
        }
        {
            name: '"Swoop"'
            id: 317
            unique: true
            faction: "Galactic Republic"
            ship: "V-19 Torrent Starfighter"
            skill: 3
            points: 4
            loadout: 13
            keyword: ["Clone"]
            slots: [
                "Talent"
                "Missile"
                "Missile"
                "Modification"
            ]
        }
        {
            name: '"Axe"'
            id: 318
            unique: true
            faction: "Galactic Republic"
            ship: "V-19 Torrent Starfighter"
            skill: 3
            points: 3
            loadout: 8
            keyword: ["Clone"]
            slots: [
                "Talent"
                "Missile"
                "Modification"
            ]
        }
        {
            name: '"Tucker"'
            id: 319
            unique: true
            faction: "Galactic Republic"
            ship: "V-19 Torrent Starfighter"
            skill: 2
            points: 4
            loadout: 13
            keyword: ["Clone"]
            slots: [
                "Talent"
                "Missile"
                "Missile"
                "Modification"
            ]
        }
        {
            name: "Blue Squadron Protector"
            id: 320
            faction: "Galactic Republic"
            ship: "V-19 Torrent Starfighter"
            skill: 3
            points: 4
            loadout: 4
            keyword: ["Clone"]
            slots: [
                "Missile"
                "Modification"
            ]
        }
        {
            name: "Gold Squadron Trooper"
            id: 321
            faction: "Galactic Republic"
            ship: "V-19 Torrent Starfighter"
            skill: 2
            points: 4
            loadout: 6
            keyword: ["Clone"]
            slots: [
                "Talent"
                "Missile"
                "Modification"
            ]
        }
        {
            name: "Anakin Skywalker (N-1 Starfighter)"
            canonical_name: 'Anakin Skywalker'.canonicalize()
            xws: "anakinskywalker-nabooroyaln1starfighter"
            id: 322
            unique: true
            faction: "Galactic Republic"
            ship: "Naboo Royal N-1 Starfighter"
            skill: 4
            force: 1
            points: 5
            loadout: 20
            keyword: ["Light Side"]
            slots: [
                "Talent"
                "Sensor"
                "Astromech"
                "Torpedo"
            ]
        }
        {
            name: "Bravo Flight Officer"
            id: 323
            faction: "Galactic Republic"
            ship: "Naboo Royal N-1 Starfighter"
            skill: 2
            points: 4
            loadout: 8
            slots: [
                "Sensor"
                "Astromech"
                "Torpedo"
            ]
        }
        {
            name: "Techno Union Bomber"
            id: 324
            faction: "Separatist Alliance"
            ship: "Hyena-class Droid Bomber"
            skill: 1
            points: 3
            loadout: 6
            keyword: ["Droid"]
            slots: [
                "Torpedo"
                "Device"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Bombardment Drone"
            id: 325
            faction: "Separatist Alliance"
            ship: "Hyena-class Droid Bomber"
            skill: 3
            max_per_squad: 3
            keyword: ["Droid"]
            points: 3
            loadout: 8
            slots: [
                "Device"
                "Device"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "DBS-404"
            id: 326
            unique: true
            faction: "Separatist Alliance"
            ship: "Hyena-class Droid Bomber"
            skill: 4
            points: 4
            loadout: 10
            keyword: ["Droid"]
            slots: [
                "Torpedo"
                "Missile"
                "Device"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Separatist Bomber"
            id: 327
            faction: "Separatist Alliance"
            ship: "Hyena-class Droid Bomber"
            skill: 3
            points: 3
            loadout: 4
            keyword: ["Droid"]
            slots: [
                "Missile"
                "Device"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "DBS-32C"
            id: 328
            unique: true
            faction: "Separatist Alliance"
            ship: "Hyena-class Droid Bomber"
            skill: 3
            points: 4
            loadout: 16
            keyword: ["Droid"]
            slots: [
                "Sensor"
                "Tactical Relay"
                "Modification"
                "Configuration"
            ]
            ship_override:
                actions: [
                    "Calculate"
                    "Lock"
                    "Barrel Roll"
                    "R-> Lock"
                    "R-Jam"
                ]
        }
        {
            name: "Baktoid Prototype"
            id: 329
            max_per_squad: 2
            faction: "Separatist Alliance"
            ship: "Hyena-class Droid Bomber"
            skill: 1
            points: 3
            loadout: 9
            keyword: ["Droid"]
            slots: [
                "Sensor"
                "Missile"
                "Missile"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Naboo Handmaiden"
            id: 330
            max_per_squad: 2
            faction: "Galactic Republic"
            ship: "Naboo Royal N-1 Starfighter"
            skill: 1
            points: 4
            loadout: 8
            applies_condition: '''Decoyed'''.canonicalize()
            slots: [
                "Sensor"
                "Astromech"
                "Modification"
            ]
        }
        {
            name: "Dineé Ellberger"
            id: 331
            xws: "dineeellberger"
            unique: true
            faction: "Galactic Republic"
            ship: "Naboo Royal N-1 Starfighter"
            skill: 3
            points: 4
            loadout: 14
            slots: [
                "Talent"
                "Sensor"
                "Astromech"
                "Torpedo"
            ]
        }
        {
            name: "Padmé Amidala"
            id: 332
            xws: "padmeamidala"
            unique: true
            faction: "Galactic Republic"
            ship: "Naboo Royal N-1 Starfighter"
            skill: 4
            points: 5
            loadout: 22
            slots: [
                "Talent"
                "Sensor"
                "Astromech"
                "Torpedo"
            ]
        }
        {
            name: "Ric Olié"
            id: 333
            xws: "ricolie"
            unique: true
            faction: "Galactic Republic"
            ship: "Naboo Royal N-1 Starfighter"
            skill: 5
            points: 5
            loadout: 15
            slots: [
                "Talent"
                "Sensor"
                "Astromech"
                "Torpedo"
            ]
        }
        {
            name: "Count Dooku"
            id: 334
            unique: true
            faction: "Separatist Alliance"
            ship: "Sith Infiltrator"
            skill: 3
            force: 3
            points: 7
            loadout: 24
            keyword: ["Dark Side","Sith"]
            slots: [
                "Force"
                "Cannon"
                "Torpedo"
                "Crew"
                "Crew"
                "Device"
                "Modification"
                "Title"
                "Tactical Relay"
            ]
        }
        {
            name: "0-66"
            id: 335
            unique: true
            faction: "Separatist Alliance"
            ship: "Sith Infiltrator"
            skill: 3
            points: 6
            loadout: 16
            keyword: ["Droid"]
            slots: [
                "Talent"
                "Cannon"
                "Torpedo"
                "Crew"
                "Device"
                "Modification"
            ]
        }
        {
            name: "Dark Courier"
            id: 336
            faction: "Separatist Alliance"
            ship: "Sith Infiltrator"
            skill: 2
            points: 6
            loadout: 9
            slots: [
                "Cannon"
                "Torpedo"
                "Device"
                "Modification"
            ]
        }
        {
            name: "DFS-311"
            id: 337
            faction: "Separatist Alliance"
            ship: "Vulture-class Droid Fighter"
            skill: 1
            points: 3
            loadout: 10
            unique: true
            keyword: ["Droid"]
            slots: [
                "Missile"
                "Modification"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: '"Odd Ball" (ARC-170)'
            id: 338
            xws: "oddball-arc170starfighter"
            canonical_name: '"Odd Ball"'.canonicalize()
            unique: true
            faction: "Galactic Republic"
            ship: "ARC-170 Starfighter"
            skill: 5
            points: 5
            loadout: 15
            keyword: ["Clone"]
            slots: [
                "Talent"
                "Sensor"
                "Torpedo"
                "Torpedo"
                "Gunner"
                "Gunner"
                "Astromech"
                "Modification"
            ]
        }
        {
            name: '"Jag"'
            id: 339
            unique: true
            faction: "Galactic Republic"
            ship: "ARC-170 Starfighter"
            skill: 3
            points: 5
            loadout: 14
            keyword: ["Clone"]
            slots: [
                "Talent"
                "Torpedo"
                "Gunner"
                "Gunner"
                "Astromech"
                "Modification"
                "Modification"
            ]
        }
        {
            name: "Squad Seven Veteran"
            id: 340
            faction: "Galactic Republic"
            ship: "ARC-170 Starfighter"
            skill: 3
            points: 5
            loadout: 10
            keyword: ["Clone"]
            slots: [
                "Talent"
                "Gunner"
                "Gunner"
                "Astromech"
                "Modification"
            ]
        }
        {
            name: "104th Battalion Pilot"
            id: 341
            faction: "Galactic Republic"
            ship: "ARC-170 Starfighter"
            skill: 2
            points: 5
            loadout: 8
            keyword: ["Clone"]
            slots: [
                "Torpedo"
                "Gunner"
                "Gunner"
                "Astromech"
                "Modification"
            ]
        }
        {
            name: '"Wolffe"'
            id: 342
            unique: true
            faction: "Galactic Republic"
            ship: "ARC-170 Starfighter"
            skill: 4
            charge: 1
            points: 5
            loadout: 12
            keyword: ["Clone"]
            slots: [
                "Talent"
                "Torpedo"
                "Gunner"
                "Gunner"
                "Astromech"
                "Modification"
            ]
        }
        {
            name: "Separatist Drone"
            id: 343
            faction: "Separatist Alliance"
            ship: "Vulture-class Droid Fighter"
            skill: 3
            points: 2
            loadout: 3
            keyword: ["Droid"]
            slots: [
                "Missile"
                "Configuration"
                "Modification"
            ]
        }
        {
            name: "Skakoan Ace"
            id: 344
            faction: "Separatist Alliance"
            ship: "Belbullab-22 Starfighter"
            skill: 3
            points: 4
            loadout: 4
            slots: [
                "Talent"
                "Modification"
                "Modification"
            ]
        }
        {
            name: "Rose Tico"
            id: 345
            unique: true
            faction: "Resistance"
            ship: "Resistance Transport Pod"
            skill: 3
            points: 3
            loadout: 8
            slots: [
                "Talent"
                "Tech"
                "Crew"
                "Modification"
                "Modification"
            ]
        }
        {
            name: "Logistics Division Pilot"
            id: 346
            faction: "Resistance"
            ship: "Resistance Transport"
            skill: 1
            points: 4
            loadout: 6
            slots: [
                "Cannon"
                "Crew"
                "Astromech"
                "Astromech"
            ]
        }
        {
            name: "Pammich Nerro Goode"
            id: 347
            unique: true
            faction: "Resistance"
            ship: "Resistance Transport"
            skill: 3
            points: 4
            loadout: 12
            slots: [
                "Tech"
                "Sensor"
                "Cannon"
                "Cannon"
                "Torpedo"
                "Crew"
                "Crew"
                "Astromech"
                "Modification"
            ]
        }
        {
            name: "Vi Moradi"
            id: 348
            unique: true
            faction: "Resistance"
            ship: "Resistance Transport Pod"
            skill: 1
            points: 3
            loadout: 6
            applies_condition: '''Compromising Intel'''.canonicalize()
            slots: [
                "Tech"
                "Crew"
                "Modification"
            ]
        }
        {
            name: "BB-8"
            id: 349
            unique: true
            faction: "Resistance"
            ship: "Resistance Transport Pod"
            skill: 3
            points: 2
            loadout: 4
            keyword: ["Droid"]
            slots: [
                "Tech"
                "Tech"
                "Crew"
                "Modification"
            ]
        }
        {
            name: "Finn"
            id: 350
            unique: true
            faction: "Resistance"
            ship: "Resistance Transport Pod"
            skill: 2
            points: 3
            loadout: 12
            slots: [
                "Talent"
                "Talent"
                "Tech"
                "Crew"
                "Modification"
            ]
        }
        {
            name: "Cova Nell"
            id: 351
            unique: true
            faction: "Resistance"
            ship: "Resistance Transport"
            skill: 4
            points: 5
            loadout: 20
            slots: [
                "Talent"
                "Tech"
                "Cannon"
                "Cannon"
                "Torpedo"
                "Crew"
                "Crew"
                "Astromech"
                "Modification"
            ]
        }
        {
            name: "Nodin Chavdri"
            id: 352
            unique: true
            faction: "Resistance"
            ship: "Resistance Transport"
            skill: 2
            points: 5
            loadout: 20
            slots: [
                "Tech"
                "Cannon"
                "Cannon"
                "Torpedo"
                "Missile"
                "Crew"
                "Astromech"
                "Modification"
            ]
        }
        {
            name: "Stalgasin Hive Guard"
            id: 353
            faction: "Separatist Alliance"
            ship: "Nantex-Class Starfighter"
            skill: 3
            points: 4
            loadout: 4
            slots: [
                "Talent"
            ]
        }
        {
            name: "Petranaki Arena Ace"
            id: 354
            faction: "Separatist Alliance"
            ship: "Nantex-Class Starfighter"
            skill: 4
            points: 4
            loadout: 6
            slots: [
                "Talent"
                "Talent"
            ]
        }
        {
            name: "Gorgol"
            unique: true
            id: 355
            faction: "Separatist Alliance"
            ship: "Nantex-Class Starfighter"
            skill: 2
            points: 4
            loadout: 9
            slots: [
                "Talent"
                "Modification"
            ]
        }
        {
            name: "Chertek"
            unique: true
            id: 356
            faction: "Separatist Alliance"
            ship: "Nantex-Class Starfighter"
            skill: 4
            points: 5
            loadout: 15
            slots: [
                "Talent"
                "Talent"
            ]
        }
        {
            name: "Sun Fac"
            unique: true
            id: 357
            faction: "Separatist Alliance"
            ship: "Nantex-Class Starfighter"
            skill: 6
            points: 6
            loadout: 18
            slots: [
                "Talent"
                "Talent"
                "Talent"
                "Modification"
            ]
        }
        {
            name: "Berwer Kret"
            unique: true
            id: 358
            faction: "Separatist Alliance"
            ship: "Nantex-Class Starfighter"
            skill: 5
            points: 4
            loadout: 7
            slots: [
                "Talent"
                "Talent"
            ]
        }
        {
            name: "Anakin Skywalker (Y-Wing)"
            canonical_name: 'Anakin Skywalker'.canonicalize()
            xws: "anakinskywalker-btlbywing"
            unique: true
            id: 359
            faction: "Galactic Republic"
            ship: "BTL-B Y-wing"
            skill: 6
            force: 3
            points: 6
            loadout: 23
            keyword: ["Jedi", "Light Side"]
            slots: [
                "Force"
                "Turret"
                "Torpedo"
                "Gunner"
                "Astromech"
                "Device"
                "Modification"
            ]
        }
        {
            name: "Shadow Squadron Veteran"
            id: 360
            faction: "Galactic Republic"
            ship: "BTL-B Y-wing"
            skill: 3
            points: 4
            loadout: 4
            keyword: ["Clone"]
            slots: [
                "Turret"
                "Torpedo"
                "Gunner"
                "Astromech"
                "Device"
                "Modification"
            ]
        }
        {
            name: "Red Squadron Bomber"
            id: 361
            faction: "Galactic Republic"
            ship: "BTL-B Y-wing"
            skill: 2
            points: 4
            loadout: 6
            keyword: ["Clone"]
            slots: [
                "Turret"
                "Torpedo"
                "Gunner"
                "Astromech"
                "Device"
            ]
        }
        {
            name: "R2-D2"
            id: 362
            unique: true
            faction: "Galactic Republic"
            ship: "BTL-B Y-wing"
            skill: 2
            points: 4
            loadout: 14
            keyword: ["Droid"]
            slots: [
                "Sensor"
                "Turret"
                "Torpedo"
                "Gunner"
                "Crew"
                "Device"
                "Device"
                "Modification"
            ]
        }
        {
            name: '"Goji"'
            id: 363
            unique: true
            faction: "Galactic Republic"
            ship: "BTL-B Y-wing"
            skill: 2
            points: 4
            loadout: 12
            keyword: ["Clone"]
            slots: [
                "Talent"
                "Turret"
                "Gunner"
                "Astromech"
                "Device"
                "Device"
                "Device"
                "Modification"
            ]
        }
        {
            name: '"Broadside"'
            id: 364
            unique: true
            faction: "Galactic Republic"
            ship: "BTL-B Y-wing"
            skill: 3
            points: 4
            loadout: 13
            keyword: ["Clone"]
            slots: [
                "Talent"
                "Turret"
                "Torpedo"
                "Gunner"
                "Astromech"
                "Device"
                "Modification"
            ]
        }
        {
            name: '"Matchstick"'
            id: 365
            unique: true
            faction: "Galactic Republic"
            ship: "BTL-B Y-wing"
            skill: 4
            points: 5
            loadout: 18
            keyword: ["Clone"]
            slots: [
                "Talent"
                "Turret"
                "Torpedo"
                "Gunner"
                "Astromech"
                "Device"
                "Modification"
            ]
        }
        {
            name: '"Odd Ball" (Y-Wing)'
            xws: "oddball-btlbywing"
            id: 366
            unique: true
            canonical_name: '"Odd Ball"'.canonicalize()
            faction: "Galactic Republic"
            ship: "BTL-B Y-wing"
            skill: 5
            points: 4
            loadout: 15
            keyword: ["Clone"]
            slots: [
                "Talent"
                "Turret"
                "Torpedo"
                "Torpedo"
                "Gunner"
                "Astromech"
                "Modification"
            ]
        }
        {
            name: "Republic Judiciary"
            id: 367
            faction: "Galactic Republic"
            ship: "CR90 Corellian Corvette"
            skill: 8
            engagement: 0
            points: 0
            loadout: 99
            slots: [
                "Command"
                "Hardpoint"
                "Hardpoint"
                "Crew"
                "Crew"
                "Gunner"
                "Team"
                "Team"
                "Cargo"
            ]
        }
        {
            name: "Alderaanian Guard"
            id: 368
            faction: "Rebel Alliance"
            ship: "CR90 Corellian Corvette"
            skill: 8
            engagement: 0
            points: 0
            loadout: 99
            slots: [
                "Command"
                "Hardpoint"
                "Hardpoint"
                "Crew"
                "Crew"
                "Gunner"
                "Team"
                "Team"
                "Cargo"
                "Title"
            ]
        }
        {
            name: "Outer Rim Patrol"
            id: 369
            faction: "Galactic Empire"
            ship: "Raider-class Corvette"
            skill: 8
            engagement: 0
            points: 0
            loadout: 99
            slots: [
                "Command"
                "Torpedo"
                "Missile"
                "Hardpoint"
                "Hardpoint"
                "Crew"
                "Crew"
                "Team"
                "Team"
                "Cargo"
                "Title"
            ]
        }
        {
            name: "First Order Collaborators"
            id: 370
            faction: "First Order"
            ship: "Raider-class Corvette"
            skill: 8
            engagement: 0
            points: 0
            loadout: 99
            slots: [
                "Command"
                "Torpedo"
                "Missile"
                "Hardpoint"
                "Hardpoint"
                "Crew"
                "Crew"
                "Team"
                "Team"
                "Cargo"
            ]
        }
        {
            name: "Echo Base Evacuees"
            id: 371
            faction: "Rebel Alliance"
            ship: "GR-75 Medium Transport"
            skill: 7
            engagement: 1
            points: 0
            loadout: 99
            slots: [
                "Command"
                "Hardpoint"
                "Turret"
                "Crew"
                "Crew"
                "Team"
                "Cargo"
                "Cargo"
                "Title"
            ]
        }
        {
            name: "New Republic Volunteers"
            id: 372
            faction: "Resistance"
            ship: "GR-75 Medium Transport"
            skill: 7
            engagement: 1
            points: 0
            loadout: 99
            slots: [
                "Command"
                "Hardpoint"
                "Turret"
                "Crew"
                "Crew"
                "Team"
                "Cargo"
                "Cargo"
            ]
        }
        {
            name: "Outer Rim Garrison"
            id: 373
            faction: "Galactic Empire"
            ship: "Gozanti-class Cruiser"
            skill: 7
            engagement: 1
            points: 0
            loadout: 99
            slots: [
                "Command"
                "Hardpoint"
                "Crew"
                "Crew"
                "Gunner"
                "Team"
                "Cargo"
                "Cargo"
                "Title"
            ]
        }
        {
            name: "First Order Sympathizers"
            id: 374
            faction: "First Order"
            ship: "Gozanti-class Cruiser"
            skill: 7
            engagement: 1
            points: 0
            loadout: 99
            slots: [
                "Command"
                "Hardpoint"
                "Crew"
                "Crew"
                "Gunner"
                "Team"
                "Cargo"
                "Cargo"
            ]
        }
        {
            name: "Separatist Privateers"
            id: 375
            faction: "Separatist Alliance"
            ship: "C-ROC Cruiser"
            skill: 7
            engagement: 1
            points: 0
            loadout: 99
            slots: [
                "Command"
                "Hardpoint"
                "Crew"
                "Crew"
                "Tactical Relay"
                "Team"
                "Cargo"
                "Device"
                "Configuration"
            ]
        }
        {
            name: "Syndicate Smugglers"
            id: 376
            faction: "Scum and Villainy"
            ship: "C-ROC Cruiser"
            skill: 7
            engagement: 1
            points: 0
            loadout: 99
            slots: [
                "Command"
                "Hardpoint"
                "Crew"
                "Crew"
                "Team"
                "Cargo"
                "Device"
                "Illicit"
                "Title"
                "Configuration"
            ]
        }
        {
            name: "Jarek Yeager"
            id: 377
            faction: "Resistance"
            unique: true
            ship: "Fireball"
            skill: 5
            points: 3
            loadout: 9
            slots: [
                "Talent"
                "Talent"
                "Missile"
                "Astromech"
                "Illicit"
                "Modification"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Kazuda Xiono"
            id: 378
            faction: "Resistance"
            unique: true
            ship: "Fireball"
            skill: 4
            points: 4
            loadout: 14
            slots: [
                "Talent"
                "Missile"
                "Astromech"
                "Illicit"
                "Modification"
                "Modification"
                "Title"
            ]
        }
        {
            name: "R1-J5"
            id: 379
            faction: "Resistance"
            unique: true
            ship: "Fireball"
            skill: 1
            points: 3
            loadout: 8
            keyword: ["Droid"]
            slots: [
                "Missile"
                "Crew"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Colossus Station Mechanic"
            id: 380
            faction: "Resistance"
            ship: "Fireball"
            skill: 2
            points: 3
            loadout: 5
            slots: [
                "Missile"
                "Modification"
            ]
        }
        {
            name: "Major Vonreg"
            id: 381
            faction: "First Order"
            unique: true
            skill: 6
            ship: "TIE/ba Interceptor"
            points: 6
            loadout: 18
            slots: [
                "Talent"
                "Talent"
                "Tech"
                "Missile"
                "Modification"
                "Modification"
            ]
        }
        {
            name: '"Holo"'
            id: 382
            faction: "First Order"
            unique: true
            skill: 5
            ship: "TIE/ba Interceptor"
            points: 5
            loadout: 12
            slots: [
                "Talent"
                "Tech"
                "Missile"
                "Modification"
                "Modification"
            ]
        }
        {
            name: '"Ember"'
            id: 383
            faction: "First Order"
            unique: true
            skill: 4
            ship: "TIE/ba Interceptor"
            points: 4
            loadout: 7
            slots: [
                "Talent"
                "Talent"
                "Tech"
                "Missile"
                "Modification"
            ]
        }
        {
            name: "First Order Provocateur"
            id: 384
            faction: "First Order"
            skill: 3
            ship: "TIE/ba Interceptor"
            points: 5
            loadout: 3
            slots: [
                "Talent"
                "Tech"
                "Modification"
            ]
        }
        {
            name: "Captain Phasma"
            id: 385
            faction: "First Order"
            unique: true
            skill: 4
            ship: "TIE/sf Fighter"
            points: 4
            loadout: 14
            slots: [
                "Talent"
                "Sensor"
                "Tech"
                "Missile"
                "Gunner"
                "Modification"
                "Modification"
            ]
        }
        {
            name: '"Rush"'
            id: 386
            faction: "First Order"
            unique: true
            skill: 2
            ship: "TIE/vn Silencer"
            points: 5
            loadout: 7
            slots: [
                "Talent"
                "Talent"
                "Tech"
                "Missile"
                "Configuration"
            ]
        }
        {
            name: "Zizi Tlo"
            id: 387
            faction: "Resistance"
            unique: true
            skill: 5
            charge: 1
            recurring: 1
            ship: "RZ-2 A-wing"
            points: 5
            loadout: 15
            slots: [
                "Talent"
                "Talent"
                "Missile"
                "Tech"
                "Modification"
            ]
        }
        {
            name: "Ronith Blario"
            id: 388
            faction: "Resistance"
            unique: true
            skill: 2
            ship: "RZ-2 A-wing"
            points: 4
            loadout: 10
            slots: [
                "Talent"
                "Missile"
                "Tech"
                "Modification"
            ]
        }
        {
            name: "Paige Tico"
            id: 389
            faction: "Resistance"
            unique: true
            skill: 5
            ship: "MG-100 StarFortress"
            points: 6
            loadout: 15
            charge: 1
            recurring: 1
            slots: [
                "Talent"
                "Sensor"
                "Tech"
                "Crew"
                "Gunner"
                "Device"
                "Device"
                "Modification"
            ]
        }
        {
            name: "K-2SO"
            id: 390
            faction: "Rebel Alliance"
            unique: true
            skill: 3
            ship: "UT-60D U-wing"
            points: 5
            loadout: 10
            keyword: ["Droid"]
            slots: [
                "Sensor"
                "Crew"
                "Crew"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Gina Moonsong"
            id: 391
            faction: "Rebel Alliance"
            unique: true
            skill: 5
            ship: "A/SF-01 B-wing"
            points: 5
            loadout: 16
            slots: [
                "Talent"
                "Sensor"
                "Cannon"
                "Cannon"
                "Torpedo"
                "Device"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Alexsandr Kallus"
            id: 392
            faction: "Rebel Alliance"
            unique: true
            skill: 4
            ship: "VCX-100 Light Freighter"
            points: 7
            loadout: 16
            keyword: ["Spectre"]
            slots: [
                "Talent"
                "Torpedo"
                "Sensor"
                "Turret"
                "Crew"
                "Crew"
                "Modification"
                "Gunner"
                "Title"
            ]
        }
        {
            name: "Leia Organa"
            id: 393
            faction: "Rebel Alliance"
            unique: true
            skill: 5
            ship: "Modified YT-1300 Light Freighter"
            keyword: ["Light Side"]
            points: 8
            loadout: 24
            force: 1
            slots: [
                "Force"
                "Missile"
                "Gunner"
                "Crew"
                "Crew"
                "Modification"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Fifth Brother"
            id: 394
            faction: "Galactic Empire"
            unique: true
            skill: 4
            keyword: ["Dark Side"]
            ship: "TIE Advanced v1"
            points: 5
            loadout: 10
            force: 2
            slots: [
                "Force"
                "Talent"
                "Sensor"
                "Cannon"
            ]
        }
        {
            name: '"Vagabond"'
            id: 395
            faction: "Galactic Empire"
            unique: true
            skill: 2
            ship: "TIE/sk Striker"
            points: 4
            loadout: 10
            slots: [
                "Talent"
                "Gunner"
                "Device"
                "Device"
                "Modification"
            ]
        }
        {
            name: "Morna Kee"
            id: 396
            faction: "Galactic Empire"
            unique: true
            skill: 4
            ship: "VT-49 Decimator"
            points: 7
            loadout: 22
            charge: 3
            slots: [
                "Talent"
                "Torpedo"
                "Crew"
                "Crew"
                "Gunner"
                "Device"
                "Modification"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Lieutenant LeHuse"
            id: 397
            faction: "First Order"
            unique: true
            skill: 5
            ship: "TIE/sf Fighter"
            points: 5
            loadout: 18
            slots: [
                "Talent"
                "Tech"
                "Missile"
                "Missile"
                "Gunner"
                "Sensor"
                "Modification"
            ]
        }
        {
            name: "Bossk (Z-95 Headhunter)"
            xws: "bossk-z95af4headhunter"
            canonical_name: 'Bossk'.canonicalize()
            id: 398
            faction: "Scum and Villainy"
            unique: true
            skill: 4
            ship: "Z-95-AF4 Headhunter"
            points: 3
            loadout: 10
            keyword: ["Bounty Hunter"]
            chassis: "Pursuit Craft"
            slots: [
                "Talent"
                "Talent"
                "Missile"
                "Illicit"
                "Modification"
            ]
        }
        {
            name: "G4R-GOR V/M"
            id: 399
            faction: "Scum and Villainy"
            unique: true
            skill: 0
            ship: "M3-A Interceptor"
            points: 3
            loadout: 6
            keyword: ["Droid"]
            slots: [
                "Modification"
                "HardpointShip"
            ]
        }
        {
            name: "Nom Lumb"
            id: 400
            faction: "Scum and Villainy"
            unique: true
            skill: 1
            ship: "JumpMaster 5000"
            points: 5
            loadout: 11
            keyword: ["Bounty Hunter"]
            slots: [
                "Cannon"
                "Cannon"
                "Torpedo"
                "Crew"
                "Gunner"
                "Illicit"
                "Modification"
            ]
        }
        {
            name: "First Order Courier"
            id: 401
            faction: "First Order"
            skill: 2
            ship: "Xi-class Light Shuttle"
            points: 4
            loadout: 10
            slots: [
                "Tech"
                "Tech"
                "Crew"
                "Modification"
            ]
        }
        {
            name: "Agent Terex"
            id: 402
            faction: "First Order"
            unique: true
            skill: 3
            ship: "Xi-class Light Shuttle"
            points: 4
            loadout: 13
            slots: [
                "Talent"
                "Tech"
                "Tech"
                "Crew"
                "Illicit"
                "Illicit"
                "Illicit"
                "Modification"
            ]
        }
        {
            name: "Gideon Hask (Xi Shuttle)"
            canonical_name: "Gideon Hask".canonicalize()
            xws: "gideonhask-xiclasslightshuttle"
            id: 403
            faction: "First Order"
            unique: true
            skill: 4
            ship: "Xi-class Light Shuttle"
            points: 4
            loadout: 15
            slots: [
                "Talent"
                "Talent"
                "Tech"
                "Tech"
                "Crew"
                "Crew"
                "Modification"
            ]
        }
        {
            name: "Commander Malarus (Xi Shuttle)"
            canonical_name: "Commander Malarus".canonicalize()
            xws: "commandermalarus-xiclasslightshuttle"
            id: 404
            faction: "First Order"
            unique: true
            skill: 5
            ship: "Xi-class Light Shuttle"
            points: 4
            loadout: 15
            slots: [
                "Talent"
                "Tech"
                "Tech"
                "Crew"
                "Crew"
                "Modification"
                "Modification"
            ]
        }
        {
            name: "Baktoid Drone"
            id: 405
            faction: "Separatist Alliance"
            skill: 1
            ship: "HMP Droid Gunship"
            points: 5
            loadout: 10
            keyword: ["Droid"]
            slots: [
                "Missile"
                "Device"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "TransGalMeg Control Link"
            id: 406
            faction: "Galactic Republic"
            skill: "*"
            ship: "Syliure-class Hyperspace Ring"
            points: 2
            slots: [
                "Hyperdrive"
            ]
        }
        {
            name: "Separatist Predator"
            id: 407
            faction: "Separatist Alliance"
            skill: 3
            ship: "HMP Droid Gunship"
            points: 5
            loadout: 8
            keyword: ["Droid"]
            slots: [
                "Missile"
                "Missile"
                "Device"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Geonosian Prototype"
            id: 408
            faction: "Separatist Alliance"
            skill: 2
            max_per_squad: 2
            ship: "HMP Droid Gunship"
            points: 5
            loadout: 18
            keyword: ["Droid"]
            slots: [
                "Missile"
                "Missile"
                "Cannon"
                "Cannon"
                "Tactical Relay"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "DGS-047"
            id: 409
            faction: "Separatist Alliance"
            skill: 1
            unique: true
            ship: "HMP Droid Gunship"
            points: 5
            loadout: 14
            keyword: ["Droid"]
            slots: [
                "Missile"
                "Missile"
                "Tactical Relay"
                "Crew"
                "Device"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "DGS-286"
            id: 410
            faction: "Separatist Alliance"
            skill: 3
            unique: true
            ship: "HMP Droid Gunship"
            points: 5
            loadout: 20
            keyword: ["Droid"]
            slots: [
                "Torpedo"
                "Torpedo"
                "Tactical Relay"
                "Crew"
                "Device"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Onderon Oppressor"
            id: 411
            faction: "Separatist Alliance"
            skill: 3
            max_per_squad: 2
            ship: "HMP Droid Gunship"
            points: 4
            loadout: 7
            keyword: ["Droid"]
            slots: [
                "Missile"
                "Crew"
                "Device"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "212th Battalion Pilot"
            id: 412
            faction: "Galactic Republic"
            skill: 2
            charge: 2
            recurring: 1
            ship: "LAAT/i Gunship"
            points: 5
            loadout: 7
            keyword: ["Clone"]
            slots: [
                "Missile"
                "Missile"
                "Crew"
                "Crew"
                "Gunner"
                "Gunner"
                "Modification"
            ]
        }
        {
            name: '"Hound"'
            id: 413
            faction: "Galactic Republic"
            skill: 2
            unique: true
            charge: 2
            recurring: 1
            ship: "LAAT/i Gunship"
            points: 6
            loadout: 20
            keyword: ["Clone"]
            slots: [
                "Sensor"
                "Missile"
                "Missile"
                "Crew"
                "Crew"
                "Gunner"
                "Gunner"
                "Modification"
            ]
        }
        {
            name: '"Warthog"'
            id: 414
            faction: "Galactic Republic"
            skill: 3
            unique: true
            charge: 2
            recurring: 1
            ship: "LAAT/i Gunship"
            points: 6
            loadout: 18
            keyword: ["Clone"]
            slots: [
                "Talent"
                "Torpedo"
                "Missile"
                "Crew"
                "Crew"
                "Gunner"
                "Gunner"
                "Modification"
            ]
        }
        {
            name: '"Hawk"'
            id: 415
            faction: "Galactic Republic"
            skill: 4
            charge: 2
            recurring: 1
            unique: true
            ship: "LAAT/i Gunship"
            points: 5
            loadout: 12
            keyword: ["Clone"]
            slots: [
                "Talent"
                "Missile"
                "Missile"
                "Crew"
                "Crew"
                "Gunner"
                "Gunner"
                "Modification"
            ]
        }
        {
            name: "Carida Academy Cadet"
            id: 416
            faction: "Galactic Empire"
            skill: 1
            ship: "TIE/rb Heavy"
            points: 5
            loadout: 8
            slots: [
                "Cannon"
                "Cannon"
                "Configuration"
            ]
        }
        {
            name: "Onyx Squadron Sentry"
            id: 417
            faction: "Galactic Empire"
            skill: 3
            ship: "TIE/rb Heavy"
            points: 5
            loadout: 7
            slots: [
                "Cannon"
                "Cannon"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Lyttan Dree"
            id: 418
            faction: "Galactic Empire"
            skill: 3
            unique: true
            ship: "TIE/rb Heavy"
            points: 5
            loadout: 14
            slots: [
                "Sensor"
                "Cannon"
                "Cannon"
                "Gunner"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: '"Rampage"'
            id: 419
            faction: "Galactic Empire"
            skill: 4
            unique: true
            ship: "TIE/rb Heavy"
            points: 5
            loadout: 16
            slots: [
                "Talent"
                "Cannon"
                "Cannon"
                "Gunner"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Fearsome Predator"
            id: 420
            faction: "Separatist Alliance"
            max_per_squad: 3
            skill: 3
            ship: "Droid Tri-fighter"
            points: 4
            loadout: 16
            slots: [
                "Talent"
                "Sensor"
                "Missile"
                "Modification"
                "Modification"
                "Configuration"
            ]
            applies_condition: '''Fearful Prey'''.canonicalize()
        }
        {
            name: "DIS-347"
            id: 421
            faction: "Separatist Alliance"
            skill: 3
            unique: true
            ship: "Droid Tri-fighter"
            points: 4
            loadout: 14
            slots: [
                "Talent"
                "Sensor"
                "Missile"
                "Modification"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "DIS-T81"
            id: 422
            faction: "Separatist Alliance"
            skill: 4
            unique: true
            ship: "Droid Tri-fighter"
            points: 4
            loadout: 12
            slots: [
                "Talent"
                "Sensor"
                "Cannon"
                "Modification"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Phlac-Arphocc Prototype"
            id: 423
            faction: "Separatist Alliance"
            skill: 5
            max_per_squad: 2
            ship: "Droid Tri-fighter"
            points: 4
            loadout: 14
            slots: [
                "Talent"
                "Sensor"
                "Missile"
                "Modification"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Colicoid Interceptor"
            id: 424
            faction: "Separatist Alliance"
            skill: 1
            ship: "Droid Tri-fighter"
            points: 4
            loadout: 4
            slots: [
                "Talent"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Separatist Interceptor"
            id: 425
            faction: "Separatist Alliance"
            skill: 3
            ship: "Droid Tri-fighter"
            points: 4
            loadout: 3
            slots: [
                "Talent"
                "Missile"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Separatist Racketeer"
            id: 426
            faction: "Separatist Alliance"
            skill: 2
            ship: "Firespray-class Patrol Craft"
            points: 7
            loadout: 10
            slots: [
                "Cannon"
                "Missile"
                "Device"
            ]
        }
        {
            name: "Boba Fett (Separatist)"
            canonical_name: 'Boba Fett'.canonicalize()
            xws: "bobafett-separatistalliance"
            id: 427
            faction: "Separatist Alliance"
            unique: true
            skill: 3
            ship: "Firespray-class Patrol Craft"
            points: 7
            loadout: 16
            keyword: ["Bounty Hunter"]
            slots: [
                "Cannon"
                "Missile"
                "Crew"
                "Device"
                "Illicit"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Zam Wesell"
            id: 428
            faction: "Separatist Alliance"
            unique: true
            skill: 5
            charge: 4
            ship: "Firespray-class Patrol Craft"
            points: 9
            loadout: 22
            keyword: ["Bounty Hunter"]
            slots: [
                "Talent"
                "Cannon"
                "Missile"
                "Crew"
                "Device"
                "Illicit"
                "Modification"
                "Title"
            ]
            applies_condition: ['''You'd Better Mean Business'''.canonicalize(),'You Should Thank Me'.canonicalize()]
        }
        {
            name: "Jango Fett"
            id: 429
            faction: "Separatist Alliance"
            skill: 6
            unique: true
            ship: "Firespray-class Patrol Craft"
            points: 8
            loadout: 27
            keyword: ["Bounty Hunter"]
            slots: [
                "Talent"
                "Cannon"
                "Missile"
                "Crew"
                "Device"
                "Illicit"
                "Illicit"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Loyalist Volunteer"
            id: 430
            faction: "Galactic Republic"
            skill: 2
            ship: "Nimbus-class V-wing"
            points: 3
            loadout: 4
            slots: [
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Shadow Squadron Escort"
            id: 431
            faction: "Galactic Republic"
            skill: 3
            ship: "Nimbus-class V-wing"
            points: 3
            loadout: 3
            keyword: ["Clone"]
            slots: [
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Wilhuff Tarkin"
            id: 432
            faction: "Galactic Republic"
            skill: 3
            unique: true
            ship: "Nimbus-class V-wing"
            points: 3
            loadout: 8
            slots: [
                "Talent"
                "Missile"
                "Astromech"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: '"Klick"'
            id: 433
            faction: "Galactic Republic"
            skill: 4
            unique: true
            ship: "Nimbus-class V-wing"
            points: 3
            loadout: 8
            charge: 1
            recurring: 1
            keyword: ["Clone"]
            slots: [
                "Talent"
                "Astromech"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: '"Contrail"'
            id: 434
            faction: "Galactic Republic"
            skill: 5
            unique: true
            ship: "Nimbus-class V-wing"
            points: 3
            loadout: 11
            keyword: ["Clone"]
            slots: [
                "Talent"
                "Astromech"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: '"Odd Ball" (V-wing)'
            canonical_name: '"Oddball"'.canonicalize()
            xws: "oddball-nimbusclassvwing"
            id: 435
            faction: "Galactic Republic"
            skill: 5
            unique: true
            ship: "Nimbus-class V-wing"
            points: 4
            loadout: 12
            keyword: ["Clone"]
            slots: [
                "Talent"
                "Torpedo"
                "Astromech"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Jedi General"
            id: 436
            faction: "Galactic Republic"
            skill: 4
            ship: "Eta-2 Actis"
            points: 5
            loadout: 4
            force: 2
            keyword: ["Jedi", "Light Side"]
            slots: [
                "Force"
                "Cannon"
                "Astromech"
                "Modification"
            ]
        }
        {
            name: "Yoda"
            id: 437
            faction: "Galactic Republic"
            skill: 3
            unique: true
            ship: "Eta-2 Actis"
            points: 5
            loadout: 16
            force: 3
            keyword: ["Jedi", "Light Side"]
            slots: [
                "Force"
                "Force"
                "Cannon"
                "Astromech"
                "Modification"
            ]
        }
        {
            name: "Shaak Ti"
            id: 438
            faction: "Galactic Republic"
            skill: 4
            unique: true
            ship: "Eta-2 Actis"
            points: 5
            loadout: 18
            force: 2
            keyword: ["Jedi", "Light Side"]
            slots: [
                "Force"
                "Force"
                "Talent"
                "Cannon"
                "Astromech"
                "Modification"
            ]
        }
        {
            name: "Aayla Secura"
            id: 439
            faction: "Galactic Republic"
            skill: 5
            unique: true
            ship: "Eta-2 Actis"
            points: 5
            loadout: 15
            force: 2
            keyword: ["Jedi", "Light Side"]
            slots: [
                "Force"
                "Force"
                "Talent"
                "Cannon"
                "Astromech"
                "Modification"
            ]
        }
        {
            name: "Obi-Wan Kenobi (Eta-2)"
            canonical_name: 'Obi-Wan Kenobi'.canonicalize()
            xws: "obiwankenobi-eta2actis"
            id: 440
            faction: "Galactic Republic"
            skill: 5
            unique: true
            ship: "Eta-2 Actis"
            force: 3
            points: 5
            loadout: 15
            keyword: ["Jedi", "Light Side"]
            slots: [
                "Force"
                "Force"
                "Talent"
                "Cannon"
                "Astromech"
                "Modification"
            ]
        }
        {
            name: "Anakin Skywalker (Eta-2)"
            canonical_name: 'Anakin Skywalker'.canonicalize()
            xws: "anakinskywalker-eta2actis"
            id: 441
            faction: "Galactic Republic"
            skill: 6
            unique: true
            force: 3
            ship: "Eta-2 Actis"
            points: 6
            loadout: 20
            keyword: ["Jedi", "Light Side", "Dark Side"]
            slots: [
                "Force"
                "Force"
                "Talent"
                "Cannon"
                "Astromech"
                "Modification"
            ]
        }
        {
            name: "Poe Dameron (HoH)"
            canonical_name: 'Poe Dameron'.canonicalize()
            xws: 'poedameron-swz68'
            id: 442
            unique: true
            faction: "Resistance"
            ship: "T-70 X-wing"
            skill: 6
            points: 6
            loadout: 19
            charge: 2
            recurring: 1
            slots: [
                "Talent"
                "Talent"
                "Tech"
                "Tech"
                "Astromech"
                "Modification"
                "Configuration"
                "HardpointShip"
            ]
        }
        {
            name: "Temmin Wexley (HoH)"
            canonical_name: 'Temmin Wexley'.canonicalize()
            xws: 'temminwexley-swz68'
            id: 443
            unique: true
            faction: "Resistance"
            ship: "T-70 X-wing"
            skill: 4
            points: 6
            loadout: 17
            slots: [
                "Talent"
                "Tech"
                "Tech"
                "Astromech"
                "Modification"
                "Configuration"
                "HardpointShip"
            ]
        }
        {
            name: "Merl Cobben"
            id: 444
            faction: "Resistance"
            unique: true
            skill: 1
            ship: "RZ-2 A-wing"
            points: 3
            loadout: 4
            slots: [
                "Talent"
                "Missile"
                "Tech"
                "Modification"
            ]
        }
        {
            name: "Suralinda Javos"
            id: 445
            faction: "Resistance"
            unique: true
            skill: 3
            ship: "RZ-2 A-wing"
            points: 4
            loadout: 10
            slots: [
                "Talent"
                "Talent"
                "Cannon"
                "Tech"
                "Modification"
            ]
        }
        {
            name: "Wrobie Tyce"
            id: 446
            faction: "Resistance"
            unique: true
            skill: 4
            ship: "RZ-2 A-wing"
            points: 3
            loadout: 4
            slots: [
                "Talent"
                "Missile"
                "Tech"
                "Modification"
            ]
        }
        {
            name: "Seftin Vanik"
            id: 447
            faction: "Resistance"
            unique: true
            skill: 5
            ship: "RZ-2 A-wing"
            points: 4
            loadout: 12
            slots: [
                "Talent"
                "Talent"
                "Missile"
                "Tech"
                "Modification"
            ]
        }
        {
            name: "Nimi Chireen"
            id: 448
            unique: true
            faction: "Resistance"
            ship: "T-70 X-wing"
            skill: 2
            points: 5
            loadout: 10
            slots: [
                "Astromech"
                "Tech"
                "Modification"
                "Configuration"
                "HardpointShip"
            ]
        }
        {
            name: "C'ai Threnalli"
            id: 449
            unique: true
            faction: "Resistance"
            ship: "T-70 X-wing"
            skill: 4
            points: 5
            loadout: 13
            slots: [
                "Talent"
                "Astromech"
                "Tech"
                "Modification"
                "Configuration"
                "HardpointShip"
            ]
        }
        {
            name: "Hera Syndulla (B-Wing)"
            canonical_name: 'Hera Syndulla'.canonicalize()
            xws: "herasyndulla-asf01bwing"
            id: 450
            unique: true
            faction: "Rebel Alliance"
            keyword: ["Spectre"]
            ship: "A/SF-01 B-wing"
            skill: 6
            points: 6
            loadout: 20
            slots: [
                "Talent"
                "Sensor"
                "Cannon"
                "Cannon"
                "Torpedo"
                "Missile"
                "Device"
                "Modification"
                "Configuration"
                "Title"
            ]
        }
        {
            name: "Hera Syndulla (A-Wing)"
            canonical_name: 'Hera Syndulla'.canonicalize()
            xws: "herasyndulla-rz1awing"
            id: 451
            unique: true
            faction: "Rebel Alliance"
            ship: "RZ-1 A-wing"
            keyword: ["Spectre"]
            skill: 6
            points: 5
            loadout: 14
            slots: [
                "Talent"
                "Talent"
                "Sensor"
                "Missile"
                "Configuration"
                "Modification"
            ]
        }
        {
            name: "Wedge Antilles (A-Wing)"
            canonical_name: 'Wedge Antilles'.canonicalize()
            xws: "wedgeantilles-rz1awing"
            id: 452
            unique: true
            faction: "Rebel Alliance"
            ship: "RZ-1 A-wing"
            skill: 4
            points: 4
            loadout: 10
            slots: [
                "Talent"
                "Talent"
                "Missile"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Sabine Wren (A-Wing)"
            canonical_name: 'Sabine Wren'.canonicalize()
            xws: "sabinewren-rz1awing"
            id: 453
            unique: true
            faction: "Rebel Alliance"
            keyword: ["Mandalorian"]
            ship: "RZ-1 A-wing"
            skill: 3
            points: 4
            loadout: 11
            slots: [
                "Talent"
                "Torpedo"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Vult Skerris"
            id: 454
            unique: true
            faction: "Galactic Empire"
            ship: "TIE/d Defender"
            skill: 5
            charge: 1
            recurring: -1
            points: 7
            loadout: 13
            slots: [
                "Talent"
                "Talent"
                "Sensor"
                "Cannon"
                "Missile"            
                "Configuration"
            ]
        }
        {
            name: "Ciena Ree"
            id: 455
            unique: true
            faction: "Galactic Empire"
            ship: "TIE/in Interceptor"
            skill: 6
            points: 5
            loadout: 10
            slots: [
                "Talent"
                "Talent"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Gideon Hask (TIE Interceptor)"
            canonical_name: 'Gideon Hask'.canonicalize()
            xws: "gideonhask-tieininterceptor"
            id: 456
            unique: true
            faction: "Galactic Empire"
            ship: "TIE/in Interceptor"
            skill: 4
            points: 5
            loadout: 12
            slots: [
                "Talent"
                "Talent"
                "Missile"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Kanan Jarrus (HWK-290)"
            canonical_name: 'Kanan Jarrus'.canonicalize()
            xws: "kananjarrus-hwk290lightfreighter"
            id: 457
            unique: true
            faction: "Scum and Villainy"
            keyword: ["Light Side", "Jedi"]
            ship: "HWK-290 Light Freighter"
            skill: 3
            force: 1
            points: 4
            loadout: 10
            slots: [
                "Force"
                "Crew"
                "Device"
                "Illicit"
                "Modification"
                "Modification"
            ]
        }
        {
            name: "Leema Kai"
            id: 458
            unique: true
            faction: "Scum and Villainy"
            ship: "BTL-A4 Y-wing"
            skill: 5
            points: 4
            loadout: 14
            slots: [
                "Talent"
                "Tech"
                "Turret"
                "Torpedo"
                "Missile"
                "Astromech"
                "Device"
            ]
        }
        {
            name: "Arliz Hadrassian"
            id: 459
            unique: true
            faction: "Scum and Villainy"
            ship: "BTL-A4 Y-wing"
            skill: 4
            points: 4
            loadout: 13
            slots: [
                "Talent"
                "Tech"
                "Turret"
                "Torpedo"
                "Missile"
                "Astromech"
                "Device"
            ]
        }
        {
            name: "Padric"
            id: 460
            unique: true
            faction: "Scum and Villainy"
            ship: "BTL-A4 Y-wing"
            skill: 3
            points: 4
            loadout: 10
            slots: [
                "Talent"
                "Tech"
                "Turret"
                "Torpedo"
                "Missile"
                "Astromech"
                "Device"
                "Modification"
            ]
        }
        {
            name: "Derek Klivian"
            id: 461
            unique: true
            faction: "Rebel Alliance"
            ship: "RZ-1 A-wing"
            skill: 3
            points: 3
            loadout: 6
            slots: [
                "Talent"
                "Missile"
                "Configuration"
            ]
        }
        {
            name: "Shara Bey (A-Wing)"
            canonical_name: 'Shara Bey'.canonicalize()
            xws: "sharabey-rz1awing"
            id: 462
            unique: true
            faction: "Rebel Alliance"
            ship: "RZ-1 A-wing"
            skill: 4
            points: 4
            loadout: 7
            slots: [
                "Talent"
                "Missile"
                "Configuration"
            ]
        }
        {
            name: "Ahsoka Tano (A-Wing)"
            canonical_name: 'Ahsoka Tano'.canonicalize()
            xws: "ahsokatano-rz1awing"
            id: 463
            unique: true
            faction: "Rebel Alliance"
            ship: "RZ-1 A-wing"
            keyword: ["Light Side"]
            skill: 5
            force: 3
            points: 5
            loadout: 12
            slots: [
                "Force"
                "Force"
                "Talent"
                "Missile"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Netrem Pollard"
            id: 464
            unique: true
            faction: "Rebel Alliance"
            ship: "A/SF-01 B-wing"
            skill: 3
            points: 5
            loadout: 18
            slots: [
                "Talent"
                "Sensor"
                "Cannon"
                "Cannon"
                "Missile"
                "Device"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Commandant Goran"
            id: 465
            unique: true
            faction: "Galactic Empire"
            ship: "TIE/in Interceptor"
            skill: 4
            points: 4
            loadout: 8
            slots: [
                "Talent"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Nash Windrider"
            id: 466
            unique: true
            faction: "Galactic Empire"
            ship: "TIE/in Interceptor"
            skill: 2
            charge: 1
            recurring: 1
            points: 4
            loadout: 6
            slots: [
                "Missile"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Lieutenant Lorrir"
            id: 467
            unique: true
            faction: "Galactic Empire"
            ship: "TIE/in Interceptor"
            skill: 3
            points: 4
            loadout: 6
            slots: [
                "Talent"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Vult Skerris (TIE Interceptor)"
            canonical_name: 'Vult Skerris'.canonicalize()
            xws: "vultskerris-tieininterceptor"
            id: 468
            unique: true
            faction: "Galactic Empire"
            ship: "TIE/in Interceptor"
            skill: 5
            charge: 1
            recurring: -1
            points: 4
            loadout: 6
            slots: [
                "Talent"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Darth Vader (TIE Defender)"
            canonical_name: 'Darth Vader'.canonicalize()
            xws: "darthvader-tieddefender"
            id: 469
            unique: true
            faction: "Galactic Empire"
            ship: "TIE/d Defender"
            keyword: ["Dark Side", "Sith"]
            skill: 6
            force: 3
            points: 9
            loadout: 14
            slots: [
                "Force"
                "Talent"
                "Tech"
                "Cannon"
                "Missile"            
                "Configuration"
            ]
        }
        {
            name: "Captain Dobbs"
            id: 470
            unique: true
            faction: "Galactic Empire"
            ship: "TIE/d Defender"
            skill: 3
            points: 7
            loadout: 15
            slots: [
                "Talent"
                "Sensor"
                "Cannon"
                "Missile"            
                "Configuration"
            ]
        }
        {
            name: "Jinata Security Officer"
            id: 471
            faction: "Scum and Villainy"
            ship: "BTL-A4 Y-wing"
            skill: 2
            points: 4
            loadout: 5
            slots: [
                "Turret"
                "Torpedo"
                "Missile"
                "Device"
            ]
        }
        {
            name: "Amaxine Warrior"
            id: 472
            faction: "Scum and Villainy"
            ship: "BTL-A4 Y-wing"
            skill: 3
            points: 4
            loadout: 6
            slots: [
                "Turret"
                "Torpedo"
                "Missile"
                "Astromech"
                "Device"
            ]
        }
        {
            name: "Gamut Key"
            id: 473
            unique: true
            faction: "Scum and Villainy"
            ship: "HWK-290 Light Freighter"
            skill: 3
            charge: 2
            recurring: 1
            points: 3
            loadout: 8
            slots: [
                "Talent"
                "Crew"
                "Device"
                "Illicit"
                "Modification"
                "Modification"
            ]
        }
        {
            name: "Tápusk"
            xws: "tapusk"
            id: 474
            unique: true
            faction: "Scum and Villainy"
            ship: "HWK-290 Light Freighter"
            skill: 5
            charge: 2
            recurring: 1
            points: 4
            loadout: 10
            slots: [
                "Talent"
                "Crew"
                "Device"
                "Illicit"
                "Modification"
                "Modification"
            ]
        }
        {
            name: "Colicoid Destroyer"
            id: 475
            faction: "Separatist Alliance"
            ship: "Trident-class Assault Ship"
            skill: 8
            engagement: 0
            points: 85
            slots: [
                "Command"
                "Torpedo"
                "Hardpoint"
                "Hardpoint"
                "Crew"
                "Crew"
                "Gunner"
                "Team"
                "Cargo"
                "Title"
            ]
        }
        {
            name: "Lawless Pirates"
            id: 476
            faction: "Scum and Villainy"
            ship: "Trident-class Assault Ship"
            skill: 8
            engagement: 0
            points: 85
            slots: [
                "Command"
                "Torpedo"
                "Hardpoint"
                "Hardpoint"
                "Crew"
                "Crew"
                "Gunner"
                "Team"
                "Cargo"
                "Title"
            ]
        }
        {
            name: "Zorii Bliss"
            id: 477
            unique: true
            faction: "Resistance"
            ship: "BTA-NR2 Y-wing"
            skill: 5
            points: 5
            loadout: 19
            charge: 1
            recurring: 1
            slots: [
                "Talent"
                "Tech"
                "Turret"
                "Astromech"
                "Device"
                "Modification"
                "Illicit"
                "Configuration"
            ]
        }
        {
            name: "Teza Nasz"
            id: 478
            unique: true
            faction: "Resistance"
            ship: "BTA-NR2 Y-wing"
            skill: 4
            points: 4
            loadout: 12
            slots: [
                "Talent"
                "Tech"
                "Turret"
                "Astromech"
                "Device"
                "Modification"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Wilsa Teshlo"
            id: 479
            unique: true
            faction: "Resistance"
            ship: "BTA-NR2 Y-wing"
            skill: 4
            points: 4
            loadout: 12
            slots: [
                "Tech"
                "Turret"
                "Astromech"
                "Device"
                "Device"
                "Modification"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Shasa Zaro"
            id: 480
            unique: true
            faction: "Resistance"
            ship: "BTA-NR2 Y-wing"
            skill: 3
            points: 4
            loadout: 13
            slots: [
                "Talent"
                "Tech"
                "Turret"
                "Astromech"
                "Device"
                "Modification"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Lega Fossang"
            id: 481
            unique: true
            faction: "Resistance"
            ship: "BTA-NR2 Y-wing"
            skill: 3
            points: 4
            loadout: 14
            slots: [
                "Talent"
                "Tech"
                "Turret"
                "Missile"
                "Astromech"
                "Device"
                "Modification"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Aftab Ackbar"
            id: 482
            unique: true
            faction: "Resistance"
            ship: "BTA-NR2 Y-wing"
            skill: 2
            points: 4
            loadout: 13
            slots: [
                "Talent"
                "Talent"
                "Tech"
                "Turret"
                "Astromech"
                "Device"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Corus Kapellim"
            id: 483
            unique: true
            faction: "Resistance"
            ship: "BTA-NR2 Y-wing"
            skill: 1
            points: 4
            loadout: 15
            slots: [
                "Tech"
                "Turret"
                "Astromech"
                "Device"
                "Modification"
                "Modification"
                "Illicit"
                "Configuration"
            ]
        }
        {
            name: "C'ai Threnalli (Y-Wing)"
            canonical_name: '''C'ai Threnalli'''.canonicalize()
            xws: "caithrenalli-btanr2ywing"
            id: 484
            unique: true
            faction: "Resistance"
            ship: "BTA-NR2 Y-wing"
            skill: 2
            points: 4
            loadout: 10
            slots: [
                "Talent"
                "Tech"
                "Turret"
                "Astromech"
                "Device"
                "Modification"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "New Republic Patrol"
            id: 485
            faction: "Resistance"
            ship: "BTA-NR2 Y-wing"
            skill: 3
            points: 4
            loadout: 7
            slots: [
                "Talent"
                "Tech"
                "Turret"
                "Astromech"
                "Device"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Kijimi Spice Runner"
            id: 486
            faction: "Resistance"
            ship: "BTA-NR2 Y-wing"
            skill: 2
            points: 4
            loadout: 4
            slots: [
                "Tech"
                "Turret"
                "Astromech"
                "Device"
                "Modification"
                "Illicit"
                "Configuration"
            ]
        }
        {
            name: "Kylo Ren (TIE Whisper)"
            canonical_name: 'Kylo Ren'.canonicalize()
            xws: "kyloren-tiewiwhispermodifiedinterceptor"
            id: 487
            unique: true
            faction: "First Order"
            ship: "TIE/wi Whisper Modified Interceptor"
            keyword: ["Dark Side", "Light Side"]
            skill: 5
            force: 3
            points: 6
            loadout: 18
            slots: [
                "Force"
                "Force"
                "Talent"
                "Missile"
                "Tech"
                "Tech"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: '"Wrath"'
            id: 488
            unique: true
            faction: "First Order"
            ship: "TIE/wi Whisper Modified Interceptor"
            skill: 5
            points: 5
            loadout: 15
            slots: [
                "Talent"
                "Talent"
                "Cannon"
                "Tech"
                "Tech"
                "Configuration"
            ]
        }
        {
            name: '"Nightfall"'
            id: 489
            unique: true
            faction: "First Order"
            ship: "TIE/wi Whisper Modified Interceptor"
            skill: 4
            points: 4
            loadout: 10
            slots: [
                "Talent"
                "Missile"
                "Tech"
                "Tech"
                "Configuration"
            ]
        }
        {
            name: '"Whirlwind"'
            id: 490
            unique: true
            faction: "First Order"
            ship: "TIE/wi Whisper Modified Interceptor"
            skill: 3
            points: 4
            loadout: 12
            slots: [
                "Talent"
                "Talent"
                "Missile"
                "Tech"
                "Tech"
                "Configuration"
            ]
        }
        {
            name: "709th Legion Ace"
            id: 491
            faction: "First Order"
            ship: "TIE/wi Whisper Modified Interceptor"
            skill: 4
            points: 4
            loadout: 10
            slots: [
                "Talent"
                "Missile"
                "Tech"
                "Tech"
                "Configuration"
            ]
        }
        {
            name: "Red Fury Zealot"
            id: 492
            faction: "First Order"
            ship: "TIE/wi Whisper Modified Interceptor"
            skill: 2
            points: 4
            loadout: 3
            slots: [
                "Talent"
                "Missile"
                "Tech"
                "Tech"
                "Configuration"
            ]
        }
        {
            name: '"Breach"'
            id: 493
            unique: true
            faction: "First Order"
            ship: "TIE/se Bomber"
            skill: 5
            points: 5
            loadout: 18
            slots: [
                "Talent"
                "Talent"
                "Tech"
                "Torpedo"
                "Torpedo"
                "Missile"
                "Gunner"
                "Device"
                "Modification"
            ]
        }
        {
            name: '"Scorch" (TIE/Se Bomber)'
            canonical_name: '"Scorch"'.canonicalize()
            xws: "scorch-tiesebomber"
            id: 494
            unique: true
            faction: "First Order"
            ship: "TIE/se Bomber"
            skill: 4
            points: 4
            loadout: 10
            slots: [
                "Talent"
                "Tech"
                "Missile"
                "Gunner"
                "Device"
                "Device"
                "Modification"
                "Modification"
            ]
        }
        {
            name: '"Dread"'
            id: 495
            unique: true
            faction: "First Order"
            ship: "TIE/se Bomber"
            skill: 3
            points: 4
            loadout: 12
            slots: [
                "Tech"
                "Torpedo"
                "Missile"
                "Gunner"
                "Device"
                "Device"
                "Modification"
            ]
        }
        {
            name: '"Grudge"'
            id: 496
            unique: true
            faction: "First Order"
            ship: "TIE/se Bomber"
            skill: 2
            points: 4
            loadout: 15
            slots: [
                "Talent"
                "Tech"
                "Missile"
                "Gunner"
                "Device"
                "Device"
                "Modification"
            ]
        }
        {
            name: "First Order Cadet"
            id: 497
            faction: "First Order"
            ship: "TIE/se Bomber"
            skill: 3
            points: 4
            loadout: 7
            slots: [
                "Tech"
                "Torpedo"
                "Missile"
                "Gunner"
                "Device"
                "Device"
                "Modification"
            ]
        }
        {
            name: "Sienar-Jaemus Test Pilot"
            id: 498
            faction: "First Order"
            ship: "TIE/se Bomber"
            skill: 2
            points: 4
            loadout: 8
            slots: [
                "Tech"
                "Tech"
                "Missile"
                "Device"
                "Device"
                "Modification"
            ]
        }
        {
            name: "Bodica Venj"
            id: 499
            faction: "Rebel Alliance"
            unique: true
            ship: "Fang Fighter"
            skill: 4
            points: 5
            loadout: 6
            keyword: ["Mandalorian"]
            slots: [
                "Talent"
                "Talent"
                "Torpedo"
                "Modification"
            ]
        }
        {
            name: "Dirk Ullodin"
            id: 500
            faction: "Rebel Alliance"
            unique: true
            ship: "Fang Fighter"
            skill: 3
            points: 5
            loadout: 10
            keyword: ["Mandalorian"]
            slots: [
                "Torpedo"
                "Modification"
            ]
        }
        {
            name: "Fenn Rau (Rebel Fang)"
            id: 501
            faction: "Rebel Alliance"
            canonical_name: 'Fenn Rau'.canonicalize()
            xws: "fennrau-rebel-fang"
            unique: true
            ship: "Fang Fighter"
            skill: 6
            points: 6
            loadout: 16
            keyword: ["Mandalorian"]
            slots: [
                "Talent"
                "Talent"
                "Torpedo"
                "Modification"
            ]
        }
        {
            name: "Clan Wren Volunteer"
            id: 502
            faction: "Rebel Alliance"
            ship: "Fang Fighter"
            skill: 3
            points: 5
            loadout: 10
            max_per_squad: 2
            keyword: ["Mandalorian"]
            slots: [
                "Talent"
                "Torpedo"
                "Modification"
                "Modification"
            ]
        }
        {
            name: "Moff Gideon"
            id: 503
            unique: true
            faction: "Galactic Empire"
            ship: "TIE/ln Fighter"
            skill: 4
            charge: 2
            recurring: 1
            points: 3
            loadout: 8
            slots: [
                "Talent"
                "Missile"
                "Illicit"
                "Illicit"
                "Modification"
            ]
        }
        {
            name: "ISB Jingoist"
            id: 504
            faction: "Galactic Empire"
            ship: "TIE/ln Fighter"
            skill: 4
            points: 3
            loadout: 5
            max_per_squad: 2
            slots: [
                "Talent"
                "Illicit"
            ]
        }
        {
            name: "Mandalorian Royal Guard"
            id: 505
            faction: "Scum and Villainy"
            ship: "Fang Fighter"
            skill: 4
            points: 5
            loadout: 10
            max_per_squad: 2
            keyword: ["Mandalorian"]
            slots: [
                "Talent"
                "Missile"
                "Modification"
            ]
        }
        {
            name: "Bo-Katan Kryze"
            id: 506
            skip: true
        }
        {
            name: "Pre Vizsla"
            id: 507
            faction: "Separatist Alliance"
            ship: "Gauntlet Fighter"
            skill: 3
            points: 7
            loadout: 18
            charge: 2
            recurring: 1
            unique: true
            keyword: ["Mandalorian"]
            slots: [
                "Talent"
                "Crew"
                "Gunner"
                "Missile"
                "Device"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Death Watch Warrior"
            id: 508
            faction: "Separatist Alliance"
            ship: "Gauntlet Fighter"
            skill: 2
            points: 7
            loadout: 10
            unique: true
            keyword: ["Mandalorian"]
            slots: [
                "Talent"
                "Crew"
                "Gunner"
                "Device"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Bo-Katan Kryze"
            id: 509
            faction: "Separatist Alliance"
            xws: "bokatankryze-separatistalliance"
            ship: "Gauntlet Fighter"
            skill: 4
            points: 7
            loadout: 20
            charge: 1
            recurring: 1
            unique: true
            keyword: ["Mandalorian"]
            slots: [
                "Talent"
                "Crew"
                "Gunner"
                "Missile"
                "Missile"
                "Device"
                "Modification"
                "Modification"
                "Title"
                "Configuration"
            ]
        }
        {
            name: "Bo-Katan Kryze (Republic)"
            canonical_name: 'Bo-Katan Kryze'.canonicalize()
            xws: "bokatankryze"
            id: 510
            faction: "Galactic Republic"
            ship: "Gauntlet Fighter"
            skill: 4
            points: 7
            loadout: 20
            unique: true
            keyword: ["Mandalorian"]
            slots: [
                "Talent"
                "Crew"
                "Gunner"
                "Torpedo"
                "Missile"
                "Missile"
                "Device"
                "Modification"
                "Modification"
                "Title"
                "Configuration"
            ]
        }
        {
            name: "Nite Owl Liberator"
            id: 511
            faction: "Galactic Republic"
            ship: "Gauntlet Fighter"
            skill: 2
            points: 7
            loadout: 16
            unique: true
            keyword: ["Mandalorian"]
            slots: [
                "Talent"
                "Crew"
                "Gunner"
                "Device"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Maul"
            id: 512
            faction: "Scum and Villainy"
            ship: "Gauntlet Fighter"
            skill: 5
            points: 9
            loadout: 20
            unique: true
            force: 3
            keyword: ["Dark Side", "Sith"]
            slots: [
                "Force"
                "Talent"
                "Crew"
                "Gunner"
                "Missile"
                "Device"
                "Illicit"
                "Modification"
                "Modification"
                "Title"
                "Configuration"
            ]
        }
        {
            name: "Shadow Collective Operator"
            id: 513
            faction: "Scum and Villainy"
            ship: "Gauntlet Fighter"
            skill: 1
            points: 7
            loadout: 10
            keyword: ["Mandalorian"]
            slots: [
                "Crew"
                "Gunner"
                "Device"
                "Device"
                "Modification"
                "Illicit"
                "Configuration"
            ]
        }
        {
            name: "Rook Kast"
            id: 514
            faction: "Scum and Villainy"
            ship: "Gauntlet Fighter"
            skill: 3
            points: 7
            loadout: 18
            unique: true
            keyword: ["Mandalorian"]
            slots: [
                "Talent"
                "Crew"
                "Gunner"
                "Device"
                "Modification"
                "Illicit"
                "Configuration"
            ]
        }
        {
            name: "Captain Hark"
            id: 515
            faction: "Galactic Empire"
            ship: "Gauntlet Fighter"
            skill: 3
            points: 7
            loadout: 15
            unique: true
            keyword: ["Mandalorian"]
            slots: [
                "Talent"
                "Crew"
                "Gunner"
                "Device"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Imperial Super Commando"
            id: 516
            faction: "Galactic Empire"
            ship: "Gauntlet Fighter"
            skill: 2
            points: 7
            loadout: 10
            keyword: ["Mandalorian"]
            slots: [
                "Talent"
                "Crew"
                "Gunner"
                "Device"
                "Device"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Gar Saxon"
            id: 517
            faction: "Galactic Empire"
            ship: "Gauntlet Fighter"
            skill: 3
            points: 8
            loadout: 18
            charge: 2
            recurring: 1
            unique: true
            keyword: ["Mandalorian"]
            slots: [
                "Talent"
                "Crew"
                "Gunner"
                "Torpedo"
                "Device"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Mandalorian Resistance Pilot"
            id: 518
            faction: "Rebel Alliance"
            ship: "Gauntlet Fighter"
            skill: 2
            points: 7
            loadout: 10
            unique: true
            keyword: ["Mandalorian"]
            slots: [
                "Talent"
                "Crew"
                "Gunner"
                "Device"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: '"Chopper" (Gauntlet Fighter)'
            canonical_name: 'Chopper'.canonicalize()
            xws: "chopper-gauntletfighter"
            id: 519
            faction: "Rebel Alliance"
            ship: "Gauntlet Fighter"
            skill: 2
            points: 7
            loadout: 18
            keyword: ["Droid","Spectre"]
            unique: true
            slots: [
                "Crew"
                "Gunner"
                "Device"
                "Modification"
                "Modification"
                "Configuration"
                "Title"
            ]
        }
        {
            name: "Ezra Bridger (Gauntlet Fighter)"
            canonical_name: 'Ezra Bridger'.canonicalize()
            xws: "ezrabridger-gauntletfighter"
            id: 520
            faction: "Rebel Alliance"
            ship: "Gauntlet Fighter"
            skill: 3
            force: 1
            points: 7
            loadout: 16
            keyword: ["Light Side","Spectre"]
            unique: true
            slots: [
                "Force"
                "Talent"
                "Crew"
                "Gunner"
                "Missile"
                "Device"
                "Illicit"
                "Modification"
                "Modification"
                "Title"
                "Configuration"
            ]
        }
        {
            name: "Q9-0"
            id: 521
            faction: "Scum and Villainy"
            ship: "ST-70 Assault Ship"
            skill: 5
            points: 6
            loadout: 16
            unique: true
            keyword: ["Droid"]
            slots: [
                "Crew"
                "Crew"
                "Cannon"
                "Gunner"
                "Illicit"
                "Illicit"
                "Modification"
                "Title"
            ]
        }
        {
            name: "The Mandalorian"
            id: 522
            faction: "Scum and Villainy"
            ship: "ST-70 Assault Ship"
            skill: 5
            points: 7
            loadout: 20
            unique: true
            keyword: ["Bounty Hunter", "Mandalorian"]
            slots: [
                "Talent"
                "Talent"
                "Crew"
                "Crew"
                "Cannon"
                "Gunner"
                "Illicit"
                "Illicit"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Guild Bounty Hunter"
            id: 523
            faction: "Scum and Villainy"
            ship: "ST-70 Assault Ship"
            skill: 3
            points: 6
            loadout: 14
            max_per_squad: 2
            keyword: ["Bounty Hunter"]
            slots: [
                "Talent"
                "Crew"
                "Gunner"
                "Illicit"
                "Illicit"
                "Modification"
            ]
        }
        {
            name: "Outer Rim Enforcer"
            id: 524
            faction: "Scum and Villainy"
            ship: "ST-70 Assault Ship"
            skill: 2
            points: 6
            loadout: 10
            slots: [
                "Crew"
                "Gunner"
                "Illicit"
                "Modification"
                "Modification"
            ]
        }
        {
            name: "Plo Koon (Delta-7b)"
            xws: "plokoon-delta7baethersprite"
            id: 525
            unique: true
            faction: "Galactic Republic"
            ship: "Delta-7b Aethersprite"
            skill: 5
            force: 2
            points: 7
            loadout: 17
            keyword: ["Jedi","Light Side"]
            slots: [
                "Force"
                "Talent"
                "Astromech"
                "Modification"
            ]
        }
        {
            name: "Saesee Tiin (Delta-7b)"
            canonical_name: 'Saesee Tiin'.canonicalize()
            xws: "saeseetiin-delta7baethersprite"
            id: 526
            unique: true
            faction: "Galactic Republic"
            ship: "Delta-7b Aethersprite"
            skill: 4
            force: 2
            points: 6
            loadout: 9
            keyword: ["Jedi","Light Side"]
            slots: [
                "Force"
                "Astromech"
                "Modification"
            ]
        }
        {
            name: "Mace Windu (Delta-7b)"
            canonical_name: 'Mace Windu'.canonicalize()
            xws: "macewindu-delta7baethersprite"
            id: 527
            unique: true
            faction: "Galactic Republic"
            ship: "Delta-7b Aethersprite"
            skill: 4
            force: 3
            points: 6
            loadout: 8
            keyword: ["Jedi","Light Side"]
            slots: [
                "Force"
                "Force"
                "Astromech"
                "Modification"
            ]
        }
        {
            name: "Anakin Skywalker (Delta-7b)"
            canonical_name: 'Anakin Skywalker'.canonicalize()
            xws: "anakinskywalker-delta7baethersprite"
            id: 528
            unique: true
            faction: "Galactic Republic"
            ship: "Delta-7b Aethersprite"
            skill: 6
            force: 3
            points: 7
            loadout: 15
            keyword: ["Jedi","Light Side"]
            slots: [
                "Force"
                "Force"
                "Talent"
                "Astromech"
                "Modification"
            ]
        }
        {
            name: "Luminara Unduli (Delta-7b)"
            canonical_name: 'Luminara Unduli'.canonicalize()
            xws: "luminaraunduli-delta7baethersprite"
            id: 529
            unique: true
            faction: "Galactic Republic"
            ship: "Delta-7b Aethersprite"
            skill: 4
            force: 2
            points: 6
            loadout: 7
            keyword: ["Jedi","Light Side"]
            slots: [
                "Force"
                "Astromech"
                "Modification"
            ]
        }
        {
            name: "Barriss Offee (Delta-7b)"
            canonical_name: 'Barriss Offee'.canonicalize()
            xws: "barrissoffee-delta7baethersprite"
            id: 530
            unique: true
            faction: "Galactic Republic"
            ship: "Delta-7b Aethersprite"
            skill: 4
            force: 1
            points: 5
            loadout: 10
            keyword: ["Jedi","Light Side"]
            slots: [
                "Force"
                "Astromech"
                "Modification"
            ]
        }
        {
            name: "Ahsoka Tano (Delta-7b)"
            canonical_name: 'Ahsoka Tano'.canonicalize()
            xws: "ahsokatano-delta7baethersprite"
            id: 531
            unique: true
            faction: "Galactic Republic"
            ship: "Delta-7b Aethersprite"
            skill: 3
            force: 2
            points: 6
            loadout: 10
            keyword: ["Jedi","Light Side"]
            slots: [
                "Force"
                "Astromech"
                "Modification"
            ]
        }
        {
            name: "Jedi Knight (Delta-7b)"
            canonical_name: 'Jedi Knight'.canonicalize()
            xws: "jediknight-delta7baethersprite"
            id: 532
            faction: "Galactic Republic"
            ship: "Delta-7b Aethersprite"
            skill: 3
            force: 1
            points: 6
            loadout: 8
            keyword: ["Jedi","Light Side"]
            slots: [
                "Force"
                "Astromech"
                "Modification"
            ]
        }
        {
            name: "Obi-Wan Kenobi (Delta-7b)"
            canonical_name: 'Obi-Wan Kenobi'.canonicalize()
            xws: "obiwankenobi-delta7baethersprite"
            id: 533
            unique: true
            faction: "Galactic Republic"
            ship: "Delta-7b Aethersprite"
            skill: 5
            force: 3
            points: 7
            loadout: 15
            keyword: ["Jedi","Light Side"]
            slots: [
                "Force"
                "Force"
                "Talent"
                "Astromech"
                "Modification"
            ]
        }
        {
            name: "Cad Bane"
            id: 534
            unique: true
            faction: "Scum and Villainy"
            ship: "Rogue-class Starfighter"
            skill: 4
            charge: 2
            recurring: 1
            points: 5
            loadout: 18
            keyword: ["Bounty Hunter"]
            slots: [
                "Talent"
                "Cannon"
                "Cannon"
                "Missile"
                "Illicit"
                "Illicit"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Viktor Hel (Rogue)"
            canonical_name: 'Viktor Hel'.canonicalize()
            xws: "viktorhel-rogueclassstarfighter"
            id: 535
            unique: true
            faction: "Scum and Villainy"
            ship: "Rogue-class Starfighter"
            skill: 4
            points: 5
            loadout: 16
            keyword: ["Bounty Hunter"]
            slots: [
                "Talent"
                "Cannon"
                "Cannon"
                "Missile"
                "Illicit"
                "Modification"
            ]
        }
        {
            name: "Nom Lumb (Rogue)"
            canonical_name: 'Nom Lumb'.canonicalize()
            xws: "nomlumb-rogueclassstarfighter"
            id: 536
            unique: true
            faction: "Scum and Villainy"
            ship: "Rogue-class Starfighter"
            skill: 1
            points: 5
            loadout: 19
            keyword: ["Bounty Hunter"]
            slots: [
                "Talent"
                "Cannon"
                "Cannon"
                "Missile"
                "Illicit"
                "Modification"
                "Modification"
            ]
        }
        {
            name: "Outer Rim Hunter"
            id: 537
            faction: "Scum and Villainy"
            ship: "Rogue-class Starfighter"
            skill: 3
            points: 5
            loadout: 4
            slots: [
                "Cannon"
                "Cannon"
                "Illicit"
                "Modification"
            ]
        }
        {
            name: "Cad Bane (Separatist)"
            canonical_name: 'Cad Bane'.canonicalize()
            xws: "cadbane-separatistalliance"
            id: 538
            unique: true
            faction: "Separatist Alliance"
            ship: "Rogue-class Starfighter"
            skill: 4
            charge: 1
            recurring: 1
            points: 5
            loadout: 18
            keyword: ["Bounty Hunter"]
            slots: [
                "Talent"
                "Cannon"
                "Cannon"
                "Missile"
                "Illicit"
                "Illicit"
                "Modification"
                "Title"
            ]
        }
        {
            name: "IG-101"
            id: 539
            unique: true
            faction: "Separatist Alliance"
            ship: "Rogue-class Starfighter"
            skill: 4
            points: 5
            loadout: 19
            chassis: "Networked Calculations"
            keyword: ["Droid"]
            slots: [
                "Cannon"
                "Cannon"
                "Modification"
                "Modification"
            ]
        }
        {
            name: "IG-102"
            id: 540
            unique: true
            faction: "Separatist Alliance"
            ship: "Rogue-class Starfighter"
            skill: 4
            points: 5
            loadout: 19
            chassis: "Networked Calculations"
            keyword: ["Droid"]
            slots: [
                "Cannon"
                "Cannon"
                "Modification"
                "Modification"
            ]
        }
        {
            name: "IG-111"
            id: 541
            unique: true
            faction: "Separatist Alliance"
            ship: "Rogue-class Starfighter"
            skill: 1
            points: 5
            loadout: 21
            chassis: "Networked Calculations"
            keyword: ["Droid"]
            slots: [
                "Cannon"
                "Cannon"
                "Modification"
                "Modification"
            ]
        }
        {
            name: "MagnaGuard Protector"
            id: 542
            max_per_squad: 2
            faction: "Separatist Alliance"
            ship: "Rogue-class Starfighter"
            skill: 4
            points: 5
            loadout: 18
            chassis: "Networked Calculations"
            keyword: ["Droid"]
            slots: [
                "Cannon"
                "Cannon"
                "Missile"
                "Modification"
            ]
            applies_condition: 'Guarded'.canonicalize()
        }
        {
            name: "MagnaGuard Executioner"
            id: 543
            faction: "Separatist Alliance"
            ship: "Rogue-class Starfighter"
            skill: 3
            points: 4
            loadout: 4
            chassis: "Networked Calculations"
            keyword: ["Droid"]
            slots: [
                "Cannon"
                "Cannon"
                "Modification"
            ]
        }
        {
            name: '"Knack"'
            id: 544
            unique: true
            faction: "Galactic Republic"
            ship: "Clone Z-95 Headhunter"
            skill: 5
            points: 3
            loadout: 7
            keyword: ["Clone"]
            slots: [
                "Talent"
                "Talent"
                "Sensor"
                "Modification"
                "VersatileShip"
            ]
        }
        {
            name: '"Slider"'
            id: 545
            unique: true
            faction: "Galactic Republic"
            ship: "Clone Z-95 Headhunter"
            skill: 4
            charge: 2
            recurring: 1
            points: 3
            loadout: 8
            keyword: ["Clone"]
            slots: [
                "Talent"
                "Talent"
                "Sensor"
                "Modification"
                "Modification"
                "VersatileShip"
            ]
        }
        {
            name: '"Hawk" (Z-95)'
            canonical_name: '"Hawk"'.canonicalize()
            xws: "hawk-clonez95headhunter"
            id: 546
            unique: true
            faction: "Galactic Republic"
            ship: "Clone Z-95 Headhunter"
            skill: 4
            points: 3
            loadout: 8
            keyword: ["Clone"]
            slots: [
                "Talent"
                "Sensor"
                "Modification"
                "Modification"
                "VersatileShip"
            ]
        }
        {
            name: '"Warthog" (Z-95)'
            canonical_name: '"Warthog"'.canonicalize()
            xws: "warthog-clonez95headhunter"
            id: 547
            unique: true
            faction: "Galactic Republic"
            ship: "Clone Z-95 Headhunter"
            skill: 3
            points: 3
            loadout: 10
            keyword: ["Clone"]
            slots: [
                "Talent"
                "Sensor"
                "Modification"
                "VersatileShip"
            ]
        }
        {
            name: '"Boost"'
            id: 548
            unique: true
            faction: "Galactic Republic"
            ship: "Clone Z-95 Headhunter"
            skill: 3
            points: 3
            loadout: 8
            keyword: ["Clone"]
            slots: [
                "Talent"
                "Talent"
                "Sensor"
                "Modification"
                "VersatileShip"
            ]
        }
        {
            name: '"Drift"'
            id: 549
            unique: true
            faction: "Galactic Republic"
            ship: "Clone Z-95 Headhunter"
            skill: 3
            points: 3
            loadout: 5
            keyword: ["Clone"]
            slots: [
                "Talent"
                "Sensor"
                "Modification"
                "VersatileShip"
            ]
        }
        {
            name: '"Stub"'
            id: 550
            unique: true
            faction: "Galactic Republic"
            ship: "Clone Z-95 Headhunter"
            skill: 3
            points: 3
            loadout: 8
            keyword: ["Clone"]
            slots: [
                "Talent"
                "Sensor"
                "Modification"
                "VersatileShip"
            ]
        }
        {
            name: '"Killer"'
            id: 551
            unique: true
            faction: "Galactic Republic"
            ship: "Clone Z-95 Headhunter"
            skill: 2
            points: 3
            loadout: 11
            keyword: ["Clone"]
            slots: [
                "Talent"
                "Talent"
                "Sensor"
                "Cannon"
                "Modification"
                "VersatileShip"
            ]
        }
        {
            name: "Reaper Squadron Scout"
            id: 552
            faction: "Galactic Republic"
            ship: "Clone Z-95 Headhunter"
            skill: 3
            points: 3
            loadout: 2
            keyword: ["Clone"]
            slots: [
                "Talent"
                "Sensor"
                "VersatileShip"
            ]
        }
        {
            name: "7th Sky Corps Pilot"
            id: 553
            faction: "Galactic Republic"
            ship: "Clone Z-95 Headhunter"
            skill: 2
            points: 3
            loadout: 3
            keyword: ["Clone"]
            slots: [
                "Sensor"
                "Modification"
                "VersatileShip"
            ]
        }
        {
            name: "Garven Dreis (BoY)"
            canonical_name: 'Garven Dreis'.canonicalize()
            xws: "garvendreis-battleofyavin"
            unique: true
            id: 554
            faction: "Rebel Alliance"
            ship: "T-65 X-wing"
            skill: 4
            points: 4
            chassis: "Hope"
            upgrades: [
                "Adv. Proton Torpedoes"
                "R5-K6 (BoY)"
            ]
        }
        {
            name: "Luke Skywalker (BoY)"
            canonical_name: 'Luke Skywalker'.canonicalize()
            xws: "lukeskywalker-battleofyavin"
            unique: true
            id: 555
            faction: "Rebel Alliance"
            ship: "T-65 X-wing"
            skill: 5
            points: 6
            force: 2
            chassis: "Hope"
            upgrades: [
                "Instinctive Aim"
                "Attack Speed (BoY)"
                "Proton Torpedoes"
                "R2-D2 (BoY)"
            ]
        }
        {
            name: "Jek Porkins (BoY)"
            canonical_name: 'Jek Porkins'.canonicalize()
            xws: "jekporkins-battleofyavin"
            unique: true
            id: 556
            faction: "Rebel Alliance"
            ship: "T-65 X-wing"
            skill: 4
            points: 4
            chassis: "Hope"
            upgrades: [
                "Adv. Proton Torpedoes"
                "R5-D8 (BoY)"
                "Unstable Sublight Engines (BoY)"
            ]
        }
        {
            name: "Biggs Darklighter (BoY)"
            canonical_name: 'Biggs Darklighter'.canonicalize()
            xws: "biggsdarklighter-battleofyavin"
            unique: true
            id: 557
            faction: "Rebel Alliance"
            ship: "T-65 X-wing"
            skill: 3
            points: 5
            chassis: "Hope"
            upgrades: [
                "Attack Speed (BoY)"
                "Selfless"
                "Proton Torpedoes"
                "R2-F2 (BoY)"
            ]
        }
        {
            name: "Wedge Antilles (BoY)"
            canonical_name: 'Wedge Antilles'.canonicalize()
            xws: "wedgeantilles-battleofyavin"
            unique: true
            id: 558
            faction: "Rebel Alliance"
            ship: "T-65 X-wing"
            skill: 5
            points: 5
            chassis: "Hope"
            upgrades: [
                "Attack Speed (BoY)"
                "Marksmanship"
                "Proton Torpedoes"
                "R2-A3 (BoY)"
            ]
        }
        {
            name: "Han Solo (BoY)"
            canonical_name: 'Han Solo'.canonicalize()
            xws: "hansolo-battleofyavin"
            unique: true
            id: 559
            faction: "Rebel Alliance"
            ship: "Modified YT-1300 Light Freighter"
            skill: 6
            points: 7
            charge: 4
            chassis: "Solo"
            upgrades: [
                "Chewbacca (BoY)"
                "Rigged Cargo Chute"
                "Millennium Falcon"
                "L3-37's Programming (BoY)"
            ]
        }
        {
            name: '"Dutch" Vander (BoY)'
            canonical_name: '"Dutch" Vander'.canonicalize()
            xws: "dutchvander-battleofyavin"
            unique: true
            id: 560
            faction: "Rebel Alliance"
            ship: "BTL-A4 Y-wing"
            skill: 4
            points: 4
            chassis: "Hope"
            upgrades: [
                "Ion Cannon Turret"
                "Adv. Proton Torpedoes"
                "Targeting Astromech (BoY)"
            ]
        }
        {
            name: "Dex Tiree (BoY)"
            canonical_name: 'Dex Tiree'.canonicalize()
            xws: "dextiree-battleofyavin"
            unique: true
            id: 561
            faction: "Rebel Alliance"
            ship: "BTL-A4 Y-wing"
            skill: 2
            points: 4
            chassis: "Hope"
            upgrades: [
                "Dorsal Turret"
                "Adv. Proton Torpedoes"
                "R4 Astromech"
            ]
        }
        {
            name: '"Pops" Krail (BoY)'
            canonical_name: '"Pops" Krail'.canonicalize()
            xws: "popskrail-battleofyavin"
            unique: true
            id: 562
            faction: "Rebel Alliance"
            ship: "BTL-A4 Y-wing"
            skill: 4
            points: 4
            chassis: "Hope"
            upgrades: [
                "Ion Cannon Turret"
                "Adv. Proton Torpedoes"
                "R4 Astromech"
            ]
        }
        {
            name: "Hol Okand (BoY)"
            canonical_name: 'Hol Okand'.canonicalize()
            xws: "holokand-battleofyavin"
            unique: true
            id: 563
            faction: "Rebel Alliance"
            ship: "BTL-A4 Y-wing"
            skill: 4
            points: 4
            chassis: "Hope"
            upgrades: [
                "Dorsal Turret"
                "Adv. Proton Torpedoes"
                "Precise Astromech (BoY)"
            ]
        }
        {
            name: "Darth Vader (BoY)"
            canonical_name: 'Darth Vader'.canonicalize()
            xws: "darthvader-battleofyavin"
            unique: true
            id: 564
            faction: "Galactic Empire"
            ship: "TIE Advanced x1"
            skill: 6
            points: 6
            force: 3
            keyword: ["Dark Side", "Sith"]
            ship_override:
                shields: 3
            upgrades: [
                "Marksmanship"
                "Hate"
                "Afterburners"
            ]
        }
        {
            name: '"Backstabber" (BoY)'
            canonical_name: '"Backstabber"'.canonicalize()
            xws: "backstabber-battleofyavin"
            unique: true
            id: 565
            faction: "Galactic Empire"
            ship: "TIE/ln Fighter"
            skill: 5
            points: 4
            ship_override:
                hull: 4
            upgrades: [
                "Crack Shot"
                "Disciplined"
                "Afterburners"
            ]
        }
        {
            name: '"Mauler" Mithel (BoY)'
            canonical_name: '"Mauler" Mithel'.canonicalize()
            xws: "maulermithel-battleofyavin"
            unique: true
            id: 566
            faction: "Galactic Empire"
            ship: "TIE/ln Fighter"
            skill: 5
            points: 3
            ship_override:
                hull: 4
            upgrades: [
                "Predator"
                "Afterburners"
            ]
        }
        {
            name: '"Dark Curse" (BoY)'
            xws: "darkcurse-battleofyavin"
            unique: true
            id: 567
            faction: "Galactic Empire"
            ship: "TIE/ln Fighter"
            skill: 6
            points: 4
            ship_override:
                hull: 4
            upgrades: [
                "Ruthless"
                "Precision Ion Engines"
            ]
        }
        {
            name: '"Wampa" (BoY)'
            canonical_name: '"Wampa"'.canonicalize()
            xws: "wampa-battleofyavin"
            unique: true
            id: 568
            faction: "Galactic Empire"
            ship: "TIE/ln Fighter"
            skill: 1
            charge: 1
            recurring: 1
            points: 3
            ship_override:
                hull: 4
            upgrades: [
                "Elusive"
                "Vengeful (BoY)"
            ]
        }
        {
            name: "Iden Versio (BoY)"
            canonical_name: 'Iden Versio'.canonicalize()
            xws: "idenversio-battleofyavin"
            unique: true
            id: 569
            faction: "Galactic Empire"
            ship: "TIE/in Interceptor"
            skill: 4
            points: 6
            charge: 2
            recurring: 1
            chassis: "Sensitive Controls"
            ship_override:
                shields: 1
            upgrades: [
                "Predator"
                "Fanatic (BoY)"
            ]
        }
        {
            name: "Sigma 4 (BoY)"
            canonical_name: 'Sigma 4'.canonicalize()
            xws: "sigma4-battleofyavin"
            unique: true
            id: 570
            faction: "Galactic Empire"
            ship: "TIE/in Interceptor"
            skill: 4
            points: 4
            charge: 2
            chassis: "Sensitive Controls"
            ship_override:
                hull: 4
            upgrades: [
                "Disciplined"
                "Primed Thrusters"
            ]
        }
        {
            name: "Sigma 5 (BoY)"
            canonical_name: 'Sigma 5'.canonicalize()
            xws: "sigma5-battleofyavin"
            unique: true
            id: 571
            faction: "Galactic Empire"
            ship: "TIE/in Interceptor"
            skill: 4
            points: 4
            charge: 2
            chassis: "Sensitive Controls"
            ship_override:
                hull: 4
            upgrades: [
                "Sensor Jammer (BoY)"
                "Elusive"
            ]
        }
        {
            name: "Sigma 6 (BoY)"
            canonical_name: 'Sigma 6'.canonicalize()
            xws: "sigma6-battleofyavin"
            unique: true
            id: 572
            faction: "Galactic Empire"
            ship: "TIE/in Interceptor"
            skill: 4
            points: 4
            charge: 2
            chassis: "Sensitive Controls"
            ship_override:
                hull: 4
            upgrades: [
                "Daredevil"
                "Afterburners"
            ]
        }
        {
            name: "Sigma 7 (BoY)"
            canonical_name: 'Sigma 7'.canonicalize()
            xws: "sigma7-battleofyavin"
            unique: true
            id: 573
            faction: "Galactic Empire"
            ship: "TIE/in Interceptor"
            skill: 4
            points: 4
            charge: 2
            chassis: "Sensitive Controls"
            ship_override:
                hull: 4
                actions: [
                    "Focus"
                    "Evade"
                    "Barrel Roll"
                    "Boost"
                    "Lock"
                ]
            upgrades: [
                "Marksmanship"
                "Fire-Control System"
            ]
        }
        {
            name: "Anakin Skywalker (SoC)"
            canonical_name: 'Anakin Skywalker'.canonicalize()
            xws: "anakinskywalker-siegeofcoruscant"
            unique: true
            id: 574
            faction: "Galactic Republic"
            ship: "Eta-2 Actis"
            skill: 6
            points: 5
            force: 3
            chassis: "Intuitive Controls"
            keyword: ["Jedi","Light Side","Dark Side"]
            upgrades: [
                "Malice"
                "Ancillary Ion Weapons (SoC)"
                "R2-D2 (Republic)"
            ]
        }
        {
            name: "Obi-Wan Kenobi (SoC)"
            canonical_name: 'Obi-Wan Kenobi'.canonicalize()
            xws: "obiwankenobi-siegeofcoruscant"
            unique: true
            id: 575
            faction: "Galactic Republic"
            ship: "Eta-2 Actis"
            skill: 5
            points: 4
            force: 3
            chassis: "Intuitive Controls"
            keyword: ["Jedi","Light Side"]
            upgrades: [
                "Patience"
                "Ancillary Ion Weapons (SoC)"
                "R4-P17 (SoC)"
            ]
        }
        {
            name: "Shaak Ti (SoC)"
            canonical_name: 'Shaak Ti'.canonicalize()
            xws: "shaakti-siegeofcoruscant"
            unique: true
            id: 576
            faction: "Galactic Republic"
            ship: "Eta-2 Actis"
            skill: 4
            points: 4
            force: 2
            chassis: "Intuitive Controls"
            keyword: ["Jedi","Light Side"]
            upgrades: [
                "Marksmanship"
                "Brilliant Evasion"
                "Ancillary Ion Weapons (SoC)"
                "R4-P Astromech"
            ]
        }
        {
            name: '"Odd Ball" (SoC)'
            canonical_name: 'Odd Ball'.canonicalize()
            xws: "oddball-siegeofcoruscant"
            unique: true
            id: 577
            faction: "Galactic Republic"
            ship: "ARC-170 Starfighter"
            skill: 5
            points: 5
            chassis: "Born for This"
            ship_override:
                shields: 4
            upgrades: [
                "Selfless"
                "Veteran Tail Gunner"
                "R4-P Astromech"
            ]
        }
        {
            name: '"Wolffe" (SoC)'
            canonical_name: 'Wolffe'.canonicalize()
            xws: "wolffe-siegeofcoruscant"
            unique: true
            id: 578
            faction: "Galactic Republic"
            ship: "ARC-170 Starfighter"
            skill: 4
            charge: 1
            points: 4
            chassis: "Born for This"
            upgrades: [
                "Wolfpack (SoC)"
                "Veteran Tail Gunner"
                "Q7 Astromech"
            ]
        }
        {
            name: '"Jag" (SoC)'
            canonical_name: 'Jag'.canonicalize()
            xws: "jag-siegeofcoruscant"
            unique: true
            id: 579
            faction: "Galactic Republic"
            ship: "ARC-170 Starfighter"
            skill: 3
            points: 4
            chassis: "Born for This"
            upgrades: [
                "Veteran Tail Gunner"
                "R4-P Astromech"
                "Synchronized Console"
            ]
        }
        {
            name: '"Contrail" (SoC)'
            canonical_name: 'Contrail'.canonicalize()
            xws: "contrail-siegeofcoruscant"
            unique: true
            id: 580
            faction: "Galactic Republic"
            ship: "Nimbus-class V-wing"
            skill: 5
            points: 3
            chassis: "Born for This"
            upgrades: [
                "Ion Limiter Override"
                "Precise Astromech (BoY)"
                "Ion Bombs"
                'Alpha-3B "Besh"'
            ]
        }
        {
            name: '"Klick" (SoC)'
            canonical_name: 'Klick'.canonicalize()
            xws: "klick-siegeofcoruscant"
            unique: true
            id: 581
            faction: "Galactic Republic"
            ship: "Nimbus-class V-wing"
            skill: 4
            points: 3
            charge: 1
            recurring: 1
            chassis: "Born for This"
            ship_override:
                shields: 3
            upgrades: [
                "R3 Astromech"
                "Precision Ion Engines"
                'Alpha-3E "Esk"'
            ]
        }
        {
            name: '"Kickback" (SoC)'
            canonical_name: 'Kickback'.canonicalize()
            xws: "kickback-siegeofcoruscant"
            unique: true
            id: 582
            faction: "Galactic Republic"
            ship: "V-19 Torrent Starfighter"
            skill: 5
            points: 3
            chassis: "Born for This"
            ship_override:
                hull: 6
            upgrades: [
                "Diamond-Boron Missiles"
                "Munitions Failsafe"
            ]
        }
        {
            name: '"Axe" (SoC)'
            canonical_name: 'Axe'.canonicalize()
            xws: "axe-siegeofcoruscant"
            unique: true
            id: 583
            faction: "Galactic Republic"
            ship: "V-19 Torrent Starfighter"
            skill: 3
            points: 4
            chassis: "Born for This"
            ship_override:
                hull: 6
            upgrades: [
                "Deadeye Shot"
                "Barrage Rockets"
            ]
        }
        {
            name: "Count Dooku (SoC)"
            canonical_name: 'Count Dooku'.canonicalize()
            xws: "countdooku-siegeofcoruscant"
            unique: true
            id: 584
            faction: "Separatist Alliance"
            ship: "Sith Infiltrator"
            skill: 5
            points: 6
            force: 3
            keyword: ["Dark Side"]
            upgrades: [
                "Malice"
                "Roiling Anger (SoC)"
                "Scimitar"
            ]
        }
        {
            name: "DBS-32C (SoC)"
            canonical_name: 'DBS-32C'.canonicalize()
            xws: "dbs32c-siegeofcoruscant"
            unique: true
            id: 585
            faction: "Separatist Alliance"
            ship: "Hyena-class Droid Bomber"
            skill: 3
            points: 3
            charge: 2
            ship_override:
                actions: [
                    "Calculate"
                    "Lock"
                    "Barrel Roll"
                    "R-> Lock"
                    "R-Jam"
                ]
            upgrades: [
                "Plasma Torpedoes"
                "Contingency Protocol (SoC)"
                "Strut-Lock Override (SoC)"
            ]
        }
        {
            name: "DBS-404 (SoC)"
            canonical_name: 'DBS-404'.canonicalize()
            xws: "dbs404-siegeofcoruscant"
            unique: true
            id: 586
            faction: "Separatist Alliance"
            ship: "Hyena-class Droid Bomber"
            skill: 4
            points: 3
            upgrades: [
                "Adv. Proton Torpedoes"
                "Contingency Protocol (SoC)"
                "Strut-Lock Override (SoC)"
            ]
        }
        {
            name: "Baktoid Prototype (SoC)"
            canonical_name: 'Baktoid Prototype'.canonicalize()
            xws: "baktoidprototype-siegeofcoruscant"
            id: 587
            faction: "Separatist Alliance"
            ship: "Hyena-class Droid Bomber"
            skill: 1
            max_per_squad: 2
            points: 3
            upgrades: [
                "Homing Missiles"
                "Contingency Protocol (SoC)"
                "Strut-Lock Override (SoC)"
            ]
        }
        {
            name: "DIS-347 (SoC)"
            canonical_name: 'DIS-347'.canonicalize()
            xws: "dis347-siegeofcoruscant"
            unique: true
            id: 588
            faction: "Separatist Alliance"
            ship: "Droid Tri-fighter"
            skill: 3
            points: 4
            upgrades: [
                "Marksmanship"
                "Afterburners"
                "Contingency Protocol (SoC)"
            ]
        }
        {
            name: "DIS-T81 (SoC)"
            canonical_name: 'DIS-T81'.canonicalize()
            xws: "dist81-siegeofcoruscant"
            unique: true
            id: 589
            faction: "Separatist Alliance"
            ship: "Droid Tri-fighter"
            skill: 4
            points: 5
            upgrades: [
                "Outmaneuver"
                "Afterburners"
                "Contingency Protocol (SoC)"
            ]
        }
        {
            name: "Phlac-Arphocc Prototype (SoC)"
            canonical_name: 'Phlac-Arphocc Prototype'.canonicalize()
            xws: "phlacarphoccprototype-siegeofcoruscant"
            id: 590
            faction: "Separatist Alliance"
            ship: "Droid Tri-fighter"
            skill: 5
            points: 4
            max_per_squad: 2
            upgrades: [
                "Afterburners"
                "Contingency Protocol (SoC)"
                "Evasion Sequence 7 (SoC)"
            ]
        }
        {
            name: "DFS-081 (SoC)"
            canonical_name: 'DFS-081'.canonicalize()
            xws: "dfs081-siegeofcoruscant"
            unique: true
            id: 591
            faction: "Separatist Alliance"
            ship: "Vulture-class Droid Fighter"
            skill: 3
            charge: 2
            points: 2
            upgrades: [
                "Discord Missiles"
                "Contingency Protocol (SoC)"
                "Strut-Lock Override (SoC)"
            ]
        }
        {
            name: "DFS-311 (SoC)"
            canonical_name: 'DFS-311'.canonicalize()
            xws: "dfs311-siegeofcoruscant"
            unique: true
            id: 592
            faction: "Separatist Alliance"
            ship: "Vulture-class Droid Fighter"
            skill: 1
            points: 3
            upgrades: [
                "Discord Missiles"
                "Contingency Protocol (SoC)"
                "Strut-Lock Override (SoC)"
            ]
        }
        {
            name: "Haor Chall Prototype (SoC)"
            canonical_name: 'Haor Chall Prototype'.canonicalize()
            xws: "haorchallprototype-siegeofcoruscant"
            id: 593
            faction: "Separatist Alliance"
            ship: "Vulture-class Droid Fighter"
            skill: 1
            max_per_squad: 2
            points: 2
            upgrades: [
                "Ion Missiles"
                "Contingency Protocol (SoC)"
                "Strut-Lock Override (SoC)"
            ]
        }
        {
            name: "Corran Horn (X-Wing)"
            id: 594
            unique: true
            xws: "corranhorn-t65xwing"
            faction: "Rebel Alliance"
            ship: "T-65 X-wing"
            skill: 5
            points: 5
            loadout: 18
            slots: [
                "Talent"
                "Torpedo"
                "Astromech"
                "Configuration"
            ]
        }
        {
            name: "Wes Janson"
            id: 595
            unique: true
            faction: "Rebel Alliance"
            ship: "T-65 X-wing"
            skill: 5
            charge: 1
            recurring: 1
            points: 5
            loadout: 15
            slots: [
                "Talent"
                "Torpedo"
                "Astromech"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Tycho Celchu"
            id: 596
            unique: true
            faction: "Rebel Alliance"
            ship: "RZ-1 A-wing"
            skill: 5
            points: 4
            loadout: 14
            slots: [
                "Talent"
                "Talent"
                "Cannon"
                "Missile"
                "Configuration"
            ]
        }
        {
            name: "Keo Venzee"
            id: 597
            unique: true
            faction: "Rebel Alliance"
            ship: "RZ-1 A-wing"
            skill: 3
            points: 3
            loadout: 8
            force: 1
            forcerecurring: 0
            slots: [
                "Talent"
                "Missile"
                "Configuration"
            ]
        }
        {
            name: '"Pops" Krail'
            id: 598
            unique: true
            faction: "Rebel Alliance"
            ship: "BTL-A4 Y-wing"
            skill: 3
            points: 4
            loadout: 16
            slots: [
                "Talent"
                "Turret"
                "Torpedo"
                "Astromech"
                "Device"
                "Missile"
                "Modification"
            ]
        }
        {
            name: "Flight Leader Ubbel"
            id: 599
            unique: true
            faction: "Galactic Empire"
            ship: "TIE/rb Heavy"
            skill: 5
            points: 5
            loadout: 15
            slots: [
                "Talent"
                "Cannon"
                "Cannon"
                "Gunner"
                "Modification"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Juno Eclipse"
            id: 600
            unique: true
            faction: "Galactic Empire"
            ship: "TIE Advanced x1"
            skill: 5
            points: 4
            loadout: 8
            slots: [
                "Talent"
                "Tech"
                "Sensor"
                "Missile"
                "Modification"
            ]
        }
        {
            name: "Second Sister"
            id: 601
            unique: true
            faction: "Galactic Empire"
            ship: "TIE/in Interceptor"
            skill: 4
            force: 2
            points: 5
            loadout: 14
            keyword: ["Dark Side"]
            slots: [
                "Force"
                "Talent"
                "Missile"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Magna Tolvan"
            id: 602
            unique: true
            faction: "Galactic Empire"
            ship: "TIE/ln Fighter"
            skill: 3
            points: 3
            loadout: 10
            slots: [
                "Talent"
                "Cannon"
                "Modification"
            ]
        }
        {
            name: "Yrica Quell"
            id: 603
            unique: true
            faction: "Galactic Empire"
            ship: "TIE/ln Fighter"
            skill: 3
            points: 3
            loadout: 9
            slots: [
                "Talent"
                "Missile"
                "Modification"
            ]
        }
        {
            name: "Poe Dameron (YT-1300)"
            canonical_name: 'Poe Dameron'.canonicalize()
            xws: "poedameron-scavengedyt1300"
            id: 604
            unique: true
            faction: "Resistance"
            ship: "Scavenged YT-1300"
            skill: 6
            charge: 2
            recurring: 1
            points: 7
            loadout: 25
            slots: [
                "Talent"
                "Talent"
                "Missile"
                "Crew"
                "Gunner"
                "Illicit"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Lando Calrissian (Resistance)"
            xws: "landocalrissian-scavengedyt1300"
            id: 605
            unique: true
            faction: "Resistance"
            ship: "Scavenged YT-1300"
            skill: 5
            charge: 3
            recurring: 1
            points: 8
            loadout: 20
            slots: [
                "Talent"
                "Missile"
                "Crew"
                "Crew"
                "Gunner"
                "Illicit"
                "Illicit"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Venisa Doza"
            id: 606
            unique: true
            faction: "Resistance"
            ship: "T-70 X-wing"
            skill: 4
            points: 5
            loadout: 13
            slots: [
                "Talent"
                "Tech"
                "Missile"
                "Missile"
                "Astromech"
                "Modification"
                "Modification"
                "Configuration"
                "HardpointShip"
            ]
        }
        {
            name: "Zay Versio"
            id: 607
            unique: true
            faction: "Resistance"
            ship: "T-70 X-wing"
            skill: 3
            points: 4
            loadout: 7
            slots: [
                "Talent"
                "Talent"
                "Tech"
                "Astromech"
                "Modification"
                "Configuration"
                "HardpointShip"
            ]
        }
        {
            name: "Taka Jamoreesa"
            id: 608
            unique: true
            faction: "Resistance"
            ship: "Resistance Transport"
            skill: 2
            points: 4
            loadout: 15
            slots: [
                "Talent"
                "Tech"
                "Cannon"
                "Cannon"
                "Torpedo"
                "Astromech"
                "Illicit"
                "Modification"
            ]
        }
        {
            name: "Hondo Ohnaka"
            id: 609
            unique: true
            faction: "Scum and Villainy"
            ship: "Firespray-class Patrol Craft"
            skill: 1
            points: 7
            loadout: 18
            slots: [
                "Cannon"
                "Cannon"
                "Missile"
                "Crew"
                "Device"
                "Illicit"
                "Illicit"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Tor Phun"
            id: 610
            unique: true
            faction: "Scum and Villainy"
            ship: "Fang Fighter"
            skill: 3
            points: 4
            loadout: 7
            keyword: ["Mandalorian"]
            slots: [
                "Talent"
                "Missile"
                "Modification"
                "Modification"
            ]
        }
        {
            name: "Durge"
            id: 611
            unique: true
            faction: "Scum and Villainy"
            ship: "Rogue-class Starfighter"
            skill: 5
            points: 4
            loadout: 10
            keyword: ["Bounty Hunter"]
            slots: [
                "Talent"
                "Talent"
                "Cannon"
                "Cannon"
                "Illicit"
                "Modification"
            ]
        }
        {
            name: "Doctor Aphra"
            id: 612
            unique: true
            faction: "Scum and Villainy"
            ship: "YV-666 Light Freighter"
            skill: 3
            points: 6
            loadout: 22
            charge: 3
            slots: [
                "Cannon"
                "Missile"
                "Crew"
                "Crew"
                "Gunner"
                "Illicit"
                "Illicit"
                "Modification"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Lapin"
            id: 613
            unique: true
            faction: "Scum and Villainy"
            ship: "Modified TIE/ln Fighter"
            skill: 3
            points: 3
            loadout: 7
            slots: [
                "Talent"
                "Cannon"
                "Modification"
                "Modification"
            ]
        }
        {
            name: "Volan Das"
            id: 614
            unique: true
            faction: "Separatist Alliance"
            ship: "Droid Tri-fighter"
            skill: 5
            points: 4
            loadout: 12
            chassis: "Modified for Organics"
            keyword: ["Bounty Hunter"]
            slots: [
                "Talent"
                "Missile"
                "Illicit"
                "Modification"
            ]
            ship_override:
                actions: [
                    "Focus"
                    "Evade"
                    "Lock"
                    "Barrel Roll"
                    "R-> Evade"
                    "Boost"
                    "R-> Focus"
                ]
        }
        {
            name: "Aurra Sing"
            id: 615
            unique: true
            faction: "Separatist Alliance"
            ship: "Firespray-class Patrol Craft"
            skill: 4
            force: 1
            points: 8
            loadout: 18
            keyword: ["Dark Side","Bounty Hunter"]
            slots: [
                "Talent"
                "Cannon"
                "Cannon"
                "Device"
                "Illicit"
                "Modification"
                "Title"
            ]
        }
        {
            name: "Durge (Separatist)"
            xws: "durge-separatistalliance"
            id: 616
            unique: true
            faction: "Separatist Alliance"
            ship: "Rogue-class Starfighter"
            skill: 5
            charge: 1
            points: 4
            loadout: 10
            keyword: ["Bounty Hunter"]
            slots: [
                "Talent"
                "Cannon"
                "Cannon"
                "Illicit"
                "Modification"
                "Modification"
                "Title"
            ]
        }
        {
            name: "The Iron Assembler"
            id: 617
            unique: true
            faction: "Separatist Alliance"
            ship: "Vulture-class Droid Fighter"
            skill: 1
            charge: 3
            points: 2
            loadout: 5
            keyword: ["Droid"]
            slots: [
                "Missile"
                "Modification"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Kelrodo-Ai Holdout"
            id: 618
            faction: "Separatist Alliance"
            ship: "Vulture-class Droid Fighter"
            skill: 1
            max_per_squad: 3
            points: 2
            loadout: 7
            chassis: "Modified for Organics"
            slots: [
                "Talent"
                "Missile"
                "Modification"
            ]
            ship_override:
                actions: [
                    "Calculate"
                    "Lock"
                    "Barrel Roll"
                    "R-> Focus"
                ]
        }
        {
            name: "Adi Gallia"
            id: 619
            unique: true
            faction: "Galactic Republic"
            ship: "Delta-7 Aethersprite"
            skill: 5
            points: 5
            loadout: 12
            force: 2
            keyword: ["Jedi","Light Side"]
            slots: [
                "Force"
                "Talent"
                "Astromech"
                "Modification"
                "Configuration"
            ]
        }
        {
            name: "Adi Gallia (Delta-7B)"
            canonical_name: 'Adi Gallia'.canonicalize()
            xws: "adigallia-delta7baethersprite"
            id: 620
            unique: true
            faction: "Galactic Republic"
            ship: "Delta-7b Aethersprite"
            skill: 5
            force: 2
            points: 7
            loadout: 18
            keyword: ["Jedi","Light Side"]
            slots: [
                "Force"
                "Talent"
                "Astromech"
                "Modification"
            ]
        }
        {
            name: '"Sicko"'
            id: 621
            unique: true
            faction: "Galactic Republic"
            ship: "LAAT/i Gunship"
            skill: 2
            charge: 2
            recurring: 1
            points: 5
            loadout: 12
            keyword: ["Clone"]
            slots: [
                "Talent"
                "Missile"
                "Missile"
                "Crew"
                "Crew"
                "Gunner"
                "Gunner"
                "Modification"
            ]
            applies_condition: 'Sickening Maneuver'.canonicalize()
        }
        {
            name: "Kit Fisto"
            id: 622
            unique: true
            faction: "Galactic Republic"
            ship: "Eta-2 Actis"
            skill: 4
            force: 2
            points: 4
            loadout: 8
            keyword: ["Jedi","Light Side"]
            slots: [
                "Force"
                "Force"
                "Talent"
                "Astromech"
                "Modification"
            ]
        }
        {
            name: '"Slammer"'
            id: 623
            unique: true
            faction: "Galactic Republic"
            ship: "V-19 Torrent Starfighter"
            skill: 1
            charge: 2
            recurring: 1
            points: 3
            loadout: 7
            keyword: ["Clone"]
            slots: [
                "Talent"
                "Missile"
                "Missile"
                "Modification"
            ]
        }
        {
            name: "Gavyn Sykes"
            id: 624
            unique: true
            faction: "Galactic Republic"
            ship: "Naboo Royal N-1 Starfighter"
            skill: 3
            points: 4
            loadout: 16
            slots: [
                "Talent"
                "Sensor"
                "Astromech"
                "Torpedo"
                "Modification"
            ]
        }
        {
            name: "Lieutenant Galek"
            id: 625
            unique: true
            faction: "First Order"
            ship: "TIE/fo Fighter"
            skill: 5
            points: 3
            loadout: 8
            slots: [
                "Talent"
                "Tech"
                "Tech"
                "Cannon"
                "Modification"
            ]
        }
        {
            name: "Jul Jerjerrod"
            id: 626
            unique: true
            faction: "First Order"
            ship: "TIE/se Bomber"
            skill: 4
            charge: 3
            points: 4
            loadout: 13
            slots: [
                "Talent"
                "Tech"
                "Torpedo"
                "Missile"
                "Gunner"
                "Device"
                "Device"
                "Modification"
                "Modification"
            ]
        }
        {
            name: "DT-798"
            id: 627
            unique: true
            faction: "First Order"
            ship: "TIE/fo Fighter"
            skill: 4
            points: 3
            loadout: 8
            slots: [
                "Talent"
                "Tech"
                "Modification"
                "Modification"
            ]
        }
        {
            name: "Lin Gaava"
            id: 628
            unique: true
            faction: "First Order"
            ship: "TIE/fo Fighter"
            skill: 3
            points: 3
            loadout: 9
            slots: [
                "Talent"
                "Talent"
                "Tech"
                "Modification"
            ]
            applies_condition: '''Primed For Speed'''.canonicalize()
        }
        {
            name: "Agent Tierny"
            id: 629
            unique: true
            faction: "First Order"
            ship: "Xi-class Light Shuttle"
            skill: 3
            points: 5
            loadout: 15
            slots: [
                "Talent"
                "Talent"
                "Tech"
                "Crew"
                "Crew"
                "Modification"
                "Modification"
            ]
            ship_override:
                actions: [
                    "Focus"
                    "Lock"
                    "R-Coordinate"
                    "Jam"
                ]
            applies_condition: '''Broken Trust'''.canonicalize()
        }
    ]

    upgradesById: [
        {
            name: '"Chopper" (Astromech)'
            id: 0
            slot: "Astromech"
            canonical_name: '"Chopper"'.canonicalize()
            xws: "chopper"
            points: 2
            unique: true
            faction: "Rebel Alliance"
        }
        {
            name: '"Genius"'
            id: 1
            slot: "Astromech"
            points: 2
            unique: true
            faction: "Scum and Villainy"
        }
        {
            name: "R2 Astromech"
            id: 2
            slot: "Astromech"
            points: 6
            charge: 2
        }
        {
            name: "R2-D2"
            id: 3
            unique: true
            slot: "Astromech"
            points: 8
            charge: 3
            faction: "Rebel Alliance"
        }
        {
            name: "R3 Astromech"
            id: 4
            slot: "Astromech"
            points: 4
        }
        {
            name: "R4 Astromech"
            id: 5
            slot: "Astromech"
            points: 3
            restrictions: [
                ["Base", "Small"]
            ]
            modifier_func: (stats) ->
                if stats.maneuvers[1]?
                    for turn in [0 ... stats.maneuvers[1].length]
                        if turn > 4
                            continue
                        if stats.maneuvers[1][turn] > 1
                            stats.maneuvers[1][turn]--
                        if stats.maneuvers[2][turn] > 1
                            stats.maneuvers[2][turn]--
        }
        {
            name: "R5 Astromech"
            id: 6
            slot: "Astromech"
            points: 4
            charge: 2
        }
        {
            name: "R5-D8"
            id: 7
            unique: true
            slot: "Astromech"
            points: 6
            charge: 3
            faction: "Rebel Alliance"
        }
        {
            name: "R5-P8"
            id: 8
            slot: "Astromech"
            points: 4
            unique: true
            faction: "Scum and Villainy"
            charge: 3
        }
        {
            name: "R5-TK"
            id: 9
            slot: "Astromech"
            points: 0
            unique: true
            faction: "Scum and Villainy"
        }
        {
            name: "Heavy Laser Cannon"
            id: 10
            slot: "Cannon"
            points: 4
            attackbull: 4
            range: """2-3"""
        }
        {
            name: "Ion Cannon"
            id: 11
            slot: "Cannon"
            points: 6
            attack: 3
            range: """1-3"""
        }
        {
            name: "Jamming Beam"
            id: 12
            slot: "Cannon"
            points: 0
            attack: 3
            range: """1-2"""
        }
        {
            name: "Tractor Beam"
            id: 13
            slot: "Cannon"
            points: 4
            attack: 3
            range: """1-3"""
        }
        {
            name: "Admiral Sloane"
            id: 14
            slot: "Crew"
            points: 16
            unique: true
            faction: "Galactic Empire"
        }
        {
            name: "Agent Kallus"
            id: 15
            slot: "Crew"
            points: 5
            unique: true
            faction: "Galactic Empire"
            applies_condition: 'Hunted'.canonicalize()
        }
        {
            name: "Boba Fett"
            id: 16
            slot: "Crew"
            points: 2
            unique: true
            faction: "Scum and Villainy"
        }
        {
            name: "Baze Malbus"
            id: 17
            slot: "Crew"
            points: 5
            unique: true
            faction: "Rebel Alliance"
        }
        {
            name: "C-3PO"
            id: 18
            slot: "Crew"
            points: 5
            unique: true
            faction: "Rebel Alliance"
            modifier_func: (stats) ->
                stats.actions.push 'Calculate' if 'Calculate' not in stats.actions
        }
        {
            name: "Cassian Andor"
            id: 19
            slot: "Crew"
            points: 5
            unique: true
            faction: "Rebel Alliance"
        }
        {
            name: "Cad Bane"
            id: 20
            slot: "Crew"
            points: 3
            unique: true
            faction: "Scum and Villainy"
        }
        {
            name: "Chewbacca"
            id: 21
            slot: "Crew"
            points: 3
            unique: true
            faction: "Rebel Alliance"
            charge: 2
            recurring: 1
        }
        {
            name: "Chewbacca (Scum)"
            id: 22
            slot: "Crew"
            xws: "chewbacca-crew"
            points: 3
            unique: true
            faction: "Scum and Villainy"
        }
        {
            name: '"Chopper" (Crew)'
            id: 23
            canonical_name: '"Chopper"'.canonicalize()
            xws: "chopper-crew"
            slot: "Crew"
            points: 1
            unique: true
            faction: "Rebel Alliance"
        }
        {
            name: "Ciena Ree"
            id: 24
            slot: "Crew"
            points: 4
            unique: true
            faction: "Galactic Empire"
            restrictions: [
                ["Action", "Coordinate"]
            ]
        }
        {
            name: "Cikatro Vizago"
            id: 25
            slot: "Crew"
            points: 1
            unique: true
            faction: "Scum and Villainy"
        }
        {
            name: "Darth Vader"
            id: 26
            slot: "Crew"
            points: 14
            force: 1
            unique: true
            faction: "Galactic Empire"
            modifier_func: (stats) ->
                stats.force += 1
        }
        {
            name: "Death Troopers"
            id: 27
            slot: "Crew"
            points: 6
            unique: true
            faction: "Galactic Empire"
            restrictions: [
                ["Slot", "Crew"]
            ]
            validation_func: (ship, upgrade_obj) ->
                upgrade_obj.occupiesAnUpgradeSlot "Crew"
            also_occupies_upgrades: [ "Crew" ]
        }
        {
            name: "Director Krennic"
            id: 28
            slot: "Crew"
            points: 4
            unique: true
            faction: "Galactic Empire"
            applies_condition: 'Optimized Prototype'.canonicalize()
            modifier_func: (stats) ->
                stats.actions.push 'Lock' if 'Lock' not in stats.actions
        }
        {
            name: "Emperor Palpatine"
            id: 29
            slot: "Crew"
            points: 12
            force: 1
            unique: true
            faction: "Galactic Empire"
            restrictions: [
                ["Slot", "Crew"]
            ]
            validation_func: (ship, upgrade_obj) ->
                upgrade_obj.occupiesAnUpgradeSlot "Crew"
            also_occupies_upgrades: [ "Crew" ]
            modifier_func: (stats) ->
                stats.force += 1
        }
        {
            name: "Freelance Slicer"
            id: 30
            slot: "Crew"
            points: 3
        }
        {
            name: "4-LOM"
            id: 31
            slot: "Crew"
            points: 5
            unique: true
            faction: "Scum and Villainy"
        }
        {
            name: 'GNK "Gonk" Droid'
            id: 32
            slot: "Crew"
            points: 5
            charge: 1
        }
        {
            name: "Grand Inquisitor"
            id: 33
            slot: "Crew"
            points: 13
            unique: true
            force: 1
            faction: "Galactic Empire"
            modifier_func: (stats) ->
                stats.force += 1
        }
        {
            name: "Grand Moff Tarkin"
            id: 34
            slot: "Crew"
            points: 4
            unique: true
            faction: "Galactic Empire"
            charge: 2
            recurring: 1
            restrictions: [
                ["Action", "Lock"]
            ]
        }
        {
            name: "Hera Syndulla"
            id: 35
            slot: "Crew"
            points: 4
            unique: true
            faction: "Rebel Alliance"
        }
        {
            name: "IG-88D"
            id: 36
            slot: "Crew"
            points: 3
            unique: true
            faction: "Scum and Villainy"
            modifier_func: (stats) ->
                stats.actions.push 'Calculate' if 'Calculate' not in stats.actions

        }
        {
            name: "Informant"
            id: 37
            slot: "Crew"
            points: 4
            unique: true
            applies_condition: 'Listening Device'.canonicalize()
        }
        {
            name: "ISB Slicer"
            id: 38
            slot: "Crew"
            points: 1
            faction: "Galactic Empire"
        }
        {
            name: "Jabba the Hutt"
            id: 39
            slot: "Crew"
            points: 11
            unique: true
            faction: "Scum and Villainy"
            charge: 4
            restrictions: [
                ["Slot", "Crew"]
            ]
            validation_func: (ship, upgrade_obj) ->
                upgrade_obj.occupiesAnUpgradeSlot "Crew"
            also_occupies_upgrades: [ "Crew" ]
        }
        {
            name: "Jyn Erso"
            id: 40
            slot: "Crew"
            points: 5
            unique: true
            faction: "Rebel Alliance"
        }
        {
            name: "Kanan Jarrus"
            id: 41
            slot: "Crew"
            points: 12
            force: 1
            unique: true
            faction: "Rebel Alliance"
            modifier_func: (stats) ->
                stats.force += 1
        }
        {
            name: "Ketsu Onyo"
            id: 42
            slot: "Crew"
            points: 4
            unique: true
            faction: "Scum and Villainy"
        }
        {
            name: "L3-37"
            id: 43
            slot: "Crew"
            points: 4
            unique: true
            faction: "Scum and Villainy"
        }
        {
            name: "Lando Calrissian"
            id: 44
            slot: "Crew"
            xws: "landocalrissian"
            points: 2
            unique: true
            faction: "Rebel Alliance"
        }
        {
            name: "Lando Calrissian (Scum)"
            id: 45
            slot: "Crew"
            xws: "landocalrissian-crew"
            points: 4
            unique: true
            faction: "Scum and Villainy"
        }
        {
            name: "Leia Organa"
            id: 46
            slot: "Crew"
            points: 7
            unique: true
            faction: "Rebel Alliance"
            charge: 3
            recurring: 1
        }
        {
            name: "Latts Razzi"
            id: 47
            slot: "Crew"
            points: 5
            unique: true
            faction: "Scum and Villainy"
        }
        {
            name: "Maul"
            id: 48
            slot: "Crew"
            points: 10
            unique: true
            keyword: ["Dark Side"]
            faction: ["Scum and Villainy", "Rebel Alliance"]
            force: 1
            restrictions: [
                ["FactionOrUnique", "Ezra Bridger", "Scum and Villainy"]
            ]
            modifier_func: (stats) ->
                stats.force += 1
        }
        {
            name: "Minister Tua"
            id: 49
            slot: "Crew"
            points: 4
            unique: true
            faction: "Galactic Empire"
        }
        {
            name: "Moff Jerjerrod"
            id: 50
            slot: "Crew"
            points: 7
            unique: true
            faction: "Galactic Empire"
            charge: 2
            recurring: 1
            restrictions: [
                ["Action", "Coordinate"]
            ]
        }
        {
            name: "Magva Yarro"
            id: 51
            slot: "Crew"
            points: 5
            unique: true
            faction: "Rebel Alliance"
        }
        {
            name: "Nien Nunb"
            id: 52
            slot: "Crew"
            points: 5
            unique: true
            faction: "Rebel Alliance"
            modifier_func: (stats) ->
                if stats.maneuvers[1]?
                    for s in (stats.maneuvers)
                        if s[1] > 1
                            s[1]--
                        if s[3] > 1
                            s[3]--
        }
        {
            name: "Novice Technician"
            id: 53
            slot: "Crew"
            points: 2
        }
        {
            name: "Perceptive Copilot"
            id: 54
            slot: "Crew"
            points: 8
        }
        {
            name: "Qi'ra"
            id: 55
            slot: "Crew"
            points: 2
            unique: true
            faction: "Scum and Villainy"
        }
        {
            name: "R2-D2 (Crew)"
            canonical_name: 'R2-D2'.canonicalize()
            id: 56
            slot: "Crew"
            xws: "r2d2-crew"
            points: 8
            unique: true
            faction: "Rebel Alliance"
        }
        {
            name: "Sabine Wren"
            id: 57
            slot: "Crew"
            points: 3
            unique: true
            faction: "Rebel Alliance"
        }
        {
            name: "Saw Gerrera"
            id: 58
            slot: "Crew"
            points: 9
            unique: true
            faction: "Rebel Alliance"
        }
        {
            name: "Seasoned Navigator"
            id: 59
            slot: "Crew"
            points: 7
        }
        {
            name: "Seventh Sister"
            id: 60
            slot: "Crew"
            points: 9
            force: 1
            unique: true
            faction: "Galactic Empire"
            modifier_func: (stats) ->
                stats.force += 1
        }
        {
            name: "Tactical Officer"
            id: 61
            slot: "Crew"
            points: 3
            restrictions: [
                ["Action", "R-Coordinate"]
            ]
            modifier_func: (stats) ->
                stats.actions.push 'Coordinate' if 'Coordinate' not in stats.actions
        }
        {
            name: "Tobias Beckett"
            id: 62
            slot: "Crew"
            points: 2
            unique: true
            faction: "Scum and Villainy"
        }
        {
            name: "0-0-0"
            id: 63
            slot: "Crew"
            points: 5
            unique: true
            faction: ["Scum and Villainy", "Galactic Empire"]
            restrictions: [
                ["FactionOrUnique", "Darth Vader", "Scum and Villainy"]
            ]
        }
        {
            name: "Unkar Plutt"
            id: 64
            slot: "Crew"
            points: 2
            unique: true
            faction: "Scum and Villainy"
        }
        {
            name: '"Zeb" Orrelios'
            id: 65
            slot: "Crew"
            points: 1
            unique: true
            faction: "Rebel Alliance"
        }
        {
            name: "Zuckuss"
            id: 66
            slot: "Crew"
            points: 2
            unique: true
            faction: "Scum and Villainy"
        }
        {
            name: "Bomblet Generator"
            id: 67
            slot: "Device"
            points: 2
            charge: 2
            applies_condition: 'Bomblet'.canonicalize()
            restrictions: [
                ["Slot", "Device"]
            ]
            validation_func: (ship, upgrade_obj) ->
                upgrade_obj.occupiesAnUpgradeSlot "Device"
            also_occupies_upgrades: [ "Device" ]
        }
        {
            name: "Conner Nets"
            id: 68
            slot: "Device"
            points: 5
            charge: 1
            applies_condition: 'Conner Net'.canonicalize()
        }
        {
            name: "Proton Bombs"
            id: 69
            slot: "Device"
            points: 4
            charge: 2
            applies_condition: 'Proton Bomb'.canonicalize()
        }
        {
            name: "Proximity Mines"
            id: 70
            slot: "Device"
            points: 8
            charge: 2
            applies_condition: 'Proximity Mine'.canonicalize()
        }
        {
            name: "Seismic Charges"
            id: 71
            slot: "Device"
            points: 3
            charge: 2
            applies_condition: 'Seismic Charge'.canonicalize()
        }
        {
            name: "Heightened Perception"
            id: 72
            slot: "Force"
            points: 3
        }
        {
            name: "Instinctive Aim"
            id: 73
            slot: "Force"
            points: 2
        }
        {
            name: "Supernatural Reflexes"
            id: 74
            slot: "Force"
            points: 24
            restrictions: [
                ["Base", "Small"]
            ]
        }
        {
            name: "Sense"
            id: 75
            slot: "Force"
            points: 6
        }
        {
            name: "Agile Gunner"
            id: 76
            slot: "Gunner"
            points: 3
        }
        {
            name: "Bistan"
            id: 77
            slot: "Gunner"
            points: 8
            unique: true
            faction: "Rebel Alliance"
        }
        {
            name: "Bossk"
            id: 78
            slot: "Gunner"
            points: 6
            unique: true
            faction: "Scum and Villainy"
        }
        {
            name: "BT-1"
            id: 79
            slot: "Gunner"
            points: 2
            unique: true
            faction: ["Scum and Villainy", "Galactic Empire"]
            restrictions: [
                ["FactionOrUnique", "Darth Vader", "Scum and Villainy"]
            ]
        }
        {
            name: "Dengar"
            id: 80
            slot: "Gunner"
            points: 6
            unique: true
            faction: "Scum and Villainy"
            recurring: 1
            charge: 1

        }
        {
            name: "Ezra Bridger"
            id: 81
            slot: "Gunner"
            points: 10
            force: 1
            unique: true
            faction: "Rebel Alliance"
            modifier_func: (stats) ->
                stats.force += 1
        }
        {
            name: "Fifth Brother"
            id: 82
            slot: "Gunner"
            points: 12
            force: 1
            unique: true
            faction: "Galactic Empire"
            modifier_func: (stats) ->
                stats.force += 1
        }
        {
            name: "Greedo"
            id: 83
            slot: "Gunner"
            points: 1
            unique: true
            faction: "Scum and Villainy"
            charge: 1
            recurring: 1
        }
        {
            name: "Han Solo"
            id: 84
            slot: "Gunner"
            xws: "hansolo"
            points: 10
            unique: true
            faction: "Rebel Alliance"
        }
        {
            name: "Han Solo (Scum)"
            id: 85
            slot: "Gunner"
            xws: "hansolo-gunner"
            points: 9
            unique: true
            faction: "Scum and Villainy"
        }
        {
            name: "Hotshot Gunner"
            id: 86
            slot: "Gunner"
            points: 6
        }
        {
            name: "Luke Skywalker"
            id: 87
            slot: "Gunner"
            points: 12
            force: 1
            unique: true
            faction: "Rebel Alliance"
            modifier_func: (stats) ->
                stats.force += 1
        }
        {
            name: "Skilled Bombardier"
            id: 88
            slot: "Gunner"
            points: 2
        }
        {
            name: "Veteran Tail Gunner"
            id: 89
            slot: "Gunner"
            points: 3
            restrictions: [
                ["AttackArc", "Rear Arc"]
            ]
        }
        {
            name: "Veteran Turret Gunner"
            id: 90
            slot: "Gunner"
            points: 5
            restrictions: [
                ["Action", "Rotate Arc"]
            ]
        }
        {
            name: "Cloaking Device"
            id: 91
            slot: "Illicit"
            points: 3
            unique: true
            charge: 2
            restrictions: [
                ["Base", "Small", "Medium"]
            ]
        }
        {
            name: "Contraband Cybernetics"
            id: 92
            slot: "Illicit"
            points: 3
            charge: 1
        }
        {
            name: "Deadman's Switch"
            id: 93
            slot: "Illicit"
            points: 2
        }
        {
            name: "Feedback Array"
            id: 94
            slot: "Illicit"
            points: 4
        }
        {
            name: "Inertial Dampeners"
            id: 95
            slot: "Illicit"
            points: 8
        }
        {
            name: "Rigged Cargo Chute"
            id: 96
            slot: "Illicit"
            points: 4
            charge: 1
            applies_condition: '''Loose Cargo'''.canonicalize()
            restrictions: [
                ["Base", "Medium", "Large"]
            ]
        }
        {
            name: "Barrage Rockets"
            id: 97
            slot: "Missile"
            points: 8
            attack: 3
            range: """2-3"""
            rangebonus: true
            charge: 5
            restrictions: [
                ["Slot", "Missile"]
            ]
            validation_func: (ship, upgrade_obj) ->
                upgrade_obj.occupiesAnUpgradeSlot "Missile"
            also_occupies_upgrades: [ "Missile" ]
        }
        {
            name: "Cluster Missiles"
            id: 98
            slot: "Missile"
            points: 4
            attack: 3
            range: """1-2"""
            rangebonus: true
            charge: 4
        }
        {
            name: "Concussion Missiles"
            id: 99
            slot: "Missile"
            points: 5
            attack: 3
            range: """2-3"""
            rangebonus: true
            charge: 3
        }
        {
            name: "Homing Missiles"
            id: 100
            slot: "Missile"
            points: 5
            attack: 4
            range: """2-3"""
            rangebonus: true
            charge: 2
        }
        {
            name: "Ion Missiles"
            id: 101
            slot: "Missile"
            points: 4
            attack: 3
            range: """2-3"""
            rangebonus: true
            charge: 3
        }
        {
            name: "Proton Rockets"
            id: 102
            slot: "Missile"
            points: 8
            attackbull: 5
            range: """1-2"""
            rangebonus: true
            charge: 1
        }
        {
            name: "Ablative Plating"
            id: 103
            slot: "Modification"
            points: 4
            charge: 2
            restrictions: [
                ["Base", "Medium", "Large"]
            ]
        }
        {
            name: "Advanced SLAM"
            id: 104
            slot: "Modification"
            points: 3
            restrictions: [
                ["Action", "Slam"]
            ]
        }
        {
            name: "Afterburners"
            id: 105
            slot: "Modification"
            points: 10
            charge: 2
            restrictions: [
                ["Base", "Small"]
            ]
        }
        {
            name: "Electronic Baffle"
            id: 106
            slot: "Modification"
            points: 2
        }
        {
            name: "Engine Upgrade"
            id: 107
            slot: "Modification"
            points: 3
            restrictions: [
                ["Action", "R-Boost"]
            ]
            modifier_func: (stats) ->
                stats.actions.push 'Boost' if 'Boost' not in stats.actions
        }
        {
            name: "Munitions Failsafe"
            id: 108
            slot: "Modification"
            points: 1
        }
        {
            name: "Static Discharge Vanes"
            id: 109
            slot: "Modification"
            points: 5
        }
        {
            name: "Tactical Scrambler"
            id: 110
            slot: "Modification"
            points: 2
            restrictions: [
                ["Base", "Medium", "Large"]
            ]
        }
        {
            name: "Advanced Sensors"
            id: 111
            slot: "Sensor"
            points: 12
        }
        {
            name: "Collision Detector"
            id: 112
            slot: "Sensor"
            points: 9
            charge: 2
        }
        {
            name: "Fire-Control System"
            id: 113
            slot: "Sensor"
            points: 2
        }
        {
            name: "Trajectory Simulator"
            id: 114
            slot: "Sensor"
            points: 6
        }
        {
            name: "Composure"
            id: 115
            slot: "Talent"
            points: 1
            restrictions: [
                ["Action", "Focus"]
            ]
        }
        {
            name: "Crack Shot"
            id: 116
            slot: "Talent"
            points: 3
            charge: 1
        }
        {
            name: "Daredevil"
            id: 117
            slot: "Talent"
            points: 2
            restrictions: [
                ["Action", "W-Boost"]
                ["Base", "Small"]
            ]
        }
        {
            name: "Debris Gambit"
            id: 118
            slot: "Talent"
            points: 6
            restrictions: [
                ["Base", "Small", "Medium"]
            ]
            modifier_func: (stats) ->
                stats.actions.push 'R-Evade' if 'R-Evade' not in stats.actions
        }
        {
            name: "Elusive"
            id: 119
            slot: "Talent"
            points: 2
            charge: 1
            restrictions: [
                ["Base", "Small", "Medium"]
            ]
        }
        {
            name: "Expert Handling"
            id: 120
            slot: "Talent"
            points: 2
            restrictions: [
                ["Action", "R-Barrel Roll"]
            ]
            modifier_func: (stats) ->
                stats.actions.push 'Barrel Roll' if 'Barrel Roll' not in stats.actions
        }
        {
            name: "Fearless"
            id: 121
            slot: "Talent"
            points: 3
            faction: "Scum and Villainy"
        }
        {
            name: "Intimidation"
            id: 122
            slot: "Talent"
            points: 3
        }
        {
            name: "Juke"
            id: 123
            slot: "Talent"
            points: 6
            restrictions: [
                ["Base", "Small", "Medium"]
            ]
        }
        {
            name: "Lone Wolf"
            id: 124
            slot: "Talent"
            points: 5
            unique: true
            recurring: 1
            charge: 1
        }
        {
            name: "Marksmanship"
            id: 125
            slot: "Talent"
            points: 1
        }
        {
            name: "Outmaneuver"
            id: 126
            slot: "Talent"
            points: 12
        }
        {
            name: "Predator"
            id: 127
            slot: "Talent"
            points: 2
        }
        {
            name: "Ruthless"
            id: 128
            slot: "Talent"
            points: 1
            faction: "Galactic Empire"
        }
        {
            name: "Saturation Salvo"
            id: 129
            slot: "Talent"
            points: 3
            restrictions: [
                ["Action", "Reload"]
            ]
        }
        {
            name: "Selfless"
            id: 130
            slot: "Talent"
            points: 2
            faction: "Rebel Alliance"
        }
        {
            name: "Squad Leader"
            id: 131
            slot: "Talent"
            points: 6
            unique: true
            modifier_func: (stats) ->
                stats.actions.push 'R-Coordinate' if 'R-Coordinate' not in stats.actions
        }
        {
            name: "Swarm Tactics"
            id: 132
            slot: "Talent"
            points: 5
        }
        {
            name: "Trick Shot"
            id: 133
            slot: "Talent"
            points: 4
        }
        {
            name: "Adv. Proton Torpedoes"
            id: 134
            slot: "Torpedo"
            points: 8
            attack: 5
            range: """1"""
            rangebonus: true
            charge: 1
        }
        {
            name: "Ion Torpedoes"
            id: 135
            slot: "Torpedo"
            points: 4
            attack: 4
            range: """2-3"""
            rangebonus: true
            charge: 2
        }
        {
            name: "Proton Torpedoes"
            id: 136
            slot: "Torpedo"
            points: 12
            attack: 4
            range: """2-3"""
            rangebonus: true
            charge: 2
        }
        {
            name: "Dorsal Turret"
            id: 137
            slot: "Turret"
            points: 2
            attackt: 2
            range: """1-2"""
            modifier_func: (stats) ->
                stats.actions.push 'Rotate Arc' if 'Rotate Arc' not in stats.actions
        }
        {
            name: "Ion Cannon Turret"
            id: 138
            slot: "Turret"
            points: 5
            attackt: 3
            range: """1-2"""
            modifier_func: (stats) ->
                stats.actions.push 'Rotate Arc' if 'Rotate Arc' not in stats.actions
        }
        {
            name: "Os-1 Arsenal Loadout"
            id: 139
            points: 0
            slot: "Configuration"
            ship: "Alpha-Class Star Wing"
            confersAddons: [
                {
                    type: exportObj.Upgrade
                    slot: "Torpedo"
                }
                {
                    type: exportObj.Upgrade
                    slot: "Missile"
                }
            ]
        }
        {
            name: "Pivot Wing"
            id: 140
            points: 0
            slot: "Configuration"
            ship: "UT-60D U-wing"
        }
        {
            name: "Pivot Wing (Open)"
            id: 141
            points: 0
            skip: true
        }
        {
            name: "Servomotor S-Foils"
            id: 142
            points: 0
            slot: "Configuration"
            ship: "T-65 X-wing"
            modifier_func: (stats) ->
                stats.actions.push 'Boost'
                stats.actions.push '*Focus'
                stats.actions.push 'R-> Boost'
        }
        {
            name: "Blank"
            id: 143
            skip: true
        }
        {
            name: "Xg-1 Assault Configuration"
            id: 144
            points: 0
            slot: "Configuration"
            ship: "Alpha-Class Star Wing"
            confersAddons: [
                {
                    type: exportObj.Upgrade
                    slot: "Cannon"
                }
            ]
        }
        {
            name: "L3-37's Programming (BoY)"
            id: 145
            standard: true
            unique: true
            slot: "Configuration"
        }
        {
            name: "Andrasta"
            id: 146
            slot: "Title"
            points: 0
            unique: true
            faction: "Scum and Villainy"
            ship: "Firespray-class Patrol Craft"
            confersAddons: [
                {
                    type: exportObj.Upgrade
                    slot: "Device"
                }
            ]
            modifier_func: (stats) ->
                    stats.actions.push 'Reload' if 'Reload' not in stats.actions
        }
        {
            name: "Dauntless"
            id: 147
            slot: "Title"
            points: 0
            unique: true
            faction: "Galactic Empire"
            ship: "VT-49 Decimator"
        }
        {
            name: "Ghost"
            id: 148
            slot: "Title"
            unique: true
            points: 0
            faction: "Rebel Alliance"
            ship: "VCX-100 Light Freighter"
        }
        {
            name: "Havoc"
            id: 149
            slot: "Title"
            points: 0
            unique: true
            faction: "Scum and Villainy"
            ship: "Scurrg H-6 Bomber"
            unequips_upgrades: [
                'Crew'
            ]
            also_occupies_upgrades: [
                'Crew'
            ]
            confersAddons: [
                {
                    type: exportObj.Upgrade
                    slot: 'Sensor'
                }
                {
                    type: exportObj.Upgrade
                    slot: 'Astromech'
                }
            ]
        }
        {
            name: "Hound's Tooth"
            id: 150
            slot: "Title"
            points: 0
            unique: true
            faction: "Scum and Villainy"
            ship: "YV-666 Light Freighter"
        }
        {
            name: "IG-2000"
            id: 151
            slot: "Title"
            points: 0
            faction: "Scum and Villainy"
            ship: "Aggressor Assault Fighter"
        }
        {
            name: "Lando's Millennium Falcon"
            id: 152
            slot: "Title"
            points: 0
            unique: true
            faction: "Scum and Villainy"
            ship: "Customized YT-1300 Light Freighter"
        }
        {
            name: "Marauder"
            id: 153
            slot: "Title"
            points: 0
            unique: true
            faction: "Scum and Villainy"
            ship: "Firespray-class Patrol Craft"
            confersAddons: [
                {
                    type: exportObj.Upgrade
                    slot: "Gunner"
                }
            ]
        }
        {
            name: "Millennium Falcon"
            id: 154
            slot: "Title"
            points: 0
            unique: true
            faction: "Rebel Alliance"
            ship: "Modified YT-1300 Light Freighter"
            modifier_func: (stats) ->
                stats.actions.push 'Evade' if 'Evade' not in stats.actions
        }
        {
            name: "Mist Hunter"
            id: 155
            slot: "Title"
            points: 0
            unique: true
            faction: "Scum and Villainy"
            ship: "G-1A Starfighter"
            modifier_func: (stats) ->
                stats.actions.push 'Barrel Roll' if 'Barrel Roll' not in stats.actions
            confersAddons: [
                {
                    type: exportObj.Upgrade
                    slot: "Cannon"
                }
            ]
        }
        {
            name: "Moldy Crow"
            id: 156
            slot: "Title"
            points: 0
            unique: true
            faction: ["Rebel Alliance", "Scum and Villainy"]
            ship: "HWK-290 Light Freighter"
            modifier_func: (stats) ->
                stats.attack = 3
        }
        {
            name: "Outrider"
            id: 157
            slot: "Title"
            points: 0
            unique: true
            faction: "Rebel Alliance"
            ship: "YT-2400 Light Freighter"
        }
        {
            id: 158
            skip: true
        }
        {
            name: "Punishing One"
            id: 159
            slot: "Title"
            points: 0
            unique: true
            faction: "Scum and Villainy"
            ship: "JumpMaster 5000"
            unequips_upgrades: [
                'Crew'
            ]
            also_occupies_upgrades: [
                'Crew'
            ]
            confersAddons: [
                {
                    type: exportObj.Upgrade
                    slot: 'Astromech'
                }
            ]
        }
        {
            name: "Shadow Caster"
            id: 160
            slot: "Title"
            points: 0
            unique: true
            faction: "Scum and Villainy"
            ship: "Lancer-Class Pursuit Craft"
        }
        {
            name: "Slave I"
            id: 161
            slot: "Title"
            points: 0
            unique: true
            faction: "Scum and Villainy"
            ship: "Firespray-class Patrol Craft"
            confersAddons: [
                {
                    type: exportObj.Upgrade
                    slot: "Torpedo"
                }
            ]
        }
        {
            name: "ST-321"
            id: 162
            slot: "Title"
            points: 0
            unique: true
            faction: "Galactic Empire"
            ship: "Lambda-class T-4a Shuttle"
        }
        {
            name: "Virago"
            id: 163
            slot: "Title"
            points: 0
            unique: true
            charge: 2
            ship: "StarViper-class Attack Platform"
            modifier_func: (stats) ->
                stats.shields += 1
            confersAddons: [
                {
                    type: exportObj.Upgrade
                    slot: "Modification"
                }
            ]
        }
        {
            name: "Hull Upgrade"
            id: 164
            slot: "Modification"
            points: 6
            modifier_func: (stats) ->
                stats.hull += 1
        }
        {
            name: "Shield Upgrade"
            id: 165
            slot: "Modification"
            points: 8
            modifier_func: (stats) ->
                stats.shields += 1
        }
        {
            name: "Stealth Device"
            id: 166
            slot: "Modification"
            points: 8
            charge: 1
        }
        {
            name: "Phantom"
            id: 167
            slot: "Title"
            points: 0
            unique: true
            faction: "Rebel Alliance"
            ship: ["Attack Shuttle","Sheathipede-Class Shuttle"]
        }
        {
            id: 168
            skip: true
        }
        {
            id: 169
            skip: true
        }
        {
            id: 170
            skip: true
        }
        {
            name: "Black One"
            id: 171
            slot: "Title"
            unique: true
            charge: 1
            points: 0
            faction: "Resistance"
            ship: "T-70 X-wing"
            modifier_func: (stats) ->
                stats.actions.push 'Slam' if 'Slam' not in stats.actions
        }
        {
            name: "Heroic"
            id: 172
            slot: "Talent"
            points: 2
            faction: "Resistance"
        }
        {
            name: "Rose Tico"
            id: 173
            slot: "Crew"
            points: 9
            unique: true
            faction: "Resistance"
        }
        {
            name: "Finn"
            id: 174
            slot: "Gunner"
            points: 9
            unique: true
            faction: "Resistance"
        }
        {
            name: "Integrated S-Foils"
            id: 175
            slot: "Configuration"
            points: 0
            ship: "T-70 X-wing"
            modifier_func: (stats) ->
                stats.actions.push 'Barrel Roll'
                stats.actions.push '*Focus'
                stats.actions.push 'R-> Barrel Roll'
        }
        {
            name: "Integrated S-Foils (Open)"
            id: 176
            skip: true
        }
        {
            name: "Targeting Synchronizer"
            id: 177
            slot: "Tech"
            points: 3
            restrictions: [
                ["Action", "Lock"]
            ]
        }
        {
            name: "Primed Thrusters"
            id: 178
            slot: "Tech"
            points: 6
            restrictions: [
                ["Base", "Small"]
            ]
        }
        {
            name: "Kylo Ren"
            id: 179
            slot: "Crew"
            points: 9
            force: 1
            faction: "First Order"
            unique: true
            applies_condition: '''I'll Show You the Dark Side'''.canonicalize()
            modifier_func: (stats) ->
                stats.force += 1
        }
        {
            name: "General Hux"
            id: 180
            slot: "Crew"
            points: 3
            unique: true
            faction: "First Order"
            restrictions: [
                ["Action", "Coordinate"]
            ]
        }
        {
            name: "Fanatical"
            id: 181
            slot: "Talent"
            points: 1
            faction: "First Order"
        }
        {
            name: "Special Forces Gunner"
            id: 182
            slot: "Gunner"
            points: 5
            faction: "First Order"
            ship: "TIE/sf Fighter"
        }
        {
            name: "Captain Phasma"
            id: 183
            slot: "Crew"
            unique: true
            points: 5
            faction: "First Order"
        }
        {
            name: "Supreme Leader Snoke"
            id: 184
            slot: "Crew"
            unique: true
            points: 13
            force: 1
            faction: "First Order"
            restrictions: [
                ["Slot", "Crew"]
            ]
            validation_func: (ship, upgrade_obj) ->
                upgrade_obj.occupiesAnUpgradeSlot "Crew"
            also_occupies_upgrades: [ "Crew" ]
            modifier_func: (stats) ->
                stats.force += 1
        }
        {
            name: "Hyperspace Tracking Data"
            id: 185
            slot: "Tech"
            faction: "First Order"
            points: 2
            restrictions: [
                ["Base", "Large"]
            ]
        }
        {
            name: "Advanced Optics"
            id: 186
            slot: "Tech"
            points: 5
        }
        {
            name: "Rey"
            id: 187
            slot: "Gunner"
            xws: "rey-gunner"
            points: 12
            unique: true
            force: 1
            faction: "Resistance"
            modifier_func: (stats) ->
                stats.force += 1
        }
        {
            name: "Chewbacca (Resistance)"
            id: 188
            slot: "Crew"
            xws: "chewbacca-crew-swz19"
            points: 4
            charge: 2
            unique: true
            faction: "Resistance"
        }
        {
            name: "Paige Tico"
            id: 189
            slot: "Gunner"
            points: 6
            unique: true
            faction: "Resistance"
        }
        {
            name: "R2-HA"
            id: 190
            slot: "Astromech"
            points: 3
            unique: true
            faction: "Resistance"
        }
        {
            name: "C-3PO (Resistance)"
            canonical_name: 'C-3PO'.canonicalize()
            id: 191
            slot: "Crew"
            xws: "c3po-crew"
            points: 7
            unique: true
            faction: "Resistance"
            modifier_func: (stats) ->
                stats.actions.push 'Calculate' if 'Calculate' not in stats.actions
                stats.actions.push 'R-Coordinate' if 'R-Coordinate' not in stats.actions
        }
        {
            name: "Han Solo (Resistance)"
            id: 192
            slot: "Crew"
            xws: "hansolo-crew"
            points: 3
            unique: true
            faction: "Resistance"
            modifier_func: (stats) ->
                stats.actions.push 'R-Evade' if 'R-Evade' not in stats.actions
        }
        {
            name: "Rey's Millennium Falcon"
            id: 193
            slot: "Title"
            points: 0
            unique: true
            ship: "Scavenged YT-1300"
            faction: "Resistance"
        }
        {
            name: "Petty Officer Thanisson"
            id: 194
            slot: "Crew"
            points: 3
            unique: true
            faction: "First Order"
        }
        {
            name: "BB-8"
            id: 195
            slot: "Astromech"
            points: 7
            charge: 2
            unique: true
            faction: "Resistance"
        }
        {
            name: "BB Astromech"
            id: 196
            slot: "Astromech"
            points: 6
            charge: 2
            faction: "Resistance"
        }
        {
            name: "M9-G8"
            id: 197
            slot: "Astromech"
            points: 5
            unique: true
            faction: "Resistance"
        }
        {
            name: "Ferrosphere Paint"
            id: 198
            slot: "Tech"
            points: 3
            faction: "Resistance"
        }
        {
            name: "Brilliant Evasion"
            id: 199
            slot: "Force"
            points: 2
        }
        {
            name: "Calibrated Laser Targeting"
            id: 200
            slot: "Configuration"
            ship: "Delta-7 Aethersprite"
            points: 0
            restrictions: [
                ["Slot", "Modification"]
            ]
            validation_func: (ship, upgrade_obj) ->
                upgrade_obj.occupiesAnUpgradeSlot "Modification"
            also_occupies_upgrades: [ "Modification" ]
        }
        {
            name: "Delta-7B"
            id: 201
            slot: "Configuration"
            ship: "Delta-7 Aethersprite"
            points: 99
            modifier_func: (stats) ->
                stats.attack += 1
                stats.agility += -1
                stats.shields += 2
        }
        {
            name: "Biohexacrypt Codes"
            id: 202
            slot: "Tech"
            points: 1
            faction: "First Order"
            restrictions: [
                ["Action", "Lock"]
            ]
        }
        {
            name: "Predictive Shot"
            id: 203
            slot: "Force"
            points: 1
        }
        {
            name: "Hate"
            id: 204
            slot: "Force"
            points: 4
            restrictions: [
                ["Keyword", "Dark Side"]
            ]
        }
        {
            name: "R5-X3"
            id: 205
            unique: true
            slot: "Astromech"
            faction: "Resistance"
            charge: 2
            points: 5
        }
        {
            name: "Pattern Analyzer"
            id: 206
            slot: "Tech"
            points: 5
        }
        {
            name: "Impervium Plating"
            id: 207
            ship: "Belbullab-22 Starfighter"
            charge: 2
            slot: "Modification"
            points: 0
        }
        {
            name: "Grappling Struts"
            id: 208
            ship: "Vulture-class Droid Fighter"
            slot: "Configuration"
            points: 0
        }
        {
            name: "Energy-Shell Charges"
            id: 209
            faction: "Separatist Alliance"
            slot: "Missile"
            attack: 3
            range: """2-3"""
            rangebonus: true
            charge: 1
            points: 4
            restrictions: [
                ["Action", "Calculate"]
            ]
        }
        {
            name: "Dedicated"
            id: 210
            faction: "Galactic Republic"
            slot: "Talent"
            points: 1
            restrictions: [
                ["Keyword", "Clone"]
            ]
        }
        {
            name: "Synchronized Console"
            id: 211
            faction: "Galactic Republic"
            slot: "Modification"
            points: 1
            restrictions: [
                ["Action", "Lock"]
            ]
        }
        {
            name: "Battle Meditation"
            id: 212
            faction: "Galactic Republic"
            slot: "Force"
            points: 6
            modifier_func: (stats) ->
                stats.actions.push 'F-Coordinate' if 'F-Coordinate' not in stats.actions
        }
        {
            name: "R4-P Astromech"
            id: 213
            faction: "Galactic Republic"
            slot: "Astromech"
            charge: 2
            points: 2
        }
        {
            name: "R4-P17"
            id: 214
            unique: true
            faction: "Galactic Republic"
            slot: "Astromech"
            charge: 2
            points: 4
        }
        {
            name: "Spare Parts Canisters"
            id: 215
            slot: "Modification"
            charge: 1
            points: 3
            applies_condition: '''Spare Parts'''.canonicalize()
            restrictions: [
                ["Equipped", "Astromech"]
            ]
        }
        {
            name: "Scimitar"
            id: 216
            unique: true
            ship: "Sith Infiltrator"
            slot: "Title"
            faction: "Separatist Alliance"
            points: 0
            modifier_func: (stats) ->
                stats.actions.push 'R-Cloak' if 'R-Cloak' not in stats.actions
                stats.actions.push 'Jam' if 'Jam' not in stats.actions
        }
        {
            name: "Chancellor Palpatine"
            id: 217
            unique: true
            slot: "Crew"
            faction: ["Galactic Republic", "Separatist Alliance"]
            force: 1
            points: 14
            modifier_func: (stats) ->
                stats.force += 1
                stats.actions.push 'F-Coordinate' if 'F-Coordinate' not in stats.actions
        }
        {
            name: "Count Dooku"
            id: 218
            unique: true
            slot: "Crew"
            force: 1
            faction: "Separatist Alliance"
            points: 14
            modifier_func: (stats) ->
                stats.force += 1
        }
        {
            name: "General Grievous"
            id: 219
            unique: true
            slot: "Crew"
            charge: 1
            faction: "Separatist Alliance"
            points: 4
        }
        {
            name: "K2-B4"
            id: 220
            unique: true
            solitary: true
            slot: "Tactical Relay"
            faction: "Separatist Alliance"
            points: 6
        }
        {
            name: "DRK-1 Probe Droids"
            id: 221
            slot: "Device"
            unique: true
            faction: "Separatist Alliance"
            charge: 2
            points: 5
            applies_condition: '''DRK-1 Probe Droid'''.canonicalize()
        }
        {
            name: "Kraken"
            id: 222
            unique: true
            slot: "Tactical Relay"
            solitary: true
            faction: "Separatist Alliance"
            points: 10
            modifier_func: (stats) ->
                stats.actions.push 'Calculate' if 'Calculate' not in stats.actions
        }
        {
            name: "TV-94"
            id: 223
            unique: true
            solitary: true
            slot: "Tactical Relay"
            faction: "Separatist Alliance"
            points: 5
        }
        {
            name: "Discord Missiles"
            id: 224
            slot: "Missile"
            faction: "Separatist Alliance"
            charge: 1
            max_per_squad: 3
            points: 3
            applies_condition: '''Buzz Droid Swarm'''.canonicalize()
        }
        {
            name: "Clone Commander Cody"
            id: 225
            unique: true
            slot: "Gunner"
            faction: "Galactic Republic"
            points: 4
        }
        {
            name: "R4-P44"
            id: 226
            unique: true
            faction: "Galactic Republic"
            slot: "Astromech"
            points: 2
        }
        {
            name: "Seventh Fleet Gunner"
            id: 227
            charge: 1
            slot: "Gunner"
            faction: "Galactic Republic"
            points: 8
        }
        {
            name: "Treacherous"
            id: 228
            charge: 1
            slot: "Talent"
            faction: "Separatist Alliance"
            points: 2
        }
        {
            name: "Soulless One"
            id: 229
            slot: "Title"
            unique: true
            ship: "Belbullab-22 Starfighter"
            faction: "Separatist Alliance"
            points: 0
            modifier_func: (stats) ->
                stats.hull += 2
        }
        {
            name: "GA-97"
            id: 230
            slot: "Crew"
            points: 5
            charge: 5
            recurring: 1
            faction: "Resistance"
            unique: true
            applies_condition: '''It's The Resistance'''.canonicalize()
            modifier_func: (stats) ->
                stats.actions.push 'Calculate' if 'Calculate' not in stats.actions
        }
        {
            name: "Kaydel Connix"
            id: 231
            slot: "Crew"
            points: 5
            faction: "Resistance"
            unique: true
        }
        {
            name: "Autoblasters"
            id: 232
            slot: "Cannon"
            points: 7
            attack: 2
            range: """1-2"""
        }
        {
            name: "R2-C4"
            id: 233
            unique: true
            slot: "Astromech"
            points: 3
            faction: "Galactic Republic"
        }
        {
            name: "Plasma Torpedoes"
            id: 234
            slot: "Torpedo"
            points: 7
            attack: 3
            range: """2-3"""
            rangebonus: true
            charge: 2
        }
        {
            name: "Electro-Proton Bomb"
            id: 235
            unique: true
            slot: "Device"
            points: 8
            charge: 1
            restrictions: [
                ["Action", "Reload"]
                ["Slot", "Modification"]
            ]
            validation_func: (ship, upgrade_obj) ->
                upgrade_obj.occupiesAnUpgradeSlot "Modification"
            also_occupies_upgrades: [ "Modification" ]
            applies_condition: 'Electro-Proton Bomb'.canonicalize()
        }
        {
            name: "Delayed Fuses"
            id: 236
            slot: "Modification"
            points: 1
        }
        {
            name: "Landing Struts"
            id: 237
            ship: "Hyena-class Droid Bomber"
            slot: "Configuration"
            points: 0
        }
        {
            name: "Diamond-Boron Missiles"
            id: 238
            unique: true
            slot: "Missile"
            points: 5
            attack: 3
            range: """2-3"""
            rangebonus: true
            charge: 3
            restrictions: [
                ["Slot", "Missile"]
            ]
            validation_func: (ship, upgrade_obj) ->
                upgrade_obj.occupiesAnUpgradeSlot "Missile"
            also_occupies_upgrades: [ "Missile" ]
        }
        {
            name: "TA-175"
            id: 239
            unique: true
            slot: "Tactical Relay"
            solitary: true
            faction: "Separatist Alliance"
            points: 8
        }
        {
            name: "Passive Sensors"
            id: 240
            slot: "Sensor"
            charge: 1
            recurring: 1
            points: 5
        }
        {
            name: "R2-A6"
            id: 241
            unique: true
            slot: "Astromech"
            faction: "Galactic Republic"
            points: 6
        }
        {
            name: "Amilyn Holdo"
            id: 242
            unique: true
            slot: "Crew"
            faction: "Resistance"
            points: 8
        }
        {
            name: "Larma D'Acy"
            id: 243
            unique: true
            slot: "Crew"
            faction: "Resistance"
            points: 4
        }
        {
            name: "Leia Organa (Resistance)"
            id: 244
            xws: "leiaorgana-resistance"
            unique: true
            slot: "Crew"
            faction: "Resistance"
            force: 1
            points: 16
            restrictions: [
                ["Slot", "Crew"]
            ]
            validation_func: (ship, upgrade_obj) ->
                upgrade_obj.occupiesAnUpgradeSlot "Crew"
            also_occupies_upgrades: [ "Crew" ]
            modifier_func: (stats) ->
                stats.force += 1
                stats.actions.push 'F-Coordinate' if 'F-Coordinate' not in stats.actions
        }
        {
            name: "Korr Sella"
            id: 245
            unique: true
            slot: "Crew"
            faction: "Resistance"
            points: 6
        }
        {
            name: "PZ-4CO"
            id: 246
            unique: true
            slot: "Crew"
            faction: "Resistance"
            points: 5
            modifier_func: (stats) ->
                stats.actions.push 'Calculate' if 'Calculate' not in stats.actions
        }
        {
            name: "Angled Deflectors"
            id: 247
            slot: "Modification"
            points: 4
            restrictions: [
                ["ShieldsGreaterThan", 0]
                ["Base", "Small", "Medium"]
            ]
            modifier_func: (stats) ->
                stats.shields -= 1
                stats.actions.push 'Reinforce' if 'Reinforce' not in stats.actions
        }
        {
            name: "Ensnare"
            id: 248
            slot: "Talent"
            points: 10
            ship: "Nantex-Class Starfighter"
        }
        {
            name: "Targeting Computer"
            id: 249
            slot: "Modification"
            points: 1
            modifier_func: (stats) ->
                stats.actions.push 'Lock' if 'Lock' not in stats.actions
        }
        {
            name: "Precognitive Reflexes"
            id: 250
            slot: "Force"
            points: 15
            restrictions: [
                ["Base", "Small"]
            ]
        }
        {
            name: "Foresight"
            slot: "Force"
            points: 6
            id: 251
            attackbull: 2
            range: """1-3"""
            rangebonus: true
        }
        {
            name: "C1-10P"
            id: 252
            unique: true
            slot: "Astromech"
            charge: 2
            points: 8
            faction: "Galactic Republic"
        }
        {
            name: "Ahsoka Tano"
            id: 253
            unique: true
            slot: "Gunner"
            points: 12
            faction: "Galactic Republic"
            force: 1
            modifier_func: (stats) ->
                stats.force += 1
        }
        {
            name: "C-3PO (Republic)"
            canonical_name: 'C-3PO'.canonicalize()
            id: 254
            unique: true
            slot: "Crew"
            xws: "c3po-republic"
            points: 6
            faction: "Galactic Republic"
            modifier_func: (stats) ->
                stats.actions.push 'Calculate' if 'Calculate' not in stats.actions
        }
        {
            name: "Gravitic Deflection"
            id: 255
            slot: "Talent"
            points: 4
            ship: "Nantex-Class Starfighter"
        }
        {
            name: "Snap Shot"
            id: 256
            slot: "Talent"
            points: 9
            attack: 2
            range: """2"""
            rangebonus: true
        }
        {
            name: "Agent of the Empire"
            id: 257
            unique: true
            faction: "Galactic Empire"
            slot: "Command"
            points: 4
            ship: ["TIE Advanced x1","TIE Advanced v1"]
            restrictions: [
                ["Base", "Small"]
            ]
        }
        {
            name: "First Order Elite"
            id: 258
            unique: true
            faction: "First Order"
            slot: "Command"
            ship: ["TIE/sf Fighter","TIE/vn Silencer"]
            points: 4
            restrictions: [
                ["Base", "Small"]
            ]
        }
        {
            name: "Veteran Wing Leader"
            id: 259
            slot: "Command"
            points: 2
            restrictions: [
                ["Base", "Small"]
            ]
        }
        {
            name: "Dreadnought Hunter"
            id: 260
            slot: "Command"
            points: 3
            max_per_squad: 2
            restrictions: [
                ["Base", "Small"]
                ["InitiativeGreaterThan", 3]
            ]
        }
        {
            name: "Admiral Ozzel"
            id: 261
            unique: true
            slot: "Command"
            points: 6
            faction: "Galactic Empire"
            restrictions: [
                ["Slot", "Crew"]
                ["Base", "Huge"]
            ]
            validation_func: (ship, upgrade_obj) ->
                upgrade_obj.occupiesAnUpgradeSlot "Crew"
            also_occupies_upgrades: [ "Crew" ]
        }
        {
            name: "Azmorigan"
            id: 262
            unique: true
            slot: "Command"
            points: 4
            faction: "Scum and Villainy"
            restrictions: [
                ["Slot", "Crew"]
                ["Base", "Huge"]
            ]
            validation_func: (ship, upgrade_obj) ->
                upgrade_obj.occupiesAnUpgradeSlot "Crew"
            also_occupies_upgrades: [ "Crew" ]
        }
        {
            name: "Captain Needa"
            id: 263
            unique: true
            faction: "Galactic Empire"
            slot: "Command"
            points: 8
            charge: 4
            restrictions: [
                ["Slot", "Crew"]
                ["Base", "Huge"]
            ]
            validation_func: (ship, upgrade_obj) ->
                upgrade_obj.occupiesAnUpgradeSlot "Crew"
            also_occupies_upgrades: [ "Crew" ]
        }
        {
            name: "Carlist Rieekan"
            id: 264
            unique: true
            faction: "Rebel Alliance"
            slot: "Command"
            points: 4
            restrictions: [
                ["Slot", "Crew"]
                ["Base", "Huge"]
            ]
            validation_func: (ship, upgrade_obj) ->
                upgrade_obj.occupiesAnUpgradeSlot "Crew"
            also_occupies_upgrades: [ "Crew" ]
        }
        {
            name: "Jan Dodonna"
            id: 265
            unique: true
            faction: "Rebel Alliance"
            slot: "Command"
            points: 3
            restrictions: [
                ["Slot", "Crew"]
                ["Base", "Huge"]
            ]
            validation_func: (ship, upgrade_obj) ->
                upgrade_obj.occupiesAnUpgradeSlot "Crew"
            also_occupies_upgrades: [ "Crew" ]
        }
        {
            name: "Raymus Antilles"
            id: 266
            unique: true
            slot: "Command"
            points: 8
            faction: "Rebel Alliance"
            restrictions: [
                ["Slot", "Crew"]
                ["Base", "Huge"]
            ]
            validation_func: (ship, upgrade_obj) ->
                upgrade_obj.occupiesAnUpgradeSlot "Crew"
            also_occupies_upgrades: [ "Crew" ]
        }
        {
            name: "Stalwart Captain"
            id: 267
            unique: true
            slot: "Command"
            points: 6
            restrictions: [
                ["Slot", "Crew"]
                ["Base", "Huge"]
            ]
            validation_func: (ship, upgrade_obj) ->
                upgrade_obj.occupiesAnUpgradeSlot "Crew"
            also_occupies_upgrades: [ "Crew" ]
        }
        {
            name: "Strategic Commander"
            id: 268
            unique: true
            slot: "Command"
            charge: 3
            points: 6
            restrictions: [
                ["Slot", "Crew"]
                ["Base", "Huge"]
            ]
            validation_func: (ship, upgrade_obj) ->
                upgrade_obj.occupiesAnUpgradeSlot "Crew"
            also_occupies_upgrades: [ "Crew" ]
        }
        {
            name: "Ion Cannon Battery"
            id: 269
            slot: "Hardpoint"
            points: 5
            attackt: 4
            range: """2-4"""
            modifier_func: (stats) ->
                stats.actions.push 'Rotate Arc' if 'Rotate Arc' not in stats.actions
        }
        {
            name: "Targeting Battery"
            id: 270
            slot: "Hardpoint"
            points: 5
            attackt: 3
            range: """2-5"""
            modifier_func: (stats) ->
                stats.actions.push 'Rotate Arc' if 'Rotate Arc' not in stats.actions
        }
        {
            name: "Ordnance Tubes"
            id: 271
            slot: "Hardpoint"
            points: 1
        }
        {
            name: "Point-Defense Battery"
            id: 272
            slot: "Hardpoint"
            points: 9
            attackdt: 2
            range: """1-2"""
            modifier_func: (stats) ->
                stats.actions.push 'Rotate Arc' if 'Rotate Arc' not in stats.actions
        }
        {
            name: "Turbolaser Battery"
            id: 273
            slot: "Hardpoint"
            points: 10
            attackt: 3
            range: """3-5"""
            restrictions: [
                ["EnergyGreatterThan", 4]
            ]
            modifier_func: (stats) ->
                stats.actions.push 'Rotate Arc' if 'Rotate Arc' not in stats.actions
        }
        {
            name: "Toryn Farr"
            id: 274
            unique: true
            faction: "Rebel Alliance"
            slot: "Crew"
            points: 4
            restrictions: [
                ["Base", "Huge"]
            ]
            modifier_func: (stats) ->
                stats.actions.push '*Lock'
                stats.actions.push 'R-> Coordinate'
        }
        {
            name: "Bombardment Specialists"
            id: 275
            slot: "Team"
            points: 6
            modifier_func: (stats) ->
                stats.actions.push '*Lock'
                stats.actions.push '> Calculate'
        }
        {
            name: "Comms Team"
            id: 276
            slot: "Team"
            points: 7
            modifier_func: (stats) ->
                stats.actions.push '*Coordinate'
                stats.actions.push '> Calculate'
                stats.actions.push '*Jam'
                stats.actions.push '> Calculate'
        }
        {
            name: "Damage Control Team"
            id: 277
            slot: "Team"
            points: 3
            modifier_func: (stats) ->
                stats.actions.push '*Reinforce'
                stats.actions.push '> Calculate'
        }
        {
            name: "Gunnery Specialists"
            id: 278
            slot: "Team"
            points: 5
            modifier_func: (stats) ->
                stats.actions.push '*Rotate Arc'
                stats.actions.push '> Calculate'
        }
        {
            name: "IG-RM Droids"
            id: 279
            slot: "Team"
            faction: "Scum and Villainy"
            points: 2
            modifier_func: (stats) ->
                stats.actions.push 'Calculate' if 'Calculate' not in stats.actions
        }
        {
            name: "Ordnance Team"
            id: 280
            slot: "Team"
            points: 2
            modifier_func: (stats) ->
                stats.actions.push '*Reload'
                stats.actions.push '> Calculate'
        }
        {
            name: "Sensor Experts"
            id: 281
            slot: "Team"
            points: 6
            modifier_func: (stats) ->
                stats.actions.push '*Lock'
                stats.actions.push '> Calculate'
        }
        {
            name: "Adaptive Shields"
            id: 282
            slot: "Cargo"
            points: 5
        }
        {
            name: "Boosted Scanners"
            id: 283
            slot: "Cargo"
            points: 7
        }
        {
            id: 284
            skip: true
        }
        {
            name: "Tibanna Reserves"
            id: 285
            slot: "Cargo"
            points: 3
            charge: 3
        }
        {
            name: "Optimized Power Core"
            id: 286
            slot: "Cargo"
            points: 6
        }
        {
            name: "Quick-Release Locks"
            id: 287
            slot: "Illicit"
            charge: 2
            points: 5
            restrictions: [
                ["Base", "Huge"]
            ]
        }
        {
            name: "Saboteur's Map"
            id: 288
            slot: "Illicit"
            points: 3
            unique: true
            restrictions: [
                ["Base", "Huge"]
            ]
        }
        {
            name: "Scanner Baffler"
            id: 289
            slot: "Illicit"
            points: 8
            restrictions: [
                ["Base", "Huge"]
            ]
        }
        {
            name: "Dodonna's Pride"
            id: 290
            slot: "Title"
            unique: true
            ship: "CR90 Corellian Corvette"
            faction: "Rebel Alliance"
            points: 4
            modifier_func: (stats) ->
                stats.shields -= 2
                stats.actions.push '*Evade'
                stats.actions.push 'R-> Coordinate'
                stats.actions.push '*Focus'
                stats.actions.push 'R-> Coordinate'
            confersAddons: [
                {
                    type: exportObj.Upgrade
                    slot: 'Team'
                }
                {
                    type: exportObj.Upgrade
                    slot: 'Cargo'
                }
            ]
        }
        {
            name: "Jaina's Light"
            id: 291
            slot: "Title"
            unique: true
            ship: "CR90 Corellian Corvette"
            faction: "Rebel Alliance"
            points: 4
            modifier_func: (stats) ->
                stats.shields += 1
                stats.energy -= 1
        }
        {
            name: "Liberator"
            id: 292
            slot: "Title"
            unique: true
            ship: "CR90 Corellian Corvette"
            faction: "Rebel Alliance"
            points: 5
            modifier_func: (stats) ->
                stats.energy += 1
        }
        {
            name: "Tantive IV"
            id: 293
            slot: "Title"
            unique: true
            ship: "CR90 Corellian Corvette"
            faction: "Rebel Alliance"
            points: 5
            confersAddons: [
                {
                    type: exportObj.Upgrade
                    slot: 'Crew'
                }
                {
                    type: exportObj.Upgrade
                    slot: 'Crew'
                }
            ]
        }
        {
            name: "Bright Hope"
            id: 294
            slot: "Title"
            unique: true
            ship: "GR-75 Medium Transport"
            faction: "Rebel Alliance"
            points: 5
        }
        {
            name: "Luminous"
            id: 295
            slot: "Title"
            unique: true
            ship: "GR-75 Medium Transport"
            faction: "Rebel Alliance"
            points: 12
            modifier_func: (stats) ->
                stats.shields -= 1
                stats.energy += 2
        }
        {
            name: "Quantum Storm"
            id: 296
            slot: "Title"
            unique: true
            ship: "GR-75 Medium Transport"
            faction: "Rebel Alliance"
            points: 3
            modifier_func: (stats) ->
                stats.energy += 1
            confersAddons: [
                {
                    type: exportObj.Upgrade
                    slot: 'Team'
                }
                {
                    type: exportObj.Upgrade
                    slot: 'Cargo'
                }
            ]
        }
        {
            name: "Assailer"
            id: 297
            slot: "Title"
            unique: true
            ship: "Raider-class Corvette"
            faction: "Galactic Empire"
            points: 5
            modifier_func: (stats) ->
                stats.shields -= 2
                stats.hull += 2
            confersAddons: [
                {
                    type: exportObj.Upgrade
                    slot: 'Gunner'
                }
            ]
        }
        {
            name: "Corvus"
            id: 298
            slot: "Title"
            unique: true
            ship: "Raider-class Corvette"
            faction: "Galactic Empire"
            points: 3
        }
        {
            name: "Impetuous"
            id: 299
            slot: "Title"
            unique: true
            ship: "Raider-class Corvette"
            faction: "Galactic Empire"
            points: 4
            modifier_func: (stats) ->
                stats.shields -= 2
                stats.energy += 2
            confersAddons: [
                {
                    type: exportObj.Upgrade
                    slot: 'Crew'
                }
            ]
        }
        {
            name: "Instigator"
            id: 300
            slot: "Title"
            unique: true
            ship: "Raider-class Corvette"
            faction: "Galactic Empire"
            points: 6
            confersAddons: [
                {
                    type: exportObj.Upgrade
                    slot: 'Team'
                }
            ]
        }
        {
            name: "Blood Crow"
            id: 301
            slot: "Title"
            unique: true
            ship: "Gozanti-class Cruiser"
            faction: "Galactic Empire"
            points: 8
            modifier_func: (stats) ->
                stats.shields -= 1
                stats.energy += 2
            confersAddons: [
                {
                    type: exportObj.Upgrade
                    slot: 'Gunner'
                }
            ]
        }
        {
            name: "Requiem"
            id: 302
            slot: "Title"
            unique: true
            ship: "Gozanti-class Cruiser"
            faction: "Galactic Empire"
            points: 7
        }
        {
            name: "Suppressor"
            id: 303
            slot: "Title"
            unique: true
            ship: "Gozanti-class Cruiser"
            faction: "Galactic Empire"
            points: 6
            modifier_func: (stats) ->
                stats.shields += 2
                stats.hull -= 2
            confersAddons: [
                {
                    type: exportObj.Upgrade
                    slot: 'Sensor'
                }
            ]
        }
        {
            name: "Vector"
            id: 304
            slot: "Title"
            unique: true
            ship: "Gozanti-class Cruiser"
            faction: "Galactic Empire"
            points: 7
            confersAddons: [
                {
                    type: exportObj.Upgrade
                    slot: 'Crew'
                }
                {
                    type: exportObj.Upgrade
                    slot: 'Cargo'
                }
            ]
        }
        {
            name: "Broken Horn"
            id: 305
            slot: "Title"
            unique: true
            ship: "C-ROC Cruiser"
            faction: "Scum and Villainy"
            points: 4
            confersAddons: [
                {
                    type: exportObj.Upgrade
                    slot: 'Crew'
                }
                {
                    type: exportObj.Upgrade
                    slot: 'Illicit'
                }
            ]
        }
        {
            name: "Merchant One"
            id: 306
            slot: "Title"
            unique: true
            ship: "C-ROC Cruiser"
            faction: "Scum and Villainy"
            points: 8
            modifier_func: (stats) ->
                stats.actions.push 'R-Evade' if 'R-Evade' not in stats.actions
                stats.actions.push 'Coordinate' if 'Coordinate' not in stats.actions
            confersAddons: [
                {
                    type: exportObj.Upgrade
                    slot: 'Turret'
                }
                {
                    type: exportObj.Upgrade
                    slot: 'Team'
                }
                {
                    type: exportObj.Upgrade
                    slot: 'Cargo'
                }
            ]
        }
        {
            name: "Insatiable Worrt"
            id: 307
            slot: "Title"
            unique: true
            ship: "C-ROC Cruiser"
            faction: "Scum and Villainy"
            points: 7
            modifier_func: (stats) ->
                stats.hull += 3
                stats.shields -= 1
                stats.energy -= 1
            confersAddons: [
                {
                    type: exportObj.Upgrade
                    slot: 'Cargo'
                }
            ]
        }
        {
            name: "Corsair Refit"
            id: 308
            slot: "Configuration"
            ship: "C-ROC Cruiser"
            max_per_squad: 2
            points: 6
            modifier_func: (stats) ->
                stats.hull += 2
                stats.shields -= 2
                stats.energy += 1
            confersAddons: [
                {
                    type: exportObj.Upgrade
                    slot: 'Cannon'
                }
                {
                    type: exportObj.Upgrade
                    slot: 'Turret'
                }
                {
                    type: exportObj.Upgrade
                    slot: 'Missile'
                }
            ]
        }
        {
            name: "Thunderstrike"
            id: 309
            slot: "Title"
            unique: true
            ship: "CR90 Corellian Corvette"
            faction: "Rebel Alliance"
            points: 4
            modifier_func: (stats) ->
                stats.hull += 3
                stats.shields -= 3
            confersAddons: [
                {
                    type: exportObj.Upgrade
                    slot: 'Gunner'
                }
            ]
        }
        {
            name: "Coaxium Hyperfuel"
            id: 310
            slot: "Illicit"
            points: 4
            restrictions: [
                ["Action", "Slam"]
            ]
        }
        {
            name: "Mag-Pulse Warheads"
            id: 311
            slot: "Missile"
            points: 4
            attack: 3
            range: """1-3"""
            rangebonus: true
            charge: 2
        }
        {
            name: "R1-J5"
            id: 312
            slot: "Astromech"
            faction: "Resistance"
            unique: true
            points: 5
            charge: 3
        }
        {
            name: "Stabilized S-Foils"
            id: 313
            slot: "Configuration"
            ship: "A/SF-01 B-wing"
            points: 0
            modifier_func: (stats) ->
                stats.actions.push '*Barrel Roll'
                stats.actions.push 'R-> Evade'
                stats.actions.push '*Barrel Roll'
                stats.actions.push 'R-> Lock'
                stats.actions.push 'R-Reload'
        }
        {
            name: "K-2SO"
            id: 314
            slot: "Crew"
            faction: "Rebel Alliance"
            unique: true
            points: 6
            modifier_func: (stats) ->
                stats.actions.push 'Calculate'
                stats.actions.push 'Jam'
        }
        {
            name: "Kaz's Fireball"
            id: 315
            slot: "Title"
            ship: "Fireball"
            faction: "Resistance"
            unique: true
            points: 0
        }
        {
            name: "Cluster Mines"
            id: 316
            slot: "Device"
            charge: 1
            points: 7
            applies_condition: 'Cluster Mine'.canonicalize()
        }
        {
            name: "Ion Bombs"
            id: 317
            slot: "Device"
            points: 4
            charge: 2
            applies_condition: 'Ion Bomb'.canonicalize()
        }
        {
            name: "Deuterium Power Cells"
            id: 318
            slot: "Tech"
            points: 8
            charge: 2
            faction: "First Order"
            restrictions: [
                ["Slot", "Modification"]
            ]
            validation_func: (ship, upgrade_obj) ->
                upgrade_obj.occupiesAnUpgradeSlot "Modification"
            also_occupies_upgrades: [ "Modification" ]
        }
        {
            name: "Proud Tradition"
            id: 319
            slot: "Talent"
            faction: "First Order"
            points: 2
        }
        {
            name: "Commander Pyre"
            id: 320
            slot: "Crew"
            unique: true
            faction: "First Order"
            points: 5
        }
        {
            name: "Clone Captain Rex"
            id: 321
            slot: "Gunner"
            unique: true
            faction: "Galactic Republic"
            points: 2
        }
        {
            name: "Yoda"
            id: 322
            slot: "Crew"
            unique: true
            force: 2
            faction: "Galactic Republic"
            points: 12
            modifier_func: (stats) ->
                stats.force += 2
                stats.actions.push 'F-Coordinate' if 'F-Coordinate' not in stats.actions
        }
        {
            name: "Repulsorlift Stabilizers"
            id: 323
            slot: "Configuration"
            ship: "HMP Droid Gunship"
            faction: "Separatist Alliance"
            points: 0
        }
        {
            name: "Agent Terex"
            id: 324
            slot: "Crew"
            unique: true
            faction: "First Order"
            points: 7
        }
        {
            name: "Plo Koon"
            id: 325
            slot: "Crew"
            unique: true
            force: 1
            faction: "Galactic Republic"
            points: 9
            modifier_func: (stats) ->
                stats.force += 1
                stats.actions.push 'F-Reinforce' if 'F-Reinforce' not in stats.actions
        }
        {
            name: "Multi-Missile Pods"
            id: 326
            slot: "Missile"
            points: 4
            attackf: 2
            range: """1-2"""
            rangebonus: true
            charge: 5
            restrictions: [
                ["Slot", "Missile"]
            ]
            validation_func: (ship, upgrade_obj) ->
                upgrade_obj.occupiesAnUpgradeSlot "Missile"
            also_occupies_upgrades: [ "Missile" ]
        }
        {
            name: "Kit Fisto"
            id: 327
            slot: "Crew"
            unique: true
            force: 1
            faction: "Galactic Republic"
            points: 8
            modifier_func: (stats) ->
                stats.force += 1
                stats.actions.push 'F-Evade' if 'F-Evade' not in stats.actions
        }
        {
            name: "Aayla Secura"
            id: 328
            slot: "Crew"
            unique: true
            force: 1
            faction: "Galactic Republic"
            points: 14
            modifier_func: (stats) ->
                stats.force += 1
                stats.actions.push '*Focus'
                stats.actions.push '> F-Coordinate'
        }
        {
            name: "Maneuver-Assist MGK-300"
            id: 329
            slot: "Configuration"
            ship: "TIE/rb Heavy"
            faction: "Galactic Empire"
            points: 0
            modifier_func: (stats) ->
                stats.actions.push 'Calculate'
                stats.actions.push '*Barrel Roll'
                stats.actions.push '*R-> Calculate'
                if stats.maneuvers[3]?
                    for turn in [1 ... 4]
                        if stats.maneuvers[3][turn] > 1
                            stats.maneuvers[3][turn]--
        }
        {
            name: "Ion Limiter Override"
            id: 330
            slot: "Talent"
            points: 2
            restrictions: [
                ["Keyword", "TIE"]
            ]
        }
        {
            name: "Marg Sabl Closure"
            id: 331
            slot: "Talent"
            points: 1
            restrictions: [
                ["Base", "Small", "Medium"]
            ]
        }
        {
            name: "XX-23 S-Thread Tracers"
            id: 332
            slot: "Missile"
            attack: 3
            range: """1-3"""
            rangebonus: true
            max_per_squad: 2
            charge: 2
            points: 4
        }
        {
            name: "Hondo Ohnaka"
            id: 333
            unique: true
            slot: "Crew"
            points: 5
        }
        {
            name: "Boba Fett (Separatist)"
            canonical_name: 'Boba Fett'.canonicalize()
            xws: 'bobafett-gunner'
            id: 334
            slot: "Gunner"
            unique: true
            points: 2
            faction: ["Scum and Villainy", "Separatist Alliance"]
        }
        {
            name: "Jango Fett"
            id: 335
            slot: "Crew"
            unique: true
            faction: ["Scum and Villainy", "Separatist Alliance"]
            points: 3
        }
        {
            name: "Zam Wesell"
            id: 336
            slot: "Crew"
            unique: true
            charge: 2
            faction: ["Scum and Villainy", "Separatist Alliance"]
            points: 11
            applies_condition: ['''You'd Better Mean Business'''.canonicalize(),'You Should Thank Me'.canonicalize()]
        }
        {
            name: 'Alpha-3B "Besh"'
            id: 337
            slot: "Configuration"
            ship: "Nimbus-class V-wing"
            points: 0
            confersAddons: [
                {
                    type: exportObj.Upgrade
                    slot: 'Device'
                }
        ]
        }
        {
            name: "Precision Ion Engines"
            id: 338
            slot: "Modification"
            points: 2
            charge: 2
            restrictions: [
                ["Keyword", "TIE"]
                ["AgilityEquals", 3]
            ]
        }
        {
            name: "Thermal Detonators"
            id: 339
            slot: "Device"
            charge: 4
            points: 5
            applies_condition: 'Thermal Detonator'.canonicalize()
        }
        {
            name: "R2-D2 (Republic)"
            canonical_name: 'R2-D2'.canonicalize()
            id: 340
            points: 8
            charge: 2
            unique: true
            xws: "r2d2-republic"
            faction: "Galactic Republic"
            slot: "Astromech"
        }
        {
            name: "Extreme Maneuvers"
            id: 341
            points: 5
            slot: "Force"
            restrictions: [
                ["Action", "Boost"]
                ["Base", "Small"]
            ]
        }
        {
            name: "Patience"
            id: 342
            slot: "Force"
            points: 2
            restrictions: [
                ["Keyword", "Light Side"]
            ]
        }
        {
            name: "Deadeye Shot"
            id: 343
            slot: "Talent"
            points: 1
            restrictions: [
                ["Base", "Small", "Medium"]
            ]
        }
        {
            name: "Starbird Slash"
            id: 344
            slot: "Talent"
            points: 1
            restrictions: [
                ["Keyword", "A-wing"]
            ]
        }
        {
            name: "Overdrive Thruster"
            id: 345
            ship: "T-70 X-wing"
            unique: true
            slot: "Modification"
            points: 5
        }
        {
            name: '"Fives"'
            id: 346
            unique: true
            faction: "Galactic Republic"
            slot: "Crew"
            points: 3
        }
        {
            name: "Commander Malarus"
            id: 347
            unique: true
            faction: "First Order"
            slot: "Crew"
            points: 2
        }
        {
            name: "Automated Target Priority"
            id: 348
            slot: "Tech"
            points: 1
            restrictions: [
                ["InitiativeLessThan", 4]
            ]
        }
        {
            name: "Sensor Buoy Suite"
            id: 349
            faction: "First Order"
            unique: true
            slot: "Tech"
            points: 4
            restrictions: [
                ["Base", "Medium", "Large"]
            ]
            applies_condition: 'Sensor Buoy'.canonicalize()
        }
        {
            name: "Suppressive Gunner"
            id: 350
            slot: "Gunner"
            points: 7
        }
        {
            name: "Ghost Company"
            id: 351
            faction: "Galactic Republic"
            unique: true
            slot: "Crew"
            points: 5
            restrictions: [
                ["Action", "Rotate Arc"]
                ["Slot", "Gunner"]
            ]
            validation_func: (ship, upgrade_obj) ->
                upgrade_obj.occupiesAnUpgradeSlot "Gunner"
            also_occupies_upgrades: [ "Gunner" ]
            modifier_func: (stats) ->
                stats.actions.push '*Rotate Arc'
                stats.actions.push 'R-> Focus'
        }
        {
            name: "Wolfpack"
            id: 352
            faction: "Galactic Republic"
            unique: true
            slot: "Crew"
            points: 4
            restrictions: [
                ["Slot", "Gunner"]
            ]
            validation_func: (ship, upgrade_obj) ->
                upgrade_obj.occupiesAnUpgradeSlot "Gunner"
            also_occupies_upgrades: [ "Gunner" ]
        }
        {
            name: "Kalani"
            id: 353
            charge: 3
            unique: true
            recurring: 1
            slot: "Tactical Relay"
            solitary: true
            faction: "Separatist Alliance"
            points: 5
            modifier_func: (stats) ->
                stats.actions.push 'Calculate' if 'Calculate' not in stats.actions
        }
        {
            name: "Synced Laser Cannons"
            id: 354
            slot: "Cannon"
            points: 8
            attack: 3
            range: """2-3"""
            restrictions: [
                ["Slot", "Cannon"]
            ]
            validation_func: (ship, upgrade_obj) ->
                upgrade_obj.occupiesAnUpgradeSlot "Cannon"
            also_occupies_upgrades: [ "Cannon" ]
        }
        {
            name: "Concussion Bombs"
            id: 355
            slot: "Device"
            charge: 3
            points: 4
            applies_condition: 'Concussion Bomb'.canonicalize()
        }
        {
            name: "Target-Assist MGK-300"
            id: 356
            slot: "Configuration"
            ship: "TIE/rb Heavy"
            faction: "Galactic Empire"
            points: 0
            modifier_func: (stats) ->
                stats.actions.push 'Calculate'
                stats.actions.push '*Rotate Arc'
                stats.actions.push '> Calculate'
        }
        {
            name: "Backwards Tailslide"
            id: 357
            slot: "Talent"
            points: 2
            restrictions: [
                ["Keyword", "X-wing"]
                ["Equipped", "Configuration"]
            ]
        }
        {
            name: "R2-D2 (Resistance)"
            canonical_name: 'R2-D2'.canonicalize()
            id: 358
            slot: "Astromech"
            xws: "r2d2-resistance"
            points: 6
            unique: true
            charge: 4
            faction: "Resistance"
        }
        {
            name: "R6-D8"
            id: 359
            points: 4
            unique: true
            slot: "Astromech"
            faction: "Resistance"
        }
        {
            name: "Underslung Blaster Cannon"
            id: 360
            points: 2
            slot: "Cannon"
            attackt: 2
            range: """1"""
            rangebonus: true
            faction: "Resistance"
            restrictions: [
                ["Keyword", "X-wing"]
            ]
            modifier_func: (stats) ->
                stats.actions.push 'Rotate Arc' if 'Rotate Arc' not in stats.actions
        }
        {
            name: "Jedi Commander"
            id: 361
            points: 4
            ship: ["Eta-2 Actis","Delta-7 Aethersprite"]
            slot: "Command"
        }
        {
            name: "Syliure-31 Hyperdrive"
            id: 362
            points: 3
            slot: "Hyperdrive"
            ship: "Syliure-class Hyperspace Ring"
        }
        {
            name: 'Alpha-3E "Esk"'
            id: 363
            slot: "Configuration"
            ship: "Nimbus-class V-wing"
            points: 0
            charge: 2
            recurring: 1
        }
        {
            name: "R7-A7"
            id: 364
            points: 3
            unique: true
            charge: 3
            slot: "Astromech"
            faction: "Galactic Republic"
        }
        {
            name: "Q7 Astromech"
            id: 365
            points: 3
            slot: "Astromech"
            faction: "Galactic Republic"
        }
        {
            name: "Intercept Booster"
            id: 366
            points: 0
            slot: "Configuration"
            ship: "Droid Tri-fighter"
            faction: "Separatist Alliance"
            charge: 3
            recurring: -1
            modifier_func: (stats) ->
                stats.actions.push 'Slam'
                stats.actions.push 'R-> Lock'
        }
        {
            name: "Independent Calculations"
            id: 367
            points: 0
            standardized: true
            slot: "Modification"
            chassis: "Independent Calculations"
            restrictions: [
                ["Keyword", "Networked Calculations"]
            ]
        }
        {
            name: "Weapons Systems Officer"
            id: 368
            points: 5
            slot: "Gunner"
        }
        {
            name: "False Transponder Codes"
            id: 369
            points: 3
            charge: 1
            slot: "Illicit"
        }
        {
            name: "Slave I (Separatist)"
            canonical_name: 'Slave I'.canonicalize()
            xws: "slavei-swz82"
            id: 370
            points: 0
            slot: "Title"
            unique: true
            faction: ["Scum and Villainy", "Separatist Alliance"]
            ship: "Firespray-class Patrol Craft"
            confersAddons: [
                {
                    type: exportObj.Upgrade
                    slot: "Gunner"
                }
            ]
        }
        {
            name: "Vectored Cannons (RZ-1)"
            id: 371
            points: 0
            slot: "Configuration"
            standardized: true
            chassis: "Vectored Cannons"
            restrictions: [
                ["Keyword", "Vectored Thrusters"]
            ]
            modifier_func: (stats) ->
                stats.attackt = stats.attack
                stats.attack = 0 
        }
        {
            name: "B6 Blade Wing Prototype"
            id: 372
            points: 0
            unique: true
            slot: "Title"
            ship: "A/SF-01 B-wing"
            faction: "Rebel Alliance"
            confersAddons: [
                {
                    type: exportObj.Upgrade
                    slot: "Gunner"
                }
            ]
        }
        {
            name: "TIE Defender Elite"
            id: 373
            points: 0
            slot: "Configuration"
            faction: "Galactic Empire"
            ship: "TIE/d Defender"
            standardized: true
            chassis: "Advanced Fire Control"
            modifier_func: (stats) ->
                if stats.maneuvers[1]?
                    for s in (stats.maneuvers)
                        if s[0] > 1
                            s[0]--
                        if s[4] > 1
                            s[4]--
                        if s[5] < 3 and s[5] != 0
                            s[5]++
        }
        {
            name: "Sensitive Controls"
            id: 374
            points: 0
            slot: "Configuration"
            standardized: true
            chassis: "Sensitive Controls"
            restrictions: [
                ["Keyword", "Autothrusters"]
            ]
        }
        {
            name: "Cutthroat"
            id: 375
            points: 2
            slot: "Talent"
            faction: "Scum and Villainy"
        }
        {
            name: "Tierfon Belly Run"
            id: 376
            points: 0
            slot: "Talent"
            restrictions: [
                ["Keyword", "Y-wing"]
            ]
        }
        {
            name: "B6 Blade Wing Prototype (Epic)"
            canonical_name: 'B6 Blade Wing Prototype'.canonicalize()
            xws: "b6bladewingprototype-command"
            id: 377
            points: 4
            unique: true
            slot: "Command"
            ship: "A/SF-01 B-wing"
            faction: "Rebel Alliance"
            attack: 3
            range: """2-4"""
            confersAddons: [
                {
                    type: exportObj.Upgrade
                    slot: "Gunner"
                }
            ]
            validation_func: (ship, upgrade_obj) ->
                upgrade_obj.occupiesAnUpgradeSlot "Title"
            also_occupies_upgrades: [ "Title" ]
        }
        {
            name: "Hopeful"
            id: 378
            points: 1
            slot: "Talent"
            faction: "Rebel Alliance"
        }
        {
            name: "Sabine Wren (Gunner)"
            canonical_name: 'Sabine Wren'.canonicalize()
            xws: "sabinewren-gunner"
            id: 379
            points: 2
            unique: true
            slot: "Gunner"
            faction: "Rebel Alliance"
        }
        {
            name: "Phoenix Squadron"
            id: 380
            points: 4
            unique: true
            slot: "Command"
            faction: "Rebel Alliance"
            ship: "VCX-100 Light Freighter"
        }
        {
            name: "Disciplined"
            id: 381
            points: 2
            slot: "Talent"
            faction: "Galactic Empire"
        }
        {
            name: "Skystrike Academy Class"
            id: 382
            points: 3
            max_per_squad: 2
            slot: "Command"
            faction: "Galactic Empire"
            ship: ["TIE/ln Fighter", "TIE/in Interceptor"]
        }
        {
            name: "Shadow Wing"
            id: 383
            points: 4
            unique: true
            slot: "Command"
            faction: "Galactic Empire"
            ship: ["TIE/ln Fighter", "TIE/in Interceptor", "TIE/sa Bomber"]
        }
        {
            name: "In It For The Money"
            id: 384
            points: 1
            slot: "Command"
            faction: "Scum and Villainy"
            restrictions: [
                ["isUnique", true]
                ["Base", "Standard"]
            ]
        }
        {
            name: "Bounty"
            id: 385
            points: 1
            slot: "Command"
            faction: "Scum and Villainy"
            restrictions: [
                ["isUnique", true]
                ["Base", "Standard"]
            ]
        }
        {
            name: "Gamut Key"
            id: 386
            unique: true
            points: 6
            slot: "Crew"
            charge: 2
            recurring: 1
            faction: "Scum and Villainy"
        }
        {
            name: "Interloper Turn"
            id: 387
            points: 1
            slot: "Talent"
            recurring: 1
            ship: "TIE/d Defender"
        }
        {
            name: "Protectorate Gleb"
            id: 388
            unique: true
            points: 6
            slot: "Crew"
            faction: ["Galactic Empire", "First Order", "Scum and Villainy"]
            modifier_func: (stats) ->
                stats.actions.push 'R-Coordinate' if 'R-Coordinate' not in stats.actions
        }
        {
            name: "R4-B11"
            id: 389
            points: 3
            unique: true
            slot: "Astromech"
            faction: "Scum and Villainy"
        }
        {
            name: "Asajj Ventress (Command)"
            canonical_name: 'Asajj Ventress'.canonicalize()
            id: 390
            unique: true
            slot: "Command"
            points: 8
            faction: ["Scum and Villainy", "Separatist Alliance"]
            restrictions: [
                ["Slot", "Crew"]
                ["Base", "Huge"]
            ]
            validation_func: (ship, upgrade_obj) ->
                upgrade_obj.occupiesAnUpgradeSlot "Crew"
            also_occupies_upgrades: [ "Crew" ]
            force: 1
            modifier_func: (stats) ->
                stats.force += 1
                stats.actions.push '*Focus'
                stats.actions.push 'F-> Coordinate'
        }
        {
            name: "General Grievous (Command)"
            canonical_name: 'General Grievous'.canonicalize()
            id: 391
            unique: true
            slot: "Command"
            points: 5
            faction: "Separatist Alliance"
            restrictions: [
                ["Slot", "Crew"]
                ["Base", "Huge"]
            ]
            validation_func: (ship, upgrade_obj) ->
                upgrade_obj.occupiesAnUpgradeSlot "Crew"
            also_occupies_upgrades: [ "Crew" ]
        }
        {
            name: "Hondo Ohnaka (Command)"
            canonical_name: 'Hondo Ohnaka'.canonicalize()
            id: 392
            unique: true
            slot: "Command"
            points: 7
            charge: 2
            restrictions: [
                ["Slot", "Crew"]
                ["Base", "Huge"]
            ]
            validation_func: (ship, upgrade_obj) ->
                upgrade_obj.occupiesAnUpgradeSlot "Crew"
            also_occupies_upgrades: [ "Crew" ]
            modifier_func: (stats) ->
                stats.actions.push '*Coordinate'
                stats.actions.push 'R-> Jam'
        }
        {
            name: "Mar Tuuk"
            id: 393
            unique: true
            slot: "Command"
            points: 4
            faction: "Separatist Alliance"
            restrictions: [
                ["Slot", "Crew"]
                ["Base", "Huge"]
            ]
            validation_func: (ship, upgrade_obj) ->
                upgrade_obj.occupiesAnUpgradeSlot "Crew"
            also_occupies_upgrades: [ "Crew" ]
        }
        {
            name: "Riff Tamson"
            id: 394
            unique: true
            slot: "Command"
            points: 6
            faction: "Separatist Alliance"
            restrictions: [
                ["Slot", "Crew"]
                ["Base", "Huge"]
            ]
            validation_func: (ship, upgrade_obj) ->
                upgrade_obj.occupiesAnUpgradeSlot "Crew"
            also_occupies_upgrades: [ "Crew" ]
        }
        {
            name: "Zealous Captain"
            id: 395
            unique: true
            slot: "Command"
            points: 4
            restrictions: [
                ["Slot", "Crew"]
                ["Base", "Huge"]
            ]
            validation_func: (ship, upgrade_obj) ->
                upgrade_obj.occupiesAnUpgradeSlot "Crew"
            also_occupies_upgrades: [ "Crew" ]
        }
        {
            name: "Tractor Tentacles"
            id: 396
            slot: "Hardpoint"
            points: 0
            attackb: 2
            range: """1-2"""
            rangebonus: true
            ship: "Trident-class Assault Ship"
            restrictions: [
                ["Base", "Huge"]
            ]
        }
        {
            name: "Drill Beak"
            id: 397
            slot: "Hardpoint"
            points: 4
            attackb: 3
            range: """0-1"""
            rangebonus: true
            ship: "Trident-class Assault Ship"
            restrictions: [
                ["Slot", "Cargo"]
                ["Base", "Huge"]
            ]
            validation_func: (ship, upgrade_obj) ->
                upgrade_obj.occupiesAnUpgradeSlot "Cargo"
            also_occupies_upgrades: [ "Cargo" ]
        }
        {
            name: "Enhanced Propulsion"
            id: 398
            slot: "Hardpoint"
            points: 6
            ship: "Trident-class Assault Ship"
            restrictions: [
                ["Slot", "Cargo"]
                ["Base", "Huge"]
            ]
            validation_func: (ship, upgrade_obj) ->
                upgrade_obj.occupiesAnUpgradeSlot "Cargo"
            also_occupies_upgrades: [ "Cargo" ]
        }
        {
            name: "Proton Cannon Battery"
            id: 399
            slot: "Hardpoint"
            points: 10
            attackbull: 4
            range: """2-5"""
            restrictions: [
                ["Slot", "Cargo"]
                ["Base", "Huge"]
            ]
            validation_func: (ship, upgrade_obj) ->
                upgrade_obj.occupiesAnUpgradeSlot "Cargo"
            also_occupies_upgrades: [ "Cargo" ]
        }
        {
            name: "Droid Crew"
            id: 400
            slot: "Team"
            points: 5
            faction: "Separatist Alliance"
            modifier_func: (stats) ->
                stats.actions.push '*Calculate'
                stats.actions.push 'R-> Lock'
        }
        {
            name: "Tractor Technicians"
            id: 401
            slot: "Team"
            points: 2
        }
        {
            name: "Corsair Crew"
            id: 402
            slot: "Team"
            points: 5
            faction: "Scum and Villainy"
            restrictions: [
                ["Slot", "Gunner"]
            ]
            validation_func: (ship, upgrade_obj) ->
                upgrade_obj.occupiesAnUpgradeSlot "Gunner"
            also_occupies_upgrades: [ "Gunner" ]
        }
        {
            name: "Grappler"
            id: 403
            unique: true
            slot: "Title"
            ship: "Trident-class Assault Ship"
            points: 3
            modifier_func: (stats) ->
                stats.hull += 2
                stats.shields -= 1
        }
        {
            name: "Nautolan's Revenge"
            id: 404
            unique: true
            slot: "Title"
            points: 2
            ship: "Trident-class Assault Ship"
            faction: "Scum and Villainy"
            modifier_func: (stats) ->
                stats.hull -= 2
                stats.shields += 1
                stats.energy += 1
        }
        {
            name: "Neimoidian Grasp"
            id: 405
            unique: true
            slot: "Title"
            points: 5
            ship: "Trident-class Assault Ship"
            faction: "Separatist Alliance"
            modifier_func: (stats) ->
                stats.shields -= 2
        }
        {
            name: "Trident"
            id: 406
            unique: true
            slot: "Title"
            points: 4
            ship: "Trident-class Assault Ship"
            faction: "Separatist Alliance"
            modifier_func: (stats) ->
                stats.energy += 1
        }
        {
            name: "Tracking Torpedoes"
            id: 407
            slot: "Torpedo"
            points: 8
            attack: 4
            charge: 3
            applies_condition: '''Tracking Torpedoes'''.canonicalize()
            restrictions: [
                ["Base", "Huge"]
            ]
        }
        {
            name: "L4E-R5"
            id: 408
            unique: true
            slot: "Astromech"
            points: 3
            faction: "Resistance"
            restrictions: [
                ["Action", "Rotate Arc"]
            ]
            modifier_func: (stats) ->
                stats.actions.push '*Rotate Arc'
                stats.actions.push '> Calculate'
        }
        {
            name: "Wartime Loadout"
            id: 409
            slot: "Configuration"
            points: 5
            ship: "BTA-NR2 Y-wing"
            standardized: true
            chassis: "Devastating Barrage"
            restrictions: [
                ["Slot", "Modification"]
            ]
            validation_func: (ship, upgrade_obj) ->
                upgrade_obj.occupiesAnUpgradeSlot "Modification"
            also_occupies_upgrades: [ "Modification" ]
            modifier_func: (stats) ->
                stats.actions.push 'Lock'
                stats.actions.push 'Reload'
                stats.shields += 2
            confersAddons: [
                {
                    type: exportObj.Upgrade
                    slot: 'Torpedo'
                }
                {
                    type: exportObj.Upgrade
                    slot: 'Missile'
                }
            ]
        }
        {
            name: "Watchful Astromech"
            id: 410
            slot: "Astromech"
            points: 2
        }
        {
            name: "Overtuned Modulators"
            id: 411
            slot: "Illicit"
            points: 3
            charge: 1
        }
        {
            name: "DT-798"
            id: 412
            unique: true
            faction: "First Order"
            slot: "Gunner"
            points: 3
        }
        {
            name: "Enhanced Jamming Suite"
            id: 413
            slot: "Configuration"
            points: 0
            ship: "TIE/wi Whisper Modified Interceptor"
            restrictions: [
                ["Slot", "Tech"]
            ]
            validation_func: (ship, upgrade_obj) ->
                upgrade_obj.occupiesAnUpgradeSlot "Tech"
            also_occupies_upgrades: [ "Tech" ]
            modifier_func: (stats) ->
                stats.actions.push '*Focus'
                stats.actions.push '> Jam'
                stats.actions.push '*Barrel Roll'
                stats.actions.push '> Jam'
                stats.actions.push '*Boost'
                stats.actions.push '> Jam'
                stats.actions.push 'Jam'
        }
        {
            name: "First Order Ordnance Tech"
            id: 414
            faction: "First Order"
            slot: "Gunner"
            points: 3
            modifier_func: (stats) ->
                stats.actions.push '*Reload'
                stats.actions.push '> Lock'
        }
        {
            name: "Sensor Scramblers"
            id: 415
            ship: ["TIE/vn Silencer", "TIE/wi Whisper Modified Interceptor"]
            slot: "Tech"
            points: 1
        }
        {
            name: "Babu Frik"
            unique: true
            id: 416
            faction: ["Scum and Villainy", "Resistance"]
            slot: "Illicit"
            points: 5
            charge: 3
        }
        {
            name: "Compassion"
            id: 417
            points: 1
            slot: "Force"
            restrictions: [
                ["Keyword", "Light Side"]
            ]
        }
        {
            name: "Malice"
            id: 418
            points: 4
            slot: "Force"
            restrictions: [
                ["Keyword", "Dark Side"]
            ]
        }
        {
            name: "Shattering Shot"
            id: 419
            points: 3
            slot: "Force"
        }
        {
            name: "Electro-Chaff Missiles"
            id: 420
            points: 9
            slot: "Missile"
            max_per_squad: 2
            charge: 1
            restrictions: [
                ["Slot", "Device"]
            ]
            validation_func: (ship, upgrade_obj) ->
                upgrade_obj.occupiesAnUpgradeSlot "Device"
            also_occupies_upgrades: [ "Device" ]
            applies_condition: '''Electro-Chaff Cloud'''.canonicalize()
        }
        {
            name: "Feedback Ping"
            id: 421
            points: 1
            slot: "Talent"
            restrictions: [
                ["Keyword", "TIE"]
                ["Action", "Reload"]
            ]
        }
        {
            name: "Sabine Wren (Command)"
            canonical_name: 'Sabine Wren'.canonicalize()
            id: 422
            points: 99
            slot: "Command"
            unique: true
            faction: "Rebel Alliance"
            restrictions: [
                ["Slot", "Crew"]
                ["Base", "Standard"]
            ]
            validation_func: (ship, upgrade_obj) ->
                upgrade_obj.occupiesAnUpgradeSlot "Crew"
            also_occupies_upgrades: [ "Crew" ]
            modifier_func: (stats) ->
                stats.actions.push 'R-Coordinate' if 'R-Coordinate' not in stats.actions
            applies_condition: '''Trials of the Darksaber'''.canonicalize()
        }
        {
            name: "Clan Training"
            id: 423
            points: 3
            slot: "Talent"
            charge: 1
            restrictions: [
                ["Keyword", "Mandalorian"]
            ]
        }
        {
            name: "Ahsoka Tano (Crew)"
            canonical_name: 'Ahsoka Tano'.canonicalize()
            xws: "ahsokatano-crew"
            id: 424
            points: 9
            force: 1
            slot: "Crew"
            unique: true
            faction: ["Galactic Republic", "Scum and Villainy"]
            modifier_func: (stats) ->
                stats.force += 1
        }
        {
            name: "Bo-Katan Kryze (Republic/Separatist)"
            canonical_name: 'Bo-Katan Kryze'.canonicalize()
            xws: "bokatankryze"
            id: 425
            points: 6
            slot: "Crew"
            unique: true
            faction: ["Galactic Republic", "Separatist Alliance"]
        }
        {
            name: "Bo-Katan Kryze (Rebel/Scum)"
            canonical_name: 'Bo-Katan Kryze'.canonicalize()
            xws: "bokatankryze-rebel-scum"
            id: 426
            points: 4
            slot: "Crew"
            unique: true
            faction: ["Rebel Alliance", "Scum and Villainy"]
        }
        {
            name: "Captain Hark"
            id: 427
            points: 3
            charge: 2
            slot: "Crew"
            faction: "Galactic Empire"
            unique: true
        }
        {
            name: "Fenn Rau"
            id: 428
            points: 4
            slot: "Crew"
            unique: true
            faction: ["Rebel Alliance", "Scum and Villainy"]
        }
        {
            name: "Gar Saxon"
            id: 429
            points: 6
            slot: "Crew"
            faction: "Galactic Empire"
            unique: true
        }
        {
            name: "Korkie Kryze"
            id: 430
            points: 5
            slot: "Crew"
            faction: "Galactic Republic"
            unique: true
        }
        {
            name: "Obi-Wan Kenobi"
            id: 431
            points: 11
            force: 1
            slot: "Crew"
            unique: true
            faction: "Galactic Republic"
            modifier_func: (stats) ->
                stats.force += 1
        }
        {
            name: "Pre Vizsla"
            id: 432
            points: 9
            slot: "Crew"
            faction: ["Scum and Villainy", "Separatist Alliance"]
            unique: true
            modifier_func: (stats) ->
                stats.actions.push 'Coordinate' if 'Coordinate' not in stats.actions
        }
        {
            name: "Prime Minister Almec"
            id: 433
            points: 6
            slot: "Crew"
            unique: true
            faction: ["Galactic Republic", "Scum and Villainy"]
        }
        {
            name: "Rook Kast"
            id: 434
            points: 8
            slot: "Crew"
            unique: true
            faction: "Scum and Villainy"
            modifier_func: (stats) ->
                stats.actions.push 'R-Lock' if 'R-Lock' not in stats.actions
        }
        {
            name: "Satine Kryze"
            id: 435
            points: 10
            charge: 2
            recurring: 1
            slot: "Crew"
            unique: true
            faction: "Galactic Republic"
        }
        {
            name: "Savage Opress"
            id: 436
            points: 10
            force: 1
            slot: "Crew"
            unique: true
            faction: ["Separatist Alliance", "Scum and Villainy"]
            modifier_func: (stats) ->
                stats.force += 1
        }
        {
            name: "Tal Merrik"
            id: 437
            points: 7
            slot: "Crew"
            unique: true
            faction: "Separatist Alliance"
            applies_condition: '''False Friend'''.canonicalize()
        }
        {
            name: "Tristan Wren"
            id: 438
            points: 2
            charge: 1
            recurring: 1
            slot: "Crew"
            unique: true
            faction: ["Rebel Alliance", "Galactic Empire", "Scum and Villainy"]
            restrictions: [
                ["FactionOrUnique", "Gar Saxon", "Rebel Alliance"]
            ]
        }
        {
            name: "Ursa Wren"
            id: 439
            points: 6
            slot: "Crew"
            unique: true
            faction: "Rebel Alliance"
        }
        {
            name: "Maul (Mandalore)"
            canonical_name: 'Maul'.canonicalize()
            xws: 'maul-crew'
            id: 440
            points: 10
            slot: "Crew"
            unique: true
            force: 1
            faction: "Scum and Villainy"
            restrictions: [
                ["Slot", "Crew"]
            ]
            validation_func: (ship, upgrade_obj) ->
                upgrade_obj.occupiesAnUpgradeSlot "Crew"
            also_occupies_upgrades: [ "Crew" ]
            modifier_func: (stats) ->
                stats.force += 1
                stats.actions.push 'F-Coordinate' if 'F-Coordinate' not in stats.actions
            confersAddons: [
                {
                    type: exportObj.Upgrade
                    slot: "Illicit"
                }
            ]
        }
        {
            name: "Gar Saxon (Gunner)"
            canonical_name: 'Gar Saxon'.canonicalize()
            xws: "garsaxon-gunner"
            id: 441
            points: 6
            slot: "Gunner"
            unique: true
            faction: "Scum and Villainy"
            restrictions: [
                ["Base", "Large", "Huge"]
            ]
        }
        {
            name: "Tiber Saxon"
            id: 442
            points: 4
            charge: 2
            recurring: 1
            slot: "Gunner"
            faction: "Galactic Empire"
            unique: true
        }
        {
            name: "Ursa Wren (Gunner)"
            canonical_name: 'Ursa Wren'.canonicalize()
            xws: "ursawren-gunner"
            id: 443
            points: 4
            slot: "Gunner"
            unique: true
            faction: ["Galactic Republic", "Separatist Alliance"]
        }
        {
            name: "Blazer Bomb"
            id: 444
            points: 5
            charge: 1
            slot: "Device"
            applies_condition: '''Blazer Bomb'''.canonicalize()
        }
        {
            name: "Beskar Reinforced Plating"
            id: 445
            points: 6
            slot: "Modification"
            charge: 2
            restrictions: [
                ["Keyword", "Mandalorian"]
            ]
        }
        {
            name: "Mandalorian Optics"
            id: 446
            points: 5
            slot: "Modification"
            charge: 2
            restrictions: [
                ["Keyword", "Mandalorian"]
            ]
        }
        {
            name: "Gauntlet"
            id: 447
            points: 0
            slot: "Title"
            unique: true
            charge: 2
            ship: "Gauntlet Fighter"
            faction: ["Galactic Republic", "Separatist Alliance"]
            restrictions: [
                ["Slot", "Modification"]
            ]
            validation_func: (ship, upgrade_obj) ->
                upgrade_obj.occupiesAnUpgradeSlot "Modification"
            also_occupies_upgrades: [ "Modification" ]
            confersAddons: [
                {
                    type: exportObj.Upgrade
                    slot: "Crew"
                }
            ]
        }
        {
            name: "Nightbrother"
            id: 448
            points: 0
            slot: "Title"
            unique: true
            charge: 2
            recurring: 1
            ship: "Gauntlet Fighter"
            faction: ["Rebel Alliance", "Scum and Villainy"]
            restrictions: [
                ["Slot", "Modification"]
            ]
            validation_func: (ship, upgrade_obj) ->
                upgrade_obj.occupiesAnUpgradeSlot "Modification"
            also_occupies_upgrades: [ "Modification" ]
            confersAddons: [
                {
                    type: exportObj.Upgrade
                    slot: "Crew"
                }
            ]
        }
        {
            name: "Swivel Wing"
            id: 449
            points: 0
            slot: "Configuration"
            ship: "Gauntlet Fighter"
        }
        {
            name: "Clan Wren Commandos"
            id: 450
            points: 7
            slot: "Crew"
            unique: true
            charge: 2
            faction: "Rebel Alliance"
            restrictions: [
                ["Slot", "Crew"]
                ["Base", "Non-Small"]
            ]
            validation_func: (ship, upgrade_obj) ->
                upgrade_obj.occupiesAnUpgradeSlot "Crew"
            also_occupies_upgrades: [ "Crew" ]
            applies_condition: '''Clan Wren Commandos'''.canonicalize()
        }
        {
            name: "Razor Crest"
            id: 451
            points: 0
            unique: true
            slot: "Title"
            ship: "ST-70 Assault Ship"
            modifier_func: (stats) ->
                stats.actions.push '*Evade'
                stats.actions.push 'R-> Barrel Roll'
        }
        {
            name: "The Mandalorian"
            id: 452
            points: 2
            unique: true
            slot: "Crew"
            faction: "Scum and Villainy"
            modifier_func: (stats) ->
                stats.actions.push 'Reinforce'
        }
        {
            name: "The Child"
            id: 453
            points: 7
            unique: true
            slot: "Crew"
            force: 2
            forcerecurring: 0
            faction: ["Scum and Villainy", "Rebel Alliance", "Galactic Empire"]
            applies_condition: '''Merciless Pursuit'''.canonicalize()
            modifier_func: (stats) ->
                stats.force += 2
                stats.forcerecurring = 0
        }
        {
            name: "Tracking Fob"
            id: 454
            points: 4
            slot: "Illicit"
            max_per_squad: 3
            restrictions: [
                ["Keyword", "Bounty Hunter"]
            ]
            applies_condition: '''Marked for Elimination'''.canonicalize()
        }
        {
            name: "Notorious"
            id: 455
            points: 5
            charge: 2
            recurring: 1
            slot: "Talent"
            unique: true
            restrictions: [
                ["Equipped", "Illicit"]
            ]
        }
        {
            name: "Enduring"
            id: 456
            points: 5
            slot: "Talent"
        }
        {
            name: "IG-11"
            id: 457
            points: 6
            slot: "Crew"
            unique: true
            faction: "Scum and Villainy"
            modifier_func: (stats) ->
                stats.actions.push 'Calculate'
        }
        {
            name: "Greef Karga"
            id: 458
            points: 6
            slot: "Crew"
            unique: true
            faction: "Scum and Villainy"
            modifier_func: (stats) ->
                stats.actions.push 'R-Coordinate'
        }
        {
            name: "Kuiil"
            id: 459
            points: 4
            slot: "Crew"
            unique: true
            faction: "Scum and Villainy"
        }
        {
            name: "Peli Motto"
            id: 460
            points: 3
            slot: "Crew"
            unique: true
            faction: "Scum and Villainy"
            restrictions: [
                ["Base", "Medium", "Large"]
            ]
        }
        {
            name: "Migs Mayfeld"
            id: 461
            points: 4
            slot: "Gunner"
            unique: true
            faction: ["Scum and Villainy","Galactic Empire"]
        }
        {
            name: "Burnout Thrusters"
            id: 462
            points: 6
            slot: "Modification"
            charge: 1
            faction: ["Scum and Villainy"]
            restrictions: [
                ["Base", "Small", "Medium"]
            ]
            modifier_func: (stats) ->
                stats.actions.push 'Slam' if 'Slam' not in stats.actions
        }
        {
            name: "Hotshot Tail Blaster"
            id: 463
            points: 2
            attackb: 2
            range: """0-1"""
            rangebonus: true
            charge: 2
            slot: "Illicit"
            restrictions: [
                ["Base", "Medium", "Large"]
            ]
        }
        {
            name: "Combat Boarding Tube"
            id: 464
            points: 0
            slot: "Command"
            ship: "Gauntlet Fighter"
            restrictions: [
                ["Slot", "Configuration"]
                ["Base", "Standard"]
            ]
            validation_func: (ship, upgrade_obj) ->
                upgrade_obj.occupiesAnUpgradeSlot "Configuration"
            also_occupies_upgrades: [ "Configuration" ]
        }
        {
            name: "Drop-Seat Bay"
            id: 465
            points: 1
            slot: "Modification"
            ship: "Gauntlet Fighter"
            unequips_upgrades: [
                'Device'
            ]
            also_occupies_upgrades: [
                'Device'
            ]
            confersAddons: [
                {
                    type: exportObj.Upgrade
                    slot: "Crew"
                }
                {
                    type: exportObj.Upgrade
                    slot: "Crew"
                }
            ]
        }
        {
            name: "Mandalorian Super Commandos"
            id: 466
            points: 7
            slot: "Crew"
            unique: true
            charge: 2
            faction: "Scum and Villainy"
            restrictions: [
                ["Slot", "Crew"]
                ["Base", "Non-Small"]
            ]
            validation_func: (ship, upgrade_obj) ->
                upgrade_obj.occupiesAnUpgradeSlot "Crew"
            also_occupies_upgrades: [ "Crew" ]
            applies_condition: '''Mandalorian Super Commandos'''.canonicalize()
        }
        {
            name: "Imperial Super Commandos"
            id: 467
            points: 7
            slot: "Crew"
            unique: true
            charge: 2
            faction: "Galactic Empire"
            restrictions: [
                ["Slot", "Crew"]
                ["Base", "Non-Small"]
            ]
            validation_func: (ship, upgrade_obj) ->
                upgrade_obj.occupiesAnUpgradeSlot "Crew"
            also_occupies_upgrades: [ "Crew" ]
            applies_condition: '''Imperial Super Commandos'''.canonicalize()
        }
        {
            name: "Nite Owl Commandos"
            id: 468
            points: 7
            slot: "Crew"
            unique: true
            charge: 2
            faction: "Galactic Republic"
            restrictions: [
                ["Slot", "Crew"]
                ["Base", "Non-Small"]
            ]
            validation_func: (ship, upgrade_obj) ->
                upgrade_obj.occupiesAnUpgradeSlot "Crew"
            also_occupies_upgrades: [ "Crew" ]
            applies_condition: '''Nite Owl Commandos'''.canonicalize()
        }
        {
            name: "Death Watch Commandos"
            id: 469
            points: 7
            slot: "Crew"
            unique: true
            charge: 2
            faction: "Separatist Alliance"
            restrictions: [
                ["Slot", "Crew"]
                ["Base", "Non-Small"]
            ]
            validation_func: (ship, upgrade_obj) ->
                upgrade_obj.occupiesAnUpgradeSlot "Crew"
            also_occupies_upgrades: [ "Crew" ]
            applies_condition: '''Death Watch Commandos'''.canonicalize()
        }
        {
            name: "Proton Cannons"
            id: 470
            slot: "Cannon"
            points: 4
            attackbull: 4
            range: """2-3"""
            charge: 2
            recurring: 1
            restrictions: [
                ["Slot", "Cannon"]
            ]
            validation_func: (ship, upgrade_obj) ->
                upgrade_obj.occupiesAnUpgradeSlot "Cannon"
            also_occupies_upgrades: [ "Cannon" ]
        }
        {
            name: "Homing Torpedoes"
            id: 471
            slot: "Torpedo"
            points: 5
            attack: 4
            range: """1-2"""
            rangebonus: true
            charge: 2
        }
        {
            name: "Xanadu Blood"
            id: 472
            slot: "Title"
            unique: true
            points: 0
            ship: ["Rogue-class Starfighter"]
            modifier_func: (stats) ->
                stats.actions.push 'R-Cloak' if 'R-Cloak' not in stats.actions
            confersAddons: [
                {
                    type: exportObj.Upgrade
                    slot: "Crew"
                }
                {
                    type: exportObj.Upgrade
                    slot: "Device"
                }
            ]
        }
        {
            name: "Fanatic (BoY)"
            id: 473
            slot: "Talent"
            standard: true
        }
        {
            name: "Chewbacca (BoY)"
            canonical_name: 'Chewbacca'.canonicalize()
            id: 474
            slot: "Crew"
            standard: true
            unique: true
        }
        {
            name: "Attack Speed (BoY)"
            id: 475
            slot: "Talent"
            standard: true
        }
        {
            name: "Unstable Sublight Engines (BoY)"
            id: 476
            slot: "Modification"
            standard: true
        }
        {
            name: "R2-D2 (BoY)"
            canonical_name: 'R2-D2'.canonicalize()
            id: 477
            standard: true
            unique: true
            slot: "Astromech"
            charge: 2
        }
        {
            name: "Dorsal Turret (BoY)"
            id: 478
            standard: true
            slot: "Turret"
            attackt: 3
            range: """1-2"""
            modifier_func: (stats) ->
                stats.actions.push 'Rotate Arc' if 'Rotate Arc' not in stats.actions
        }
        {
            name: "R2-F2 (BoY)"
            canonical_name: 'R2-F2'.canonicalize()
            id: 479
            standard: true
            unique: true
            slot: "Astromech"
            charge: 2
        }
        {
            name: "Precise Astromech (BoY)"
            id: 480
            standard: true
            slot: "Astromech"
            charge: 2
        }
        {
            name: "R2-A3 (BoY)"
            canonical_name: 'R2-A3'.canonicalize()
            id: 481
            standard: true
            unique: true
            slot: "Astromech"
            charge: 2
        }
        {
            name: "Vengeful (BoY)"
            id: 482
            standard: true
            slot: "Talent"
        }
        {
            name: "R5-D8 (BoY)"
            canonical_name: 'R5-D8'.canonicalize()
            id: 483
            standard: true
            unique: true
            slot: "Astromech"
            charge: 2
        }
        {
            name: "R5-K6 (BoY)"
            canonical_name: 'R5-K6'.canonicalize()
            id: 484
            standard: true
            unique: true
            slot: "Astromech"
            charge: 2
        }
        {
            name: "Sensor Jammer (BoY)"
            id: 485
            standard: true
            slot: "Sensor"
        }
        {
            name: "Ancillary Ion Weapons (SoC)"
            id: 486
            standard: true
            slot: "Cannon"
            charge: 2
            recurring: 1
        }
        {
            name: "Roiling Anger (SoC)"
            id: 487
            standard: true
            slot: "Force"
        }
        {
            name: "Contingency Protocol (SoC)"
            id: 488
            standard: true
            slot: "Modification"
        }
        {
            name: "Strut-Lock Override (SoC)"
            id: 489
            standard: true
            charge: 2
            slot: "Configuration"
        }
        {
            name: "R4-P17 (SoC)"
            id: 490
            standard: true
            charge: 2
            slot: "Astromech"
        }
        {
            name: "Targeting Astromech (BoY)"
            id: 491
            standard: true
            slot: "Astromech"
        }
        {
            name: "Wolfpack (SoC)"
            canonical_name: 'Wolfpack'.canonicalize()
            id: 492
            unique: true
            standard: true
            slot: "Crew"
        }
        {
            name: "Evasion Sequence 7 (SoC)"
            id: 493
            standard: true
            slot: "Modification"
        }
    ]


    conditionsById: [
        {
            name: '''Zero Condition'''
            id: 0
        }
        {
            name: 'Suppressive Fire'
            id: 1
            unique: true
        }
        {
            name: 'Hunted'
            id: 2
            unique: true
        }
        {
            name: 'Listening Device'
            id: 3
            unique: true
        }
        {
            name: 'Optimized Prototype'
            id: 4
            unique: true
        }
        {
            name: '''I'll Show You the Dark Side'''
            id: 5
            unique: true
        }
        {
            name: 'Proton Bomb'
            id: 6
        }
        {
            name: 'Seismic Charge'
            id: 7
        }
        {
            name: 'Bomblet'
            id: 8
        }
        {
            name: 'Loose Cargo'
            id: 9
        }
        {
            name: 'Conner Net'
            id: 10
        }
        {
            name: 'Proximity Mine'
            id: 11
        }
        {
            name: 'Rattled'
            id: 12
            unique: true
        }
        {
            name: 'DRK-1 Probe Droid'
            id: 13
        }
        {
            name: 'Buzz Droid Swarm'
            id: 14
        }
        {
            name: '''It's the Resistance'''
            id: 15
        }
        {
            name: 'Electro-Proton Bomb'
            id: 16
        }
        {
            name: 'Decoyed'
            id: 17
            unique: true
        }
        {
            name: 'Compromising Intel'
            id: 18
            unique: true
        }
        {
            name: 'Cluster Mine'
            id: 19
        }
        {
            name: 'Ion Bomb'
            id: 20
        }
        {
            name: 'Concussion Bomb'
            id: 21
        }
        {
            name: 'Thermal Detonator'
            id: 22
        }
        {
            name: 'Sensor Buoy'
            id: 23
        }
        {
            name: 'Fearful Prey'
            id: 24
            unique: true
        }
        {
            name: 'You Should Thank Me'
            id: 25
        }
        {
            name: '''You'd Better Mean Business'''
            id: 26
        }
        {
            name: '''Spare Parts'''
            id: 27
        }
        {
            name: '''Electro-Chaff Cloud'''
            id: 28
        }
        {
            name: '''Tracking Torpedoes'''
            id: 29
        }
        {
            name: '''False Friend'''
            id: 30
            unique: true
        }
        {
            name: '''Trials of the Darksaber'''
            id: 31
            unique: true
        }
        {
            name: '''Blazer Bomb'''
            id: 32
        }
        {
            name: '''Merciless Pursuit'''
            id: 33
        }
        {
            name: '''Marked for Elimination'''
            id: 34
            unique: true
        }
        {
            name: '''Clan Wren Commandos'''
            id: 35
        }
        {
            name: '''Nite Owl Commandos'''
            id: 36
        }
        {
            name: '''Death Watch Commandos'''
            id: 37
        }
        {
            name: '''Imperial Super Commandos'''
            id: 38
        }
        {
            name: '''Mandalorian Super Commandos'''
            id: 39
        }
        {
            name: '''Guarded'''
            id: 40
        }
        {
            name: '''Sickening Maneuver'''
            id: 41
        }
        {
            name: '''Primed For Speed'''
            id: 42
        }
        {
            name: '''Broken Trust'''
            id: 43
        }
    ]

    chassisById: [
        {
            name: "Hope"
            id: 0
        }
        {
            name: "Autothrusters"
            id: 1
        }
        {
            name: "Microthrusters"
            id: 2
        }
        {
            name: "Sensor Blindspot"
            id: 3
        }
        {
            name: "Stygium Array"
            id: 4
        }
        {
            name: "Experimental Scanners"
            id: 5
        }
        {
            name: "Full Throttle"
            id: 6
        }
        {
            name: "Nimble Bomber"
            id: 7
        }
        {
            name: "Weapon Hardpoint"
            id: 8
        }
        {
            name: "Advanced Targeting Computer"
            id: 9
        }
        {
            name: "Vectored Thrusters"
            id: 10
        }
        {
            name: "Advanced Fire Control"
            id: 11
        }
        {
            name: "Sensitive Controls"
            id: 12
        }
        {
            name: "Spacetug Tractor Array"
            id: 13
        }
        {
            name: "Concordia Faceoff"
            id: 14
        }
        {
            name: "Locked and Loaded"
            id: 15
        }
        {
            name: "Tail Gun"
            id: 16
        }
        {
            name: "Advanced Droid Brain"
            id: 17
        }     
        {
            name: "Vectored Cannons"
            id: 18
        }
        {
            name: "Networked Calculations"
            id: 19
        }
        {
            name: "Independent Calculations"
            id: 20
        }
        {
            name: "Linked Battery"
            id: 21
        }
        {
            name: "Heavy Weapon Turret"
            id: 22
        }
        {
            name: "Refined Gyrostabilizers"
            id: 23
        }
        {
            name: "Rigged Energy Cells"
            id: 24
        }
        {
            name: "Co-Pilot"
            id: 25
        }
        {
            name: "Controlled Ailerons"
            id: 26
        }
        {
            name: "Comms Shuttle"
            id: 27
        }
        {
            name: "Dead to Rights"
            id: 28
        }
        {
            name: "Pursuit Craft"
            id: 29
        }
        {
            name: "Adaptive Ailerons"
            id: 30
        }
        {
            name: "Fire Convergence"
            id: 31
        }
        {
            name: "Networked Aim"
            id: 32
        }
        {
            name: "Fine-Tuned Thrusters"
            id: 33
        }
        {
            name: "Explosion with Wings"
            id: 34
        }
        {
            name: "Plated Hull"
            id: 35
        }
        {
            name: "Pinpoint Tractor Array"
            id: 36
        }
        {
            name: "Fine-Tuned Controls"
            id: 37
        }
        {
            name: "Notched Stabilizers"
            id: 38
        }
        {
            name: "Rotating Cannons"
            id: 39
        }
        {
            name: "Twin Ion Engines"
            id: 40
        }
        {
            name: "Versatile Frame"
            id: 41
        }
        {
            name: "Pursuit Thrusters"
            id: 42
        }
        {
            name: "Devastating Barrage"
            id: 43
        }
        {
            name: "Intuitive Interface"
            id: 44
        }
        {
            name: "Intuitive Controls"
            id: 45
        }
        {
            name: "Born for This"
            id: 46
        }
        {
            name: "Modified for Organics"
            id: 47
            modifier_func: (stats) ->
                if stats.maneuvers[2]?
                    for turn in [0 ... 5]
                        if (turn == 1 or turn == 3)
                            if stats.maneuvers[2][turn] > 1
                                stats.maneuvers[2][turn]--
                            if stats.maneuvers[3][turn] > 1
                                stats.maneuvers[3][turn]--
                        if (turn == 0 or turn == 4) and stats.maneuvers[3][turn] < 3
                            stats.maneuvers[3][turn]++
        }
        {
            name: "Solo"
            id: 48
        }
    ]

exportObj.setupCommonCardData = (basic_cards) ->
    # assert that each ID is the index into BLAHById (should keep this, in general)
    for pilot_data, i in basic_cards.pilotsById
        if pilot_data.id != i
            throw new Error("ID mismatch: pilot at index #{i} has ID #{pilot_data.id}")
    for upgrade_data, i in basic_cards.upgradesById
        if upgrade_data.id != i
            throw new Error("ID mismatch: upgrade at index #{i} has ID #{upgrade_data.id}")
    for condition_data, i in basic_cards.conditionsById
        if condition_data.id != i
            throw new Error("ID mismatch: condition at index #{i} has ID #{condition_data.id}")
    for chassis_data, i in basic_cards.chassisById
        if chassis_data.id != i
            throw new Error("ID mismatch: chassis at index #{i} has ID #{chassis_data.id}")


    exportObj.pilots = {}
    # Assuming a given pilot is unique by name...
    for pilot_data in basic_cards.pilotsById
        unless pilot_data.skip?
            pilot_data.sources = []
            pilot_data.canonical_name = pilot_data.name.canonicalize() unless pilot_data.canonical_name?
            exportObj.pilots[pilot_data.name] = pilot_data
    # pilot_name is the English version here as it's the common index into
    # basic card info

    exportObj.upgrades = {}
    for upgrade_data in basic_cards.upgradesById
        unless upgrade_data.skip?
            upgrade_data.sources = []
            upgrade_data.canonical_name = upgrade_data.name.canonicalize() unless upgrade_data.canonical_name?
            exportObj.upgrades[upgrade_data.name] = upgrade_data

    exportObj.conditions = {}
    for condition_data in basic_cards.conditionsById
        unless condition_data.skip?
            condition_data.canonical_name = condition_data.name.canonicalize() unless condition_data.canonical_name?
            exportObj.conditions[condition_data.name] = condition_data

    exportObj.chassis = {}
    for chassis_data in basic_cards.chassisById
        unless chassis_data.skip?
            chassis_data.canonical_name = chassis_data.name.canonicalize() unless chassis_data.canonical_name?
            exportObj.chassis[chassis_data.name] = chassis_data

    exportObj.obstacles = {}
    # we just want to include obstacles in the manifest like we already do for other stuff. No information other than sources will be used

    for ship_name, ship_data of basic_cards.ships
        ship_data.canonical_name ?= ship_data.name.canonicalize()
        ship_data.sources = []

    # Set sources from manifest
    for expansion, cards of exportObj.manifestByExpansion
        # console.log(exportObj.manifestByExpansion)
        for card in cards
            continue if card.skipForSource # heavy scyk special case :(
            try
                switch card.type
                    when 'pilot'
                        exportObj.pilots[card.name].sources.push expansion
                    when 'upgrade'
                        exportObj.upgrades[card.name].sources.push expansion
                    when 'ship'
                        exportObj.ships[card.name].sources.push expansion
                    when 'obstacle'
                        if card.name not of exportObj.obstacles
                            exportObj.obstacles[card.name] = {sources: []}
                        exportObj.obstacles[card.name].sources.push expansion
                    else
                        throw new Error("Unexpected card type #{card.type} for card #{card.name} of #{expansion}")
            catch e
                console.log(e)
                console.error "Error adding card #{card.name} (#{card.type}) from #{expansion}"


    for name, card of exportObj.pilots
        card.sources = card.sources.sort()
    for name, card of exportObj.upgrades
        card.sources = card.sources.sort()

    exportObj.expansions = {}

    exportObj.pilotsById = {}
    for pilot_name, pilot of exportObj.pilots
        exportObj.fixIcons pilot
        exportObj.pilotsById[pilot.id] = pilot
        for source in pilot.sources
            exportObj.expansions[source] = 1 if source not of exportObj.expansions
    if Object.keys(exportObj.pilotsById).length != Object.keys(exportObj.pilots).length
        throw new Error("At least one pilot shares an ID with another")

    exportObj.pilotsByFactionCanonicalName = {}
    exportObj.pilotsByKeyword = {}
    # uniqueness can't be enforced just be canonical name, but by the base part
    exportObj.pilotsByUniqueName = {}
    for pilot_name, pilot of exportObj.pilots
        ((exportObj.pilotsByFactionCanonicalName[pilot.faction] ?= {})[pilot.canonical_name] ?= []).push pilot
        ((exportObj.pilotsByKeyword[pilot.keyword] ?= {})[pilot.canonical_name] ?= []).push pilot
        (exportObj.pilotsByUniqueName[pilot.canonical_name.getXWSBaseName()] ?= []).push pilot

    exportObj.pilotsByFactionXWS = {}
    for pilot_name, pilot of exportObj.pilots
        ((exportObj.pilotsByFactionXWS[pilot.faction] ?= {})[pilot.xws] ?= []).push pilot


    exportObj.upgradesById = {}
    for upgrade_name, upgrade of exportObj.upgrades
        exportObj.fixIcons upgrade
        exportObj.upgradesById[upgrade.id] = upgrade
        for source in upgrade.sources
            exportObj.expansions[source] = 1 if source not of exportObj.expansions
    if Object.keys(exportObj.upgradesById).length != Object.keys(exportObj.upgrades).length
        throw new Error("At least one upgrade shares an ID with another")

    exportObj.upgradesBySlotCanonicalName = {}
    exportObj.upgradesBySlotXWSName = {}
    exportObj.upgradesBySlotUniqueName = {}
    exportObj.upgradesByUniqueName = {}
    for upgrade_name, upgrade of exportObj.upgrades
        (exportObj.upgradesBySlotCanonicalName[upgrade.slot] ?= {})[upgrade.canonical_name] = upgrade
        (exportObj.upgradesBySlotXWSName[upgrade.slot] ?= {})[upgrade.xws] = upgrade
        (exportObj.upgradesBySlotUniqueName[upgrade.slot] ?= {})[upgrade.canonical_name.getXWSBaseName()] = upgrade
        (exportObj.upgradesByUniqueName[upgrade.canonical_name.getXWSBaseName()] ?= []).push upgrade

    exportObj.conditionsById = {}
    for condition_name, condition of exportObj.conditions
        exportObj.fixIcons condition
        exportObj.conditionsById[condition.id] = condition
    if Object.keys(exportObj.conditionsById).length != Object.keys(exportObj.conditions).length
        throw new Error("At least one condition shares an ID with another")

    exportObj.chassisById = {}
    for chassis_name, chassis of exportObj.chassis
        exportObj.fixIcons chassis
        exportObj.chassisById[chassis.id] = chassis
    if Object.keys(exportObj.chassisById).length != Object.keys(exportObj.chassis).length
        throw new Error("At least one chassis shares an ID with another")

    exportObj.conditionsByCanonicalName = {}
    for condition_name, condition of exportObj.conditions
        (exportObj.conditionsByCanonicalName ?= {})[condition.canonical_name] = condition

    exportObj.chassisByCanonicalName = {}
    for chassis_name, chassis of exportObj.chassis
        (exportObj.chassisByCanonicalName ?= {})[chassis.canonical_name] = chassis


    exportObj.expansions = Object.keys(exportObj.expansions).sort()

exportObj.setupTranslationCardData = (pilot_translations, upgrade_translations, condition_translations, chassis_translations) ->
    for upgrade_name, translations of upgrade_translations
        exportObj.fixIcons translations
        for field, translation of translations
            try
                exportObj.upgrades[upgrade_name][field] = translation
            catch e
                console.error "Cannot find translation for attribute #{field} for upgrade #{upgrade_name}. Please report this Issue. "
                throw e

    for condition_name, translations of condition_translations
        exportObj.fixIcons translations
        for field, translation of translations
            try
                exportObj.conditions[condition_name][field] = translation
            catch e
                console.error "Cannot find translation for attribute #{field} for condition #{condition_name}. Please report this Issue. "
                throw e

    for chassis_name, translations of chassis_translations
        exportObj.fixIcons translations
        for field, translation of translations
            try
                exportObj.chassis[chassis_name][field] = translation
            catch e
                console.error "Cannot find translation for attribute #{field} for chassis #{chassis_name}. Please report this Issue. "
                throw e


    for pilot_name, translations of pilot_translations
        exportObj.fixIcons translations
        for field, translation of translations
            try
                exportObj.pilots[pilot_name][field] = translation
            catch e
                console.error "Cannot find translation for attribute #{field} for pilot #{pilot_name}. Please report this Issue. "
                throw e

exportObj.fixIcons = (data) ->
    if data.text?
        data.text = data.text
            .replace(/%BULLSEYEARC%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-bullseyearc"></i>')
            .replace(/%SINGLETURRETARC%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-singleturretarc"></i>')
            .replace(/%DOUBLETURRETARC%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-doubleturretarc"></i>')
            .replace(/%FRONTARC%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-frontarc"></i>')
            .replace(/%REARARC%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-reararc"></i>')
            .replace(/%LEFTARC%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-leftarc"></i>')
            .replace(/%RIGHTARC%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-rightarc"></i>')
            .replace(/%ROTATEARC%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-rotatearc"></i>')
            .replace(/%FULLFRONTARC%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-fullfrontarc"></i>')
            .replace(/%FULLREARARC%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-fullreararc"></i>')
            .replace(/%DEVICE%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-device"></i>')
            .replace(/%MODIFICATION%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-modification"></i>')
            .replace(/%RELOAD%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-reload"></i>')
            .replace(/%FORCE%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-forcecharge"></i>')
            .replace(/%CHARGE%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-charge"></i>')
            .replace(/%ENERGY%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-energy"></i>')
            .replace(/%CALCULATE%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-calculate"></i>')
            .replace(/%BANKLEFT%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-bankleft"></i>')
            .replace(/%BANKRIGHT%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-bankright"></i>')
            .replace(/%BARRELROLL%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-barrelroll"></i>')
            .replace(/%BOOST%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-boost"></i>')
            .replace(/%CANNON%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-cannon"></i>')
            .replace(/%CARGO%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-cargo"></i>')
            .replace(/%CLOAK%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-cloak"></i>')
            .replace(/%F-COORDINATE%/g, '<i class="xwing-miniatures-font force xwing-miniatures-font-coordinate"></i>')
            .replace(/%COORDINATE%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-coordinate"></i>')
            .replace(/%CRIT%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-crit"></i>')
            .replace(/%ASTROMECH%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-astromech"></i>')
            .replace(/%GUNNER%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-gunner"></i>')
            .replace(/%CREW%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-crew"></i>')
            .replace(/%TACTICALRELAY%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-tacticalrelay"></i>')
            .replace(/%HARDPOINT%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-hardpoint"></i>')
            .replace(/%EVADE%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-evade"></i>')
            .replace(/%FOCUS%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-focus"></i>')
            .replace(/%HIT%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-hit"></i>')
            .replace(/%ILLICIT%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-illicit"></i>')
            .replace(/%JAM%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-jam"></i>')
            .replace(/%KTURN%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-kturn"></i>')
            .replace(/%MISSILE%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-missile"></i>')
            .replace(/%RECOVER%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-recover"></i>')
            .replace(/%F-REINFORCE%/g, '<i class="xwing-miniatures-font force xwing-miniatures-font-reinforce"></i>')
            .replace(/%REINFORCE%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-reinforce"></i>')
            .replace(/%REVERSESTRAIGHT%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-reversestraight"></i>')
            .replace(/%REVERSEBANKLEFT%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-reversebankleft"></i>')
            .replace(/%REVERSEBANKRIGHT%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-reversebankright"></i>')
            .replace(/%SHIELD%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-shield"></i>')
            .replace(/%SLAM%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-slam"></i>')
            .replace(/%SLOOPLEFT%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-sloopleft"></i>')
            .replace(/%SLOOPRIGHT%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-sloopright"></i>')
            .replace(/%STRAIGHT%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-straight"></i>')
            .replace(/%STOP%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-stop"></i>')
            .replace(/%SENSOR%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-sensor"></i>')
            .replace(/%LOCK%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-lock"></i>')
            .replace(/%TORPEDO%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-torpedo"></i>')
            .replace(/%TROLLLEFT%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-trollleft"></i>')
            .replace(/%TROLLRIGHT%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-trollright"></i>')
            .replace(/%TURNLEFT%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-turnleft"></i>')
            .replace(/%TURNRIGHT%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-turnright"></i>')
            .replace(/%TURRET%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-turret"></i>')
            .replace(/%UTURN%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-kturn"></i>')
            .replace(/%TALENT%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-talent"></i>')
            .replace(/%TITLE%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-title"></i>')
            .replace(/%TEAM%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-team"></i>')
            .replace(/%TECH%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-tech"></i>')
            .replace(/%FORCEPOWER%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-forcepower"></i>')
            .replace(/%RANGEBONUS%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-rangebonusindicator"></i>')
            .replace(/%CONFIGURATION%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-config"></i>')
            .replace(/%AGILITY%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-agility"></i>')
            .replace(/%HULL%/g, '<i class="xwing-miniatures-font xwing-miniatures-font-hull"></i>')
            .replace(/%LINEBREAK%/g, '<br /><br />')

exportObj.canonicalizeShipNames = (card_data) ->
    for ship_name, ship_data of card_data.ships
        ship_data.canonical_name ?= ship_data.name.canonicalize()

exportObj.renameShip = (name, new_name) ->
    exportObj.ships[name].display_name = new_name

exportObj.randomizer = (faction_name, points) ->
    shiplistmaster = exportObj.basicCardData #export ship database
    listcount = 0 #start count at 0
    #for shiplistmaster in shiplistmaster.pilotsbyid.faction == faction_name loop grab pilots by faction
        #if Math.random() >= 0.9
        #append.shiplistmaster.pilotsbyid.xws ? shiplistmaster.pilotsbyid.canonical_name ? shiplistmaster.pilotsbyid.name.canonicalize())

exportObj.standardShipInclusions = [
    {name: 'T-65 X-wing', faction: 'Rebel Alliance'}
    {name: 'Modified YT-1300 Light Freighter', faction: 'Rebel Alliance'}
    {name: 'A/SF-01 B-wing', faction: 'Rebel Alliance'}
    {name: 'RZ-1 A-wing', faction: 'Rebel Alliance'}
    {name: 'BTL-A4 Y-wing', faction: 'Rebel Alliance'}
    {name: 'VCX-100 Light Freighter', faction: 'Rebel Alliance'}
    {name: 'Sheathipede-Class Shuttle', faction: 'Rebel Alliance'}
    {name: 'ARC-170 Starfighter', faction: 'Rebel Alliance'}
    {name: 'Fang Fighter', faction: 'Rebel Alliance'}
    {name: 'TIE/ln Fighter', faction: 'Rebel Alliance'}
    {name: 'HWK-290 Light Freighter', faction: 'Rebel Alliance'}
    {name: 'UT-60D U-wing', faction: 'Rebel Alliance'}
    {name: 'Z-95-AF4 Headhunter', faction: 'Rebel Alliance'}
    {name: 'Gauntlet Fighter', faction: 'Rebel Alliance'}

    {name: 'TIE Advanced x1', faction: 'Galactic Empire'}
    {name: 'TIE Advanced v1', faction: 'Galactic Empire'}
    {name: 'TIE/ln Fighter', faction: 'Galactic Empire'}
    {name: 'TIE/in Interceptor', faction: 'Galactic Empire'}
    {name: 'TIE Reaper', faction: 'Galactic Empire'}
    {name: 'TIE/d Defender', faction: 'Galactic Empire'}
    {name: 'TIE/sk Striker', faction: 'Galactic Empire'}
    {name: 'TIE/rb Heavy', faction: 'Galactic Empire'}
    {name: 'VT-49 Decimator', faction: 'Galactic Empire'}
    {name: 'Gauntlet Fighter', faction: 'Galactic Empire'}

    {name: 'Firespray-class Patrol Craft', faction: 'Scum and Villainy'}
    {name: 'BTL-A4 Y-wing', faction: 'Scum and Villainy'}
    {name: 'Modified TIE/ln Fighter', faction: 'Scum and Villainy'}
    {name: 'Fang Fighter', faction: 'Scum and Villainy'}
    {name: 'JumpMaster 5000', faction: 'Scum and Villainy'}
    {name: 'M3-A Interceptor', faction: 'Scum and Villainy'}
    {name: 'Customized YT-1300 Light Freighter', faction: 'Scum and Villainy'}
    {name: 'Escape Craft', faction: 'Scum and Villainy'}
    {name: 'YV-666 Light Freighter', faction: 'Scum and Villainy'}
    {name: 'Z-95-AF4 Headhunter', faction: 'Scum and Villainy'}
    {name: 'HWK-290 Light Freighter', faction: 'Scum and Villainy'}
    {name: 'ST-70 Assault Ship', faction: 'Scum and Villainy'}
    {name: 'Rogue-class Starfighter', faction: 'Scum and Villainy'}
    {name: 'Gauntlet Fighter', faction: 'Scum and Villainy'}

    {name: 'Fireball', faction: 'Resistance'}
    {name: 'T-70 X-wing', faction: 'Resistance'}
    {name: 'RZ-2 A-wing', faction: 'Resistance'}
    {name: 'BTA-NR2 Y-wing', faction: 'Resistance'}
    {name: 'Resistance Transport', faction: 'Resistance'}
    {name: 'Resistance Transport Pod', faction: 'Resistance'}
    {name: 'Scavenged YT-1300', faction: 'Resistance'}

    {name: 'TIE/ba Interceptor', faction: 'First Order'}
    {name: 'TIE/fo Fighter', faction: 'First Order'}
    {name: 'TIE/vn Silencer', faction: 'First Order'}
    {name: 'TIE/sf Fighter', faction: 'First Order'}
    {name: 'TIE/se Bomber', faction: 'First Order'}
    {name: 'TIE/wi Whisper Modified Interceptor', faction: 'First Order'}
    {name: 'Xi-class Light Shuttle', faction: 'First Order'}

    {name: 'Delta-7 Aethersprite', faction: 'Galactic Republic'}
    {name: 'Delta-7b Aethersprite', faction: 'Galactic Republic'}
    {name: 'ARC-170 Starfighter', faction: 'Galactic Republic'}
    {name: 'Naboo Royal N-1 Starfighter', faction: 'Galactic Republic'}
    {name: 'BTL-B Y-wing', faction: 'Galactic Republic'}
    {name: 'V-19 Torrent Starfighter', faction: 'Galactic Republic'}
    {name: 'Eta-2 Actis', faction: 'Galactic Republic'}
    {name: 'Nimbus-class V-wing', faction: 'Galactic Republic'}
    {name: 'LAAT/i Gunship', faction: 'Galactic Republic'}
    {name: 'Gauntlet Fighter', faction: 'Galactic Republic'}
    {name: 'Clone Z-95 Headhunter', faction: 'Galactic Republic'}

    {name: 'Vulture-class Droid Fighter', faction: 'Separatist Alliance'}
    {name: 'Hyena-class Droid Bomber', faction: 'Separatist Alliance'}
    {name: 'Droid Tri-fighter', faction: 'Separatist Alliance'}
    {name: 'Firespray-class Patrol Craft', faction: 'Separatist Alliance'}
    {name: 'Sith Infiltrator', faction: 'Separatist Alliance'}
    {name: 'Nantex-Class Starfighter', faction: 'Separatist Alliance'}
    {name: 'HMP Droid Gunship', faction: 'Separatist Alliance'}
    {name: 'Belbullab-22 Starfighter', faction: 'Separatist Alliance'}
    {name: 'Gauntlet Fighter', faction: 'Separatist Alliance'}
    {name: 'Rogue-class Starfighter', faction: 'Separatist Alliance'}
]

# Used to exclude pilots from included ships
exportObj.standardPilotExclusions = [

    # Rebel Alliance
    'Hera Syndulla (VCX-100)'

    # Galactic Empire
    'Ved Foslo'

    # Scum and Villainy

    # Resistance
    'Han Solo (Resistance)'
    'Vi Moradi'

    # FO

    # Galactic Republic
    'Saesee Tiin'
    'Saesee Tiin (Delta-7b)'

    # Separatist Alliance
    'Phlac-Arphocc Prototype'

]

# Upgrades in that are not in standard
exportObj.standardUpgradeExclusions = [
    # Rebel Alliance
    'Cassian Andor'
    'Sabine Wren'

    # Galactic Empire
    'Admiral Sloane'

    # Scum and Villainy
    'Boba Fett'
    'Tobias Beckett'
    'Slave I'

    # Resistance
    'Kaydel Connix'

    # FO
    'Supreme Leader Snoke'
    'Commander Pyre'

    # Galactic Republic
    'R2-A6'
  
    # Separatist Alliance
    'Tal Merrik'

    # Generic
    'Advanced Sensors'
    'Autoblasters'
    'Delta-7B'
    'Hull Upgrade'
    'Inertial Dampeners'
    'Informant'
    'Interloper Turn'
    'Intimidation'
    'Precognitive Reflexes'
    'R2 Astromech'
    'R5 Astromech'
    'Seasoned Navigator'
    'Sense'
    'Supernatural Reflexes'
    'Static Discharge Vanes'
    'Stealth Device'
    'Trajectory Simulator'
]

exportObj.epicExclusionsList = [
    'CR90 Corellian Corvette'
    'Raider-class Corvette'
    'GR-75 Medium Transport'
    'Gozanti-class Cruiser'
    'C-ROC Cruiser'
    'Syliure-class Hyperspace Ring'
    'Trident-class Assault Ship'
]


exportObj.epicExclusions = (data) ->
    if data.ship? and (data.ship in exportObj.epicExclusionsList)
        return false
    else if data.slot? and (data.slot == "Command")
        return false
    else if data.name? and (data.name in exportObj.epicExclusionsList)
        return false
    else
        return true

# Ships/Pilots excluded unless in the included list (with further excluded pilots list for included ships, i.e u-wing)
# while upgrades assumed included unless on the excluded list
exportObj.standardCheck = (data, faction='', shipCheck=false) ->
    if (shipCheck)
        if (data.name in exportObj.standardPilotExclusions)
            return false
        for ship in exportObj.standardShipInclusions
            if (ship.faction == faction && (data.name == ship.name || data.ship == ship.name || (Array.isArray(data.ship) and ship.name in data.ship)))
                return true
        return false
    else
        return data.name not in exportObj.standardUpgradeExclusions

exportObj.standardCheckBrowser = (data, faction='', type) ->
    # check ship/pilot first
    if type == 'Pilot'
        check = false
        for ship in exportObj.standardShipInclusions
            if (data.faction == ship.faction && (data.ship == ship.name))
                check = true
        if check == false
            return false
        return data.name not in exportObj.standardPilotExclusions
    else if type == 'Ship'
        for ship in exportObj.standardShipInclusions
            # checks against name for ship itself or ship name/faction for pilot inclusions
            if (ship.faction == faction && (data.name == ship.name || data.ship == ship.name || (Array.isArray(data.ship) and ship.name in data.ship)))
                return true
        return false
    else
        return data.name not in exportObj.standardUpgradeExclusions

#not functional yet
String::serialtoxws = ->
    list = this.getParameterByName('d')
    re = if "Z" in list then /^v(\d+)Z(.*)/ else /^v(\d+)!(.*)/
    matches = re.exec list
    if matches? and version > 7 and !serialized_ships?
        version = parseInt matches[1]
        ship_splitter = 'Y'
        [g, p, s] = matches[2].split('Z')
        [ game_type_abbrev, desired_points, serialized_ships ] = [g, parseInt(p), s]

        ships_with_unmet_dependencies = []
        if serialized_ships.length?
            for serialized_ship in serialized_ships.split(ship_splitter)
                unless serialized_ship == ''
                    new_ship = @addShip()
                    if (not new_ship.fromSerialized version, serialized_ship) or not new_ship.pilot # also check, if the pilot has been set (the pilot himself was not invalid)
                        ships_with_unmet_dependencies.push [new_ship, serialized_ship]
            for ship in ships_with_unmet_dependencies
                # 2nd attempt to load ships with unmet dependencies.
                if not ship[0].pilot
                    # create ship, if the ship was so invalid, that it in fact decided to not exist
                    ship[0] = @addShip()
                ship[0].fromSerialized version, ship[1]

    @suppress_automatic_new_ship = false
    # Finally, the unassigned ship

    pilot_splitter = 'X'
    upgrade_splitter = 'W'
    [ pilot_id, upgrade_ids, conferredaddon_pairs ] = serialized.split pilot_splitter
    upgrade_ids = upgrade_ids.split upgrade_splitter
    # set the pilot
    @setPilotById parseInt(pilot_id), true
    # make sure the pilot is valid 
    
    for _ in [1 ... 3] # try adding each upgrade a few times, as the required slots might be added in by titles etc and are not yet available on the first try
        `upgradeloop: //` 
        for i in [upgrade_ids.length - 1 ... -1]
            upgrade_id = upgrade_ids[i]
            upgrade = exportObj.upgradesById[upgrade_id]
            if not upgrade? 
                upgrade_ids.splice(i,1) # Remove unknown or empty ID
                if upgrade_id != ""
                    console.log("Unknown upgrade id " + upgrade_id + " could not be added. Please report that error")
                    everythingadded = false
                continue
            for upgrade_selection in @upgrades
                if upgrade_selection?.data?.name == upgrade.name
                    # for some reason the correct upgrade already was equipped (e.g. an earlier ship alread had a standardized that was added on creation here)
                    upgrade_ids.splice(i,1) # was already added successfully, remove from list
                    `continue upgradeloop`

            for upgrade_selection in @upgrades
                if exportObj.slotsMatching(upgrade.slot, upgrade_selection.slot) and not upgrade_selection.isOccupied()
                    upgrade_selection.setById upgrade_id
                    if upgrade_selection.lastSetValid
                        upgrade_ids.splice(i,1) # added successfully, remove from list
                    break    

    # create the xws json now that ships/pilots have been made
    xws =
        description: "List generated by yasb.app URL"
        faction: this.getParameterByName('f')
        name: this.getParameterByName('sn') ? ""
        pilots: []
        points: desired_points
        vendor:
            yasb:
                builder: 'YASB - X-Wing 2.5'
                builder_url: window.location.href.split('?')[0]
                link: @getPermaLink()
        version: '10/28/2022'
        # there is no point to have this version identifier, if we never actually increase it, right?

    # create xws entry
    for ship in @ships
        if ship.pilot?
            xwsship =
                id: (ship.pilot.xws ? ship.pilot.canonical_name)
                name: (ship.pilot.xws ? ship.pilot.canonical_name) 
                points: ship.getPoints()
                ship: ship.data.name.canonicalize()

            upgrade_obj = {}

            for upgrade in ship.upgrades
                if upgrade?.data?
                    upgrade.toXWS 
                    (upgrade_obj[exportObj.toXWSUpgrade[@data.slot] ? @data.slot.canonicalize()] ?= []).push (@data.xws ? @data.canonical_name)

            if Object.keys(upgrade_obj).length > 0
                xwsship.upgrades = upgrade_obj

            xwsship.pilots.push = xws
    xwsship

exportObj.codeToLanguage ?= {}
exportObj.codeToLanguage.en = 'English'

exportObj.translations ?= {}
# This is here mostly as a template for other languages.
exportObj.translations.English =
    sloticon:
        "Astromech": '<i class="xwing-miniatures-font xwing-miniatures-font-astromech"></i>'
        "Force": '<i class="xwing-miniatures-font xwing-miniatures-font-forcepower"></i>'
        "Bomb": '<i class="xwing-miniatures-font xwing-miniatures-font-bomb"></i>'
        "Cannon": '<i class="xwing-miniatures-font xwing-miniatures-font-cannon"></i>'
        "Crew": '<i class="xwing-miniatures-font xwing-miniatures-font-crew"></i>'
        "Talent": '<i class="xwing-miniatures-font xwing-miniatures-font-talent"></i>'
        "Missile": '<i class="xwing-miniatures-font xwing-miniatures-font-missile"></i>'
        "Sensor": '<i class="xwing-miniatures-font xwing-miniatures-font-sensor"></i>'
        "Torpedo": '<i class="xwing-miniatures-font xwing-miniatures-font-torpedo"></i>'
        "Turret": '<i class="xwing-miniatures-font xwing-miniatures-font-turret"></i>'
        "Illicit": '<i class="xwing-miniatures-font xwing-miniatures-font-illicit"></i>'
        "Configuration": '<i class="xwing-miniatures-font xwing-miniatures-font-config"></i>'
        "Modification": '<i class="xwing-miniatures-font xwing-miniatures-font-modification"></i>'
        "Gunner": '<i class="xwing-miniatures-font xwing-miniatures-font-gunner"></i>'
        "Device": '<i class="xwing-miniatures-font xwing-miniatures-font-device"></i>'
        "Tech": '<i class="xwing-miniatures-font xwing-miniatures-font-tech"></i>'
        "Title": '<i class="xwing-miniatures-font xwing-miniatures-font-title"></i>'
        "Hardpoint": '<i class="xwing-miniatures-font xwing-miniatures-font-hardpoint"></i>'
        "Team": '<i class="xwing-miniatures-font xwing-miniatures-font-team"></i>'
        "Cargo": '<i class="xwing-miniatures-font xwing-miniatures-font-cargo"></i>'
        "Command": '<i class="xwing-miniatures-font xwing-miniatures-font-command"></i>'
        "HardpointShip": '<i class="xwing-miniatures-font xwing-miniatures-font-hardpoint"></i>'
        "VersatileShip": '<i class="xwing-miniatures-font xwing-miniatures-font-hardpoint"></i>'
        "Tactical Relay": '<i class="xwing-miniatures-font xwing-miniatures-font-tacticalrelay"></i>'

    restrictions:
        "Restrictions": "Restrictions"
        "Initiative": "Initiative"
        "Agility": "Agility"
        "Non-Limited": "Non-Limited"
        " or Squad Including": " or Squad Including"
        "Ship": "Ship"
        "Extra": "Extra"

    faction:
        "Rebel Alliance": "Rebel Alliance"
        "Galactic Empire": "Galactic Empire"
        "Scum and Villainy": "Scum and Villainy"
        "Resistance": "Resistance"
        "First Order": "First Order"
        "Galactic Republic": "Galactic Republic"
        "Separatist Alliance": "Separatist Alliance"

    slot:
        "Astromech": "Astromech"
        "Force": "Force"
        "Bomb": "Bomb"
        "Cannon": "Cannon"
        "Crew": "Crew"
        "Missile": "Missile"
        "Sensor": "Sensor"
        "Torpedo": "Torpedo"
        "Turret": "Turret"
        "HardpointShip": "Weapon Hardpoint"
        "VersatileShip": "Versatile Frame"
        "Hardpoint": "Hardpoint"
        "Illicit": "Illicit"
        "Configuration": "Configuration"
        "Talent": "Talent"
        "Modification": "Modification"
        "Gunner": "Gunner"
        "Device": "Payload"
        "Tech": "Tech"
        "Title": "Title"
        "Tactical Relay": "Tactical Relay"
        "Command": "Command"
        "Hyperdrive": "Hyperdrive"
        "Team": "Team"
        "Cargo": "Cargo"


    sources: 
        "Second Edition Core Set": "Second Edition Core Set"
        "Rebel Alliance Conversion Kit": "Rebel Alliance Conversion Kit"
        "Galactic Empire Conversion Kit": "Galactic Empire Conversion Kit"
        "Scum and Villainy Conversion Kit": "Scum and Villainy Conversion Kit"
        "T-65 X-Wing Expansion Pack": "T-65 X-Wing Expansion Pack"
        "BTL-A4 Y-Wing Expansion Pack": "BTL-A4 Y-Wing Expansion Pack"
        "TIE/ln Fighter Expansion Pack": "TIE/ln Fighter Expansion Pack"
        "TIE Advanced x1 Expansion Pack": "TIE Advanced x1 Expansion Pack"
        "Slave 1 Expansion Pack": "Slave 1 Expansion Pack"
        "Fang Fighter Expansion Pack": "Fang Fighter Expansion Pack"
        "Lando's Millennium Falcon Expansion Pack": "Lando's Millennium Falcon Expansion Pack"
        "Saw's Renegades Expansion Pack": "Saw's Renegades Expansion Pack"
        "TIE Reaper Expansion Pack": "TIE Reaper Expansion Pack"
        "ARC-170 Starfighter Expansion": "ARC-170 Starfighter Expansion"
        "Loose Ships": "Loose Ships"
        "Fugitives and Collaborators Squadron Pack": "Fugitives and Collaborators Squadron Pack"
        "First Order Conversion Kit": "First Order Conversion Kit"
        "M3-A Interceptor Expansion Pack": "M3-A Interceptor Expansion Pack"
    ui:
        "shipSelectorPlaceholder": "Select a ship"
        "pilotSelectorPlaceholder": "Select a pilot"
        upgradePlaceholder: (translator, slot) ->
            "No #{translator 'slot', slot} Upgrade"
        "modificationPlaceholder": "No Modification"
        "titlePlaceholder": "No Title"
        upgradeHeader: (translator, slot) ->
            "#{translator 'slot', slot} Upgrade"
        "unreleased": "unreleased"
        "epic": "epic"
        "Quickbuild": "Quick Build"
        "limited": "limited"
        "Unreleased content warning": "This squad uses unreleased content!"
        "Broken squad link warning": "It appears that you followed a broken link. No squad could be loaded!"
        "Collection warning": "You cannot field this list with your collection!"
        "Ship number warning": "A tournament legal squad must contain 3-8 ships!"
        "Multi-Faction warning": "Multi-Faction Lists are NEVER tournament legal!"
        "XWS Import Dialog": "Import your list via XWS into YASB.<br><i>XWS is a common format to share lists between applications.</i>"
        "Copy below simple text": "<p>Copy the below and paste it elsewhere.</p>"
        "Copy below markdown": "<p>Copy the below and paste it into your reddit post.</p><p>Make sure that the post editor is set to markdown mode.</p>"
        "Copy below TTS": "<p>Copy the below and paste it into the Tabletop Simulator.</p>"
        "Copy below BBCode": "<p>Copy the BBCode below and paste it into your forum post.</p>"
        "Copy below HTML": "<p>Copy the below and paste it elsewhere.</p>"
        "Copy below XWS":"<p>Copy and paste this into an XWS-compliant application.</p>"
        "Use INI prefix": "Put INI as prefix in front of names."
        "Choose obstacles dialog": "Choose up to three obstacles, to include in the permalink for use in external programs"
        "Mark obstacles": "Mark the three obstacles you are using."
        "Scan QR-Code": "Scan to open this list in the builder"
        "View in YASB": "View in YASB 2"
        "YASB advertisment": "YASB 2 is a simple, fast, and easy to use squad builder for X-Wing Miniatures by Fantasy Flight Games."
        collectionContentShips: (translator, number) ->
            "You have #{number} ship #{if number == 1 then 'model' else 'models'} in your collection."
        collectionContentShipsAndPilots: (translator, data) -> # data[0] is ships, data[1] is pilots
            "You have #{data[0]} ship #{if data[0] == 1 then 'model' else 'models'} and #{data[1]} pilot #{if data[1] == 1 then 'card' else 'cards'} in your collection."
        collectionContentUpgrades: (translator, number) ->
            "You have #{number} in your collection."
        varPointCostsPoints: (translator, points) ->
            "<b>Point cost:</b> #{points} when "
        varPointCostsConditionAgility: (translator, values) ->
            "agility is #{values}"
        varPointCostsConditionIni: (translator, values) ->
            "initiative is #{values}"
        varPointCostsConditionBase: (translator, values) ->
            "base size is small, medium, large or huge"
        "Missing Item List:": "To field this squad you need the following additional items:" 
        pilotFlyingShip: (translator, pilot, ship) ->
            "Pilot #{pilot} flying #{ship}"
        "Placeholder Textsearch Browser": "Search for name, text or ship"
        noXYselected: (translator, xy) ->
            "No #{translator('ui', xy)} selected"
        "Select a card": "Select a card from the list at the left."
        yourXYsquads: (translator, faction) ->
            "Your #{translator('faction', faction)} Squads"
        reallyDeleteSquadXY: (translator, squadname) -> 
            "Really delete #{squadname}?"
        "No saved squads": "Nothing to see here. Go save a squad!"
        "name required": "A name is required"
        "Name in use": "You already have a squad with that name"
        "select OAuth provider": "Select one of the OAuth providers below to log in and start saving squads."
        "OAuth explanation" : """
                    <p>
                        <a href="http://en.wikipedia.org/wiki/OAuth" target="_blank">OAuth</a> is an authorization system which lets you prove your identity at a web site without having to create a new account.  Instead, you tell some provider with whom you already have an account (e.g. Google or Facebook) to prove to this web site that you say who you are.  That way, the next time you visit, this site remembers that you're that user from Google.
                    </p>
                    <p>
                        The best part about this is that you don't have to come up with a new username and password to remember.  And don't worry, I'm not collecting any data from the providers about you.  I've tried to set the scope of data to be as small as possible, but some places send a bunch of data at minimum.  I throw it away.  All I look at is a unique identifier (usually some giant number).
                    </p>
                    <p>
                        For more information, check out this <a href="http://hueniverse.com/oauth/guide/intro/" target="_blank">introduction to OAuth</a>.
                    </p>
                    """
        "Intro Card YASB": """
                    <h2>YASB for X-Wing 2.5</h2>
                    <p>YASB (Yet Another Squad Builder) is a simple, fast, squad builder for X-Wing Miniatures by <a href="https://www.atomicmassgames.com/">Atomic Mass Games</a>.</p>
                    <p>Current Version: 11/25/2022</p>
                    <h5>Credits</h5>
                    <p>Built upon the amazing original <a href="https://geordanr.github.io/xwing/">Yet Another Squad Builder</a>.</p>
                    <p>YASB is updated and maintained by Stephen Kim.</p>
                    <p>Additional credits to:<br>
                    2.5 Update Data: Devon Monkhouse, Perry Low, Andrew Oehler.<br>
                    2.0 launch data: Evan Cameron, Jonathan Hon, Devon Monkhouse, and Mark Stewart.<br>
                    Translation Team: Patrick Mischke, godgremos, Clément Bourgoin, ManuelWittke, kksuke<br>
                    Site logo: Thomas Kohler<br>
                    Quick Build Support: Patrick Mischke</p>

                    <p>This builder is unofficial and is not affiliated with Atomic Mass Games, Lucasfilm Ltd., or Disney.</p>

                    <p>This site will always be free, and always 100% available for all people to use. However, if you want to donate, a button is prepared for you.</p>
                    <p><button class="btn btn-primary paypal" onclick="window.open('https://paypal.me/raithos');">Donate</button> <button class="btn btn-primary paypal" onclick="window.open('https://www.patreon.com/raithos');">Patreon</button></p>
        """
        "Continue to OAuth provider": "This will open a new window to let you authenticate with the chosen provider. You may have to allow pop ups for this site."
        "iOS requires cross-site control": """Due to a new feature in iOS systems OAuth won't work unless you enable "cross-site control"."""
        "login in progress": "OAuth login is in progress. Please finish authorization at the specified provider using the window that was just created."
        "Squads reloaded": "All squads of that faction have been reloaded."
        "Sure to delete?": "Are you sure you want to delete this squad?"
        "Unsaved Changes Warning": "You have not saved changes to this squad.  Do you want to go back and save?"
        adds: (translator, data) -> # data will most likely be a string of some symbols, but you never know
            "Adds: #{translator('ui', data)}"
        removes: (translator, data) -> # data will most likely be a string of some symbols, but you never know
            "Removes: #{translator('ui', data)}"
        "Less upgrades": "Fewer upgrades"

    singular:
        'pilots': 'Pilot'
        'modifications': 'Modification'
        'titles': 'Title'
        'ships' : 'Ship'
    types:
        'Pilot': 'Pilot'
        'Modification': 'Modification'
        'Title': 'Title'
        'Ship': 'Ship'
    rulestypes:
        'glossary': 'Glossary'
        'faq': 'FAQ'
    action:
        'Boost': 'Boost'

exportObj.cardLoaders ?= {}
exportObj.cardLoaders.English = () ->
    exportObj.cardLanguage = 'English'

    exportObj.renameShip """TIE/ba Interceptor""", """TIE/ba Interceptor"""

    pilot_translations =
        "0-66":
           display_name: """0-66"""
           text: """After you defend, you may spend 1 calculate token to perform an action."""
        "104th Battalion Pilot":
           display_name: """104th Battalion Pilot"""
           text: """<i class = flavor_text>The ARC-170 was designed as a dominating heavy escort fighter with powerful front and rear lasers, ordnance, and an astromech for navigation. Squadrons of these mighty ships bolster the Republic Navy's presence at any battle where they are deployed.</i>"""
        "4-LOM":
           display_name: """4-LOM"""
           text: """After you fully execute a red maneuver, gain 1 calculate token.%LINEBREAK%At the start of the End Phase, you may choose 1 ship at range 0-1. If you do, transfer 1 of your stress tokens to that ship."""
        "Nashtah Pup":
           display_name: """Nashtah Pup"""
           text: """You can deploy only via emergency deployment, and you have the name, initiative, pilot ability, and ship %CHARGE% of the friendly, destroyed <strong>Hound's Tooth</strong>.%LINEBREAK%<strong>Escape Craft:</strong> <strong>Setup:</strong>Requires the <strong>Hound's Tooth</strong>. You <b>must</b> begin the game docked with the <strong>Hound's Tooth</strong>."""
        "AP-5":
           display_name: """AP-5"""
           text: """While you coordinate, if you chose a ship with exactly 1 stress token, it can perform actions. """
        "Academy Pilot":
           display_name: """Academy Pilot"""
           text: """<i class = flavor_text>The Galactic Empire uses the fast and agile TIE/ln, developed by Sienar Fleet Systems and produced in staggering quantity, as its primary starfighter.</i>"""
        "Ahhav":
           display_name: """Ahhav"""
           text: """While you defend or perform an attack, if the enemy ship is a larger size than you, roll 1 additional die."""
        "Ahsoka Tano":
           display_name: """Ahsoka Tano"""
           text: """After you fully execute a maneuver, you may choose a friendly ship at range 0-1 and spend 1 %FORCE%. That ship may perform an action, even if it is stressed."""
        "Ahsoka Tano (Delta-7b)":
           display_name: """Ahsoka Tano"""
           text: """After you fully execute a maneuver, you may choose a friendly ship at range 0-1 and spend 1 %FORCE%. That ship may perform an action, even if it is stressed."""
        "Airen Cracken":
           display_name: """Airen Cracken"""
           text: """After you perform an attack, you may choose 1 friendly ship at range 1. That ship may perform an action, treating it as red."""
        "Alpha Squadron Pilot":
           display_name: """Alpha Squadron Pilot"""
           text: """<i class = flavor_text>Sienar Fleet Systems designed the TIE interceptor with four wing-mounted laser cannons, a dramatic increase in firepower over its predecessors.</i>"""
        "Anakin Skywalker":
           display_name: """Anakin Skywalker"""
           text: """After you fully execute a maneuver, if there is an enemy ship in your %FRONTARC% at range 0-1 or in your %BULLSEYEARC%, you may spend 1 %FORCE% to remove 1 stress token."""
        "Anakin Skywalker (Delta-7b)":
           display_name: """Anakin Skywalker"""
           text: """After you fully execute a maneuver, if there is an enemy ship in your %FRONTARC% at range 0-1 or in your %BULLSEYEARC%, you may spend 1 %FORCE% to remove 1 stress token."""
        "Anakin Skywalker (N-1 Starfighter)":
           text: """Before you reveal your maneuver, you may spend 1 %FORCE% to barrel roll (this is not an action)."""
        "Arvel Crynyd":
           display_name: """Arvel Crynyd"""
           text: """If you would fail a %BOOST% action by overlapping another ship, you may resolve it as though you were partially executing a maneuver instead. While you perform an attack at attack range 0, treat it as an attack at attack range 1. %LINEBREAK%<i>Errata (since rules reference 1.4): Changed the second portion of the ability.</i>"""
        "Asajj Ventress":
           display_name: """Asajj Ventress"""
           text: """At the start of the Engagement Phase, you may choose 1 enemy ship in your %SINGLETURRETARC% at range 0-2 and spend 1 %FORCE%. If you do, that ship gains 1 stress token unless it removes 1 green token."""
        "Autopilot Drone":
           display_name: """Autopilot Drone"""
           text: """<i class = flavor_text>Sometimes, manufacturer's warnings are made to be broken."""
        "Bandit Squadron Pilot":
           display_name: """Bandit Squadron Pilot"""
           text: """<i class = flavor_text>The Z-95 Headhunter was the primary inspiration for Incom Corporation's exemplary T-65 X-wing starfighter. Though it is considered outdated by modern standards, it remains a versatile and potent snub fighter.</i>"""
        "Baktoid Prototype":
           display_name: """Baktoid Prototype"""
           text: """While you perform a special attack, if a friendly ship with the <strong>Networked Calculations</strong> ship ability has a lock on the defender, you may ignore the %FOCUS%, %CALCULATE% or %LOCK% requirement of that attack. """
        "Baron of the Empire":
           display_name: """Baron of the Empire"""
           text: """<i class = flavor_text>Sienar Fleet System's TIE Advanced v1 is a groundbreaking starfighter design, featuring upgraded engines, a missile launcher, and folding s-foils.</i>"""
        "Barriss Offee":
           display_name: """Barriss Offee"""
           text: """While a friendly ship at range 0-2 performs an attack, if the defender is in its %BULLSEYEARC%, you may spend 1 %FORCE% to change 1 %FOCUS% result to a %HIT% result or 1 %HIT% result to a %CRIT% result."""
        "Barriss Offee (Delta-7b)":
           display_name: """Barriss Offee"""
           text: """While a friendly ship at range 0-2 performs an attack, if the defender is in its %BULLSEYEARC%, you may spend 1 %FORCE% to change 1 %FOCUS% result to a %HIT% result or 1 %HIT% result to a %CRIT% result."""
        "Ben Teene":
           display_name: """Ben Teene"""
           text: """After you perform an attack, if the defender is in your %SINGLETURRETARC%, assign the <strong>Rattled</strong> condition to the defender."""
        "Benthic Two Tubes":
           display_name: """Benthic Two Tubes"""
           text: """After you perform a %FOCUS% action, you may transfer 1 of your focus tokens to a friendly ship at range 1-2."""
        "Biggs Darklighter":
           display_name: """Biggs Darklighter"""
           text: """While another friendly ship at range 0-1 defends, before the Neutralize Results step, if you are in the attack arc, you may suffer 1 %HIT% or %CRIT% to cancel 1 matching result."""
        "Binayre Pirate":
           display_name: """Binayre Pirate"""
           text: """<i class = flavor_text>Operating from the Double Worlds, Talus and Tralus, Kath Scarlet's gang of smugglers and pirates would never be described as reputable or dependable—even by other criminals.</i>"""
        "Black Squadron Ace":
           display_name: """Black Squadron Ace"""
           text: """<i class = flavor_text>The elite TIE/ln pilots of Black Squadron accompanied Darth Vader on a devastating strike against the Rebel forces at the Battle of Yavin.</i>"""
        "Black Squadron Scout":
           display_name: """Black Squadron Scout"""
           text: """<i class = flavor_text>These heavily armed atmospheric craft employ their specialized moveable wings to gain additional speed and maneuverability.</i>"""
        "Black Squadron Ace (T-70)":
           display_name: """Black Squadron Ace"""
           text: """<i class = flavor_text>During the Cold War, Poe Dameron's Black Squadron conducted daring covert operations against the First Order in defiance of treaties ratified by the New Republic Senate.</i>"""
        "Black Squadron Scout":
           display_name: """Black Squadron Scout"""
           text: """<i class = flavor_text>These heavily armed atmospheric craft employ their specialized moveable wings to gain additional speed and maneuverability.</i>"""
        "Black Sun Ace":
           display_name: """Black Sun Ace"""
           text: """<i class = flavor_text>The Kihraxz assault fighter was developed specifically for the Black Sun crime syndicate, whose highly paid ace pilots demanded a nimble, powerful ship to match their skills.</i>"""
        "Black Sun Assassin":
           display_name: """Black Sun Assassin"""
           text: """<i class = flavor_text>Although assassinations can be handled with a shot in the dark or a dire substance added to a drink, a flaming shuttle tumbling from the sky sends a special kind of message.</i> """
        "Black Sun Enforcer":
           display_name: """Black Sun Enforcer"""
           text: """<i class = flavor_text>Prince Xizor himself collaborated with MandalMotors to design the StarViper-class attack platform, one of the most formidable starfighters in the galaxy.</i> """
        "Black Sun Soldier":
           display_name: """Black Sun Soldier"""
           text: """<i class = flavor_text>The vast and influential Black Sun crime syndicate can always find a use for talented pilots, provided they aren't particular about how they earn their credits.</i>"""
        "Blade Squadron Veteran":
           display_name: """Blade Squadron Veteran"""
           text: """<i class = flavor_text>A unique gyrostabilization system surrounds the B-wing's cockpit, ensuring that the pilot always remains stationary during flight.</i>"""
        "Blue Squadron Escort":
           display_name: """Blue Squadron Escort"""
           text: """<i class = flavor_text>Designed by Incom Corporation, the T-65 X-wing quickly proved to be one of the most effective and versatile military vehicles in the galaxy and a boon to the Rebellion.</i>"""
        "Blue Squadron Pilot":
           display_name: """Blue Squadron Pilot"""
           text: """<i class = flavor_text>Due to its heavy weapons array and resilient shielding, the B-wing has solidified itself as the Rebel Alliance's most innovative assault fighter.</i>"""
        "Blue Squadron Protector":
           display_name: """Blue Squadron Protector"""
           text: """<i class = flavor_text>Blue Squadron's elite clone pilots are trained to fly their V-19s in conjunction with Jedi and often support famous commanders such as Anakin Skywalker and Ahsoka Tano.</i>"""
        "Blue Squadron Recruit":
           display_name: """Blue Squadron Recruit"""
           text: """<i class = flavor_text>Young beings across the galaxy have grown up on tales of heroism in the Galactic Civil War, and many learned to fly in the same cockpits from which their parents fought the Empire.</i>"""
        "Blue Squadron Rookie":
           display_name: """Blue Squadron Rookie"""
           text: """<i class = flavor_text>The Incom-FreiTek T-70 X-Wing was designed to improve upon the tactical flexibility of the venerable T-65. The starfighter's advanced droid socket is compatible with a wide array of astromechs, and its modular weapons pods allow ground crews to tailor its payload for specific missions.</i>"""
        "Blue Squadron Scout":
           display_name: """Blue Squadron Scout"""
           text: """<i class = flavor_text>Used for deploying troops under the cover of darkness or into the heat of battle, the UT-60D U-wing fulfills the Rebellion's need for a swift and hardy troop transport.</i>"""
        "Boba Fett":
           display_name: """Boba Fett"""
           text: """While you defend or perform an attack, you may reroll 1 of your dice for each enemy ship at range 0-1."""
        "Bodhi Rook":
           display_name: """Bodhi Rook"""
           text: """Friendly ships can acquire locks onto objects at range 0-3 of any friendly ship."""
        "Bossk":
           display_name: """Bossk"""
           text: """While you perform a primary attack, after the Neutralize Results step, you may spend 1 %CRIT% result to add 2 %HIT% results."""
        "Bounty Hunter":
           display_name: """Bounty Hunter"""
           text: """<i class = flavor_text>The Firespray-class patrol craft is infamous for its association with the deadly bounty hunters Jango Fett and Boba Fett, who packed their craft with countless deadly armaments.</i>"""
        "Braylen Stramm":
           display_name: """Braylen Stramm"""
           text: """While you defend or perform an attack, if you are stressed, you may reroll up to 2 of your dice."""
        "Captain Cardinal":
           display_name: """Captain Cardinal"""
           text: """While a friendly ship at range 1-2 with lower initiative than you defends or performs an attack, if you have at least 1 %CHARGE%, that ship may reroll 1 %FOCUS% result.%LINEBREAK%After an enemy ship at range 0-3 is destroyed, lose 1 %CHARGE%."""
        "Captain Feroph":
           display_name: """Captain Feroph"""
           text: """While you defend, if the attacker does not have any green tokens, you may change 1 of your blank or %FOCUS% results to an %EVADE% result."""
        "Captain Jonus":
           display_name: """Captain Jonus"""
           text: """While a friendly ship at range 0-1 performs a %TORPEDO% or %MISSILE% attack, that ship may reroll up to 2 attack dice. """
        "Captain Jostero":
           display_name: """Captain Jostero"""
           text: """After an enemy ship suffers damage, if it is not defending, you may perform a bonus attack against that ship."""
        "Captain Kagi":
           display_name: """Captain Kagi"""
           text: """At the start of the Engagement Phase, you may choose 1 or more friendly ships at range 0-3. If you do, transfer all enemy lock tokens from the chosen ships to you."""
        "Captain Nym":
           display_name: """Captain Nym"""
           text: """Before a friendly bomb or mine would detonate, you may spend 1 %CHARGE% to prevent it from detonating.%LINEBREAK% While you defend against an attack obstructed by a bomb or mine, roll 1 additional defense die."""
        "Captain Oicunn":
           display_name: """Captain Oicunn"""
           text: """While you perform an attack at attack range 0, treat it as an attack at attack range 1. %LINEBREAK%<i>Errata (since rules reference 1.4): Ability changed to work in new core rules</i>"""
        "Captain Rex":
           display_name: """Captain Rex"""
           text: """After you perform an attack, assign the <strong>Suppressive Fire</strong> condition to the defender."""
        "Captain Sear":
           display_name: """Captain Sear"""
           text: """While a friendly ship at range 0-3 performs a primary attack, if the defender is in its %BULLSEYEARC%, before the Neutralize Results step, the friendly ship may spend 1 calculate token to cancel 1 %EVADE% result."""
        "Captain Seevor":
           display_name: """Captain Seevor"""
           text: """While you defend or perform an attack, before attack dice are rolled, if you are not in the enemy ship's %BULLSEYEARC%, you may spend 1 %CHARGE%. If you do, the enemy ship gains 1 jam token."""
        "Cartel Executioner":
           display_name: """Cartel Executioner"""
           text: """<i class = flavor_text>Many veteran pilots in the service of the Hutt kajidics and other criminal operations choose the M12-L Kimogila for its firepower and dreaded reputation alike.</i>"""
        "Cartel Marauder":
           display_name: """Cartel Marauder"""
           text: """<i class = flavor_text>The versatile Kihraxz was modeled after Incom's popular X-wing starfighter, but an array of after-market modification kits ensure a wide variety of designs. </i>"""
        "Cartel Spacer":
           display_name: """Cartel Spacer"""
           text: """<i class = flavor_text>MandalMotors' M3-A “Scyk” Interceptor is purchased in large quantities by the Hutt Cartel and the Car'das smugglers due to its low cost and customizability.</i> """
        "Cassian Andor":
           display_name: """Cassian Andor"""
           text: """At the start of the Activation Phase, you may choose 1 friendly ship at range 1-3. If you do, that ship removes 1 stress token."""
        "Cat":
           display_name: """Cat"""
           text: """While you perform a primary attack, if the defender is at range 0-1 of at least 1 friendly device, roll 1 additional die."""
        "Cavern Angels Zealot":
           display_name: """Cavern Angels Zealot"""
           text: """<i class = flavor_text>Unlike most Rebel cells, Saw Gerrera's partisans are willing to use extreme methods to undermine the Galactic Empire's objectives in brutal battles that rage from Geonosis to Jedha.</i>"""
        "Chewbacca":
           display_name: """Chewbacca"""
           text: """Before you would be dealt a faceup damage card, you may spend 1 %CHARGE% to be dealt the card facedown instead."""
        "Chewbacca (Resistance)":
           display_name: """Chewbacca"""
           text: """After a friendly ship at range 0-3 is destroyed, before that ship is removed, you may perform an action. Then you may perform a bonus attack.%LINEBREAK%<i><strong>Note:</strong>The phrase "before that ship is removed" is not printed on the card, but within the official squad builder.</i>"""
        "Cobalt Squadron Bomber":
           display_name: """Cobalt Squadron Bomber"""
           text: """<i class = flavor_text>Whether the ordnance silos of their StarFortresses are loaded with proton bombs or relief supplies, the heroic crews of Cobalt Squadron dedicate their lives to making a difference in the galaxy.</i>"""
        "Colonel Jendon":
           display_name: """Colonel Jendon"""
           text: """At the start of the Activation Phase, you may spend 1 %CHARGE%. If you do, while friendly ships acquire locks this round, they must acquire locks beyond range 3 instead of at range 0-3."""
        "Colonel Vessery":
           display_name: """Colonel Vessery"""
           text: """While you perform an attack against a locked ship, after you roll attack dice, you may acquire a lock on the defender."""
        "Commander Malarus":
           display_name: """Commander Malarus"""
           text: """At the start of the Engagement Phase, you may spend 1 %CHARGE% and gain 1 stress token. If you do, until the end of the round, while you defend or perform an attack, you may change all of your %FOCUS% results to %EVADE% or %HIT% results."""
        "Constable Zuvio":
           display_name: """Constable Zuvio"""
           text: """If you would drop a device, you may launch it using a [1 %STRAIGHT%] template instead."""
        "Contracted Scout":
           display_name: """Contracted Scout"""
           text: """<i class = flavor_text>Built for long-distance reconnaissance and plotting new hyperspace routes, the lightly armed JumpMaster 5000 is often extensively retrofitted with custom upgrades.</i>"""
        "Corran Horn":
           display_name: """Corran Horn"""
           text: """At initiative 0, you may perform a bonus primary attack against an enemy ship in your %BULLSEYEARC%. If you do, at the start of the next Planning Phase, gain 1 disarm token."""
        "Count Dooku":
           display_name: """Count Dooku"""
           text: """After you defend, if the attacker is in your firing arc, you may spend 1 %FORCE% to remove 1 of your blue or red tokens.%LINEBREAK%After you perform an attack that hits, you may spend 1 %FORCE% to perform an action."""
        "Countess Ryad":
           display_name: """Countess Ryad"""
           text: """While you would execute a %STRAIGHT% maneuver, you may increase the difficulty of the maneuver. If you do, execute it as a %KTURN% maneuver instead."""
        "Crymorah Goon":
           display_name: """Crymorah Goon"""
           text: """<i class = flavor_text>Though far from nimble, the Y-wing's heavy hull, substantial shielding, and turret-mounted cannons make it an excellent patrol craft.</i>"""
        "Cutlass Squadron Pilot":
           display_name: """Cutlass Squadron Pilot"""
           text: """<i class = flavor_text>The TIE punisher's design builds upon the success of the TIE bomber, adding shielding, a second bomb chute, and three additional ordnance pods, each equipped with a twin ion engine.</i>"""
        "DBS-32C":
           display_name: """DBS-32C"""
           text: """At the start of the Engagement Phase, you may spend 1 calculate token to perform a %COORDINATE% action. You cannot coordinate ships that do not have the <strong>Networked Calculations</strong> ship ability. """
        "DBS-404":
           display_name: """DBS-404"""
           text: """While you perform an attack at attack range 1, you <strong>must</strong> roll 1 additional die. After the attack hits, suffer 1 %CRIT% damage.  %LINEBREAK%<i>Errata (since rules reference 1.4): Changed the range restriction on this ability"</i>"""
        "DFS-081":
           display_name: """DFS-081"""
           text: """While a friendly ship at range 0-1 defends, it may spend 1 calculate token to change all %CRIT% results to %HIT% results."""
        "DFS-311":
           display_name: """DFS-311"""
           text: """At the start of the Engagement Phase, you may transfer 1 of your calculate tokens to another friendly ship at range 0-3."""
        "Dace Bonearm":
           display_name: """Dace Bonearm"""
           text: """After an enemy ship at range 0-3 receives at least 1 ion token, you may spend 3 %CHARGE%. If you do, that ship gains 2 additional ion tokens."""
        "Dalan Oberos (StarViper)":
           display_name: """Dalan Oberos"""
           text: """After you fully execute a maneuver, you may gain 1 stress token to rotate your ship 90º."""
        "Dalan Oberos":
           display_name: """Dalan Oberos"""
           text: """At the start of the Engagement Phase, you may choose 1 shielded ship in your %BULLSEYEARC% and spend 1 %CHARGE%. If you do, that ship loses 1 shield and you recover 1 shield."""
        "Dark Courier":
           display_name: """Dark Courier"""
           text: """<i class = flavor_text>The vessel called the Scimitar was heavily modified, equipped with stealth technologies and advanced surveillance devices for infiltration and assassination missions.</i>"""
        "Darth Maul":
           display_name: """Darth Maul"""
           text: """After you perform an attack, you may spend 2 %FORCE% to perform a bonus primary attack against a different target. If your attack missed, you may perform that bonus primary attack against the same target instead."""
        "Darth Vader":
           display_name: """Darth Vader"""
           text: """After you perform an action, you may spend 1 %FORCE% to perform an action."""
        "Dash Rendar":
           display_name: """Dash Rendar"""
           text: """While you move, you ignore obstacles."""
        "Del Meeko":
           display_name: """Del Meeko"""
           text: """While a friendly ship at range 0-2 defends against a damaged attacker, the defender may reroll 1 defense die."""
        "Delta Squadron Pilot":
           display_name: """Delta Squadron Pilot"""
           text: """<i class = flavor_text>In addition to its missile launchers and six wingtip laser cannons, the formidable TIE defender is equipped with deflector shields and a hyperdrive.</i>"""
        "Dengar":
           display_name: """Dengar"""
           text: """After you defend, if the attacker is in your %FRONTARC%, you may spend 1 %CHARGE% to perform a bonus attack against the attacker."""
        "Drea Renthal":
           display_name: """Drea Renthal"""
           text: """While a friendly non-limited ship performs an attack, if the defender is in your firing arc, the attacker may reroll 1 attack die."""
        "Edon Kappehl":
           display_name: """Edon Kappehl"""
           text: """After you fully execute a blue or white maneuver, if you have not dropped or launched a device this round, you may drop 1 device."""
        "Edrio Two Tubes":
           display_name: """Edrio Two Tubes"""
           text: """Before you activate, if you are focused, you may perform an action."""
        "Ello Asty":
           display_name: """Ello Asty"""
           text: """After you reveal a red Tallon Roll [%TROLLLEFT% or %TROLLRIGHT%] maneuver, if you have 2 or fewer stress tokens, treat that maneuver as white."""
        "Emon Azzameen":
           display_name: """Emon Azzameen"""
           text: """If you would drop a device using a [1 %STRAIGHT%] template, you may use the [3 %TURNLEFT%], [3 %STRAIGHT%], or [3 %TURNRIGHT%] template instead."""
        "Epsilon Squadron Cadet":
           display_name: """Epsilon Squadron Cadet"""
           text: """<i class = flavor_text>Trained from childhood aboard Resurgent-class Star Destroyers in deep space, many First Order TIE pilots have never even set foot on a planet's surface.</i>"""
        "Esege Tuketu":
           display_name: """Esege Tuketu"""
           text: """While a friendly ship at range 0-2 defends or performs an attack, it may spend your focus tokens as if that ship has them."""
        "Evaan Verlaine":
           display_name: """Evaan Verlaine"""
           text: """At the start of the Engagement Phase, you may spend 1 focus token to choose a friendly ship at range 0-1. If you do, that ship rolls 1 additional defense die while defending until the end of the round."""
        "Ezra Bridger":
           display_name: """Ezra Bridger"""
           text: """While you defend or perform an attack, if you are stressed, you may spend 1 %FORCE% to change up to 2 of your %FOCUS% results to %EVADE% or %HIT% results."""
        "Ezra Bridger (Sheathipede)":
           display_name: """Ezra Bridger"""
           text: """While you defend or perform an attack, if you are stressed, you may spend 1 %FORCE% to change up to 2 of your %FOCUS% results to %EVADE% /%HIT% results. """
        "Ezra Bridger (TIE Fighter)":
           display_name: """Ezra Bridger"""
           text: """While you defend or perform an attack, if you are stressed, you may spend 1 %FORCE% to change up to 2 of your %FOCUS% results to %EVADE% or %HIT% results."""
        "Feethan Ottraw Autopilot":
           display_name: """Feethan Ottraw Autopilot"""
           text: """<i class = flavor_text>Unlike the more disposable fighters it also built for the Separatists, Feethan Ottraw Scalable Assemblies designed the Belbullab-22 with a solid mix of firepower, durability, and speed.</i>"""
        "Fenn Rau (Sheathipede)":
           display_name: """Fenn Rau"""
           text: """Before an enemy ship in your firing arc engages, if you are not stressed, you may gain 1 stress token. If you do, that ship cannot spend tokens to modify dice while it performs an attack during this phase. %LINEBREAK% <i>Errata (since rules reference 1.1.0): Replaced "After an enemy ship in your firing arc engages")</i>"""
        "Fenn Rau":
           display_name: """Fenn Rau"""
           text: """While you defend or perform an attack, if the attack range is 1, you may roll 1 additional die."""
        "Finch Dallow":
           display_name: """Finch Dallow"""
           text: """Before you would drop a bomb, you may place it in the play area touching you instead."""
        "First Order Test Pilot":
           display_name: """First Order Test Pilot"""
           text: """<i class = flavor_text>Engineered for incredible speed and precise handling, the TIE Silencer is devastating in the hands of those who can unlock its full potential. Any lesser pilot could easily be overwhelmed and lose control of the nimble craft. </i>"""
        "Foreman Proach":
           display_name: """Foreman Proach"""
           text: """Before you engage, you may choose 1 enemy ship in your %BULLSEYEARC% at range 1-2 and gain 1 disarm token. If you do, that ship gains 1 tractor token."""
        "Freighter Captain":
           display_name: """Freighter Captain"""
           text: """<i class = flavor_text>Many spacers make a living traveling the Outer Rim, where the difference between smuggler and legitimate merchant is often murky. On the outskirts of civilization, buyers are rarely so discerning to ask where merchandise came from, at least as long as the price is low enough.</i>"""
        "Gamma Squadron Ace":
           display_name: """Gamma Squadron Ace"""
           text: """<i class = flavor_text>Though it sacrifices a degree of speed and maneuverability compared to a TIE/ln, the TIE bomber's increased payload can carry enough firepower to destroy virtually any enemy target.</i> """
        "Gand Findsman":
           display_name: """Gand Findsman"""
           text: """<i class = flavor_text>The legendary Findsmen of Gand worship the enshrouding mists of their home planet, using signs, augurs, and mystical rituals to track their quarry.</i>"""
        "Garven Dreis (X-Wing)":
           display_name: """Garven Dreis"""
           text: """After you spend a focus token, you may choose 1 friendly ship at range 1-3. That ship gains 1 focus token."""
        "Garven Dreis":
           display_name: """Garven Dreis"""
           text: """After you spend a focus token, you may choose 1 friendly ship at range 1-3. That ship gains 1 focus token."""
        "Gavin Darklighter":
           display_name: """Gavin Darklighter"""
           text: """While a friendly ship performs an attack, if the defender is in your %FRONTARC%, the attacker may change 1 %HIT% result to a %CRIT% result."""
        "General Grievous":
           display_name: """General Grievous"""
           text: """While you perform a primary attack, if you are not in the defender's firing arc, you may reroll up to 2 attack dice."""
        "Genesis Red":
           display_name: """Genesis Red"""
           text: """After you acquire a lock, you must remove all of your focus and evade tokens. Then, gain the same number of focus and evade tokens that the locked ship has."""
        "Gideon Hask":
           display_name: """Gideon Hask"""
           text: """While you perform an attack against a damaged defender, roll 1 additional attack die."""
        "Gold Squadron Trooper":
           display_name: """Gold Squadron Trooper"""
           text: """<i class = flavor_text>The V-19 Torrent starfighter was designed to be a light escort to nimble Delta-7 interceptors flown by Jedi Knights, and has a unique flight profile to reflect this role.</i>"""
        "Gold Squadron Veteran":
           display_name: """Gold Squadron Veteran"""
           text: """<i class = flavor_text>Commanded by Jon “Dutch” Vander, Gold Squadron played an instrumental role in the Battles of Scarif and Yavin.</i>"""
        "Grand Inquisitor":
           display_name: """Grand Inquisitor"""
           text: """While you defend at attack range 1, you may spend 1 %FORCE% to prevent the range 1 bonus. %LINEBREAK%While you perform an attack against a defender at attack range 2-3, you may spend 1 %FORCE% to apply the range 1 bonus."""
        "Gray Squadron Bomber":
           display_name: """Gray Squadron Bomber"""
           text: """<i class = flavor_text>Long after the Y-wing was phased out by the Galactic Empire, its durability, dependability, and heavy armament help it remain a staple in the Rebel fleet.</i>"""
        "Graz":
           display_name: """Graz"""
           text: """While you defend, if you are behind the attacker, roll 1 additional defense die.%LINEBREAK%While you perform an attack, if you are behind the defender, roll 1 additional attack die."""
        "Green Squadron Expert":
           display_name: """Green Squadron Expert"""
           text: """<i class = flavor_text>Years of field-expedient modifications were standardized in the RZ-2 design, but daring pilots see the ship's improved reliability as a challenge to further push the limits of its performance.</i>"""
        "Green Squadron Pilot":
           display_name: """Green Squadron Pilot"""
           text: """<i class = flavor_text>Due to its sensitive controls and high maneuverability, only the most talented pilots belong in an A-wing cockpit.</i>"""
        "Greer Sonnel":
           display_name: """Greer Sonnel"""
           text: """After you fully execute a maneuver, you may rotate your %SINGLETURRETARC%."""
        "Guri":
           display_name: """Guri"""
           text: """At the start of the Engagement Phase, if there is at least 1 enemy ship at range 0-1, you may gain 1 focus token."""
        "Han Solo":
           display_name: """Han Solo"""
           text: """After you roll dice, if you are at range 0-1 of an obstacle, you may reroll all of your dice. This does not count as rerolling for the purpose of other effects."""
        "Han Solo (Scum)":
           display_name: """Han Solo"""
           text: """While you defend or perform a primary attack, if the attack is obstructed by an obstacle, you may roll 1 additional die."""
        "Han Solo (Resistance)":
           display_name: """Han Solo"""
           text: """<strong>Setup:</strong> You can be placed anywhere in the play area beyond range 3 of enemy ships."""
        "Heff Tobber":
           display_name: """Heff Tobber"""
           text: """After an enemy ship executes a maneuver, if it is at range 0, you may perform an action."""
        "Hera Syndulla":
           display_name: """Hera Syndulla"""
           text: """After you reveal a red or blue maneuver, you may set your dial to another maneuver of the same difficulty."""
        "Hera Syndulla (VCX-100)":
           display_name: """Hera Syndulla"""
           text: """After you reveal a red or blue maneuver, you may set your dial to another maneuver of the same difficulty."""
        "Hired Gun":
           display_name: """Hired Gun"""
           text: """<i class = flavor_text>Just the mention of Imperial credits can bring a host of less-than-trustworthy individuals to your side.</i>"""
        "Horton Salm":
           display_name: """Horton Salm"""
           text: """While you perform an attack, you may reroll 1 attack die for each other friendly ship at range 0-1 of the defender."""
        "IG-88A":
           display_name: """IG-88A"""
           text: """At the start of the Engagement Phase, you may choose 1 friendly ship with %CALCULATE% on its action bar at range 1-3. If you do, transfer 1 of your calculate tokens to it. """
        "IG-88B":
           display_name: """IG-88B"""
           text: """After you perform an attack that misses, you may perform a bonus %CANNON% attack."""
        "IG-88C":
           display_name: """IG-88C"""
           text: """After you perform a %BOOST% action, you may perform an %EVADE% action."""
        "IG-88D":
           display_name: """IG-88D"""
           text: """While you execute a Segnor's Loop (%SLOOPLEFT% or %SLOOPRIGHT%) maneuver, you may use another template of the same speed instead: either the turn (%TURNLEFT% or %TURNRIGHT%) of the same direction or the straight (%STRAIGHT%) template."""
        "Ibtisam":
           display_name: """Ibtisam"""
           text: """After you fully execute a maneuver, if you are stressed, you may roll 1 attack die. On a %HIT% or %CRIT% result, remove 1 stress token."""
        "Iden Versio":
           display_name: """Iden Versio"""
           text: """Before a friendly TIE/ln fighter at range 0-1 would suffer 1 or more damage, you may spend 1 %CHARGE%. If you do, prevent that damage."""
        "Imdaar Test Pilot":
           display_name: """Imdaar Test Pilot"""
           text: """<i class = flavor_text>The primary result of a hidden research facility on Imdaar Alpha, the TIE phantom achieves what many thought was impossible: a small starfighter equipped with an advanced cloaking device.</i>"""
        "Inaldra":
           display_name: """Inaldra"""
           text: """While you defend or perform an attack, you may suffer 1 %HIT% damage to reroll any number of your dice. """
        "Inquisitor":
           display_name: """Inquisitor"""
           text: """<i class = flavor_text>The fearsome Inquisitors are given a great deal of autonomy and access to the Empire's latest technology, like the prototype TIE Advanced v1.</i>"""
        "Jake Farrell":
           display_name: """Jake Farrell"""
           text: """After you perform a %BARRELROLL% or %BOOST% action, you may choose a friendly ship at range 0-1. That ship may perform a %FOCUS% action."""
        "Jakku Gunrunner":
           display_name: """Jakku Gunrunner"""
           text: """<i class = flavor_text>The Quadrijet transfer spacetug, commonly called a "Quadjumper," is nimble in space and atmosphere alike, making it popular among both smugglers and explorers.</i> """
        "Jan Ors":
           display_name: """Jan Ors"""
           text: """While a friendly ship in your firing arc performs a primary attack, if you are not stressed, you may gain 1 stress token. If you do, that ship may roll 1 additional attack die."""
        "Jaycris Tubbs":
           display_name: """Jaycris Tubbs"""
           text: """After you fully execute a blue maneuver, you may choose a friendly ship at range 0-1. If you do, that ship removes 1 stress token."""
        "Jedi Knight":
           display_name: """Jedi Knight"""
           text: """<i class = flavor_text>When the Clone Wars began, the Jedi Knights rallied to the cause of preserving the Republic, assuming command of legions of clone troopers and leading them in battle.</i>"""
        "Jedi Knight (Delta-7b)":
           display_name: """Jedi Knight"""
           text: """<i class = flavor_text>When the Clone Wars began, the Jedi Knights rallied to the cause of preserving the Republic, assuming command of legions of clone troopers and leading them in battle.</i>"""
        "Jek Porkins":
           display_name: """Jek Porkins"""
           text: """After you receive a stress token, you may roll 1 attack die to remove it. On a %HIT% result, suffer 1 %HIT% damage."""
        "Jessika Pava":
           display_name: """Jessika Pava"""
           text: """While you defend or perform an attack, you may spend 1 %CHARGE% or 1 non-recurring %CHARGE% from your equipped %ASTROMECH% upgrade to reroll up to 1 of your dice for each other friendly ship at range 0-1."""
        "Joph Seastriker":
           display_name: """Joph Seastriker"""
           text: """After you lose 1 shield, gain 1 evade token."""
        "Joy Rekkoff":
           display_name: """Joy Rekkoff"""
           text: """While you perform an attack, you may spend 1 %CHARGE% from an equipped %TORPEDO% upgrade. If you do, the defender rolls 1 fewer defense die."""
        "Kaa'to Leeachos":
           display_name: """Kaa'to Leeachos"""
           text: """At the start of the Engagement Phase, you may choose 1 friendly ship at range 0-2. If you do, transfer 1 focus or evade token from that ship to yourself. """
        "Kad Solus":
           display_name: """Kad Solus"""
           text: """After you fully execute a red maneuver, gain 2 focus tokens."""
        "Kanan Jarrus":
           display_name: """Kanan Jarrus"""
           text: """While a friendly ship in your firing arc defends, you may spend 1 %FORCE%. If you do, the attacker rolls 1 fewer attack die."""
        "Kare Kun":
           display_name: """Kare Kun"""
           text: """While you boost, you may use the [1 %TURNLEFT%] or [1 %TURNRIGHT%] template instead."""
        "Kashyyyk Defender":
           display_name: """Kashyyyk Defender"""
           text: """<i class = flavor_text>Equipped with three wide-range Sureggi twin laser cannons, the Auzituck gunship acts as a powerful deterrent to slaver operations in the Kashyyyk system.</i>"""
        "Kath Scarlet":
           display_name: """Kath Scarlet"""
           text: """While you perform a primary attack, if there is at least 1 friendly non-limited ship at range 0 of the defender, roll 1 additional attack die."""
        "Kavil":
           display_name: """Kavil"""
           text: """While you perform a non-%FRONTARC% attack, roll 1 additional attack die."""
        "Ketsu Onyo":
           display_name: """Ketsu Onyo"""
           text: """At the start of the Engagement Phase, you may choose 1 ship in both your %FRONTARC% and %SINGLETURRETARC% at range 0-1. If you do, it gains 1 tractor token."""
        "Knave Squadron Escort":
           display_name: """Knave Squadron Escort"""
           text: """<i class = flavor_text>Designed to combine the best features of the X-wing series with the A-wing series, the E-wing boasts superior firepower, speed, and maneuverability.</i>"""
        "Koshka Frost":
           display_name: """Koshka Frost"""
           text: """While you defend or perform an attack, if the enemy ship is stressed, you may reroll 1 of your dice."""
        "Krassis Trelix":
           display_name: """Krassis Trelix"""
           text: """You can perform %FRONTARC% special attacks from your %REARARC%.%LINEBREAK%While you perform a special attack, you may reroll 1 attack die."""
        "Kullbee Sperado":
           display_name: """Kullbee Sperado"""
           text: """After you perform a %BARRELROLL% or %BOOST% action, you may flip your equipped %CONFIGURATION% upgrade card."""
        "Kyle Katarn":
           display_name: """Kyle Katarn"""
           text: """At the start of the Engagement Phase, you may transfer 1 of your focus tokens to a friendly ship in your firing arc."""
        "Kylo Ren":
           display_name: """Kylo Ren"""
           text: """After you defend, you may spend 1 %FORCE% to assign the <strong>I'll Show You the Dark Side</strong> condition to the attacker."""
        "L3-37":
           display_name: """L3-37"""
           text: """If you are not shielded, decrease the difficulty of your bank (%BANKLEFT% and %BANKRIGHT%) maneuvers."""
        "L3-37 (Escape Craft)":
           display_name: """L3-37"""
           text: """If you are not shielded, decrease the difficulty of your bank (%BANKLEFT% and %BANKRIGHT%) maneuvers."""
        "Laetin A'shera":
           display_name: """Laetin A'shera"""
           text: """After you defend or perform an attack, if the attack missed, gain 1 evade token."""
        "Lando Calrissian":
           display_name: """Lando Calrissian"""
           text: """After you fully execute a blue maneuver, you may choose a friendly ship at range 0-3. That ship may perform an action."""
        "Lando Calrissian (Scum)":
           display_name: """Lando Calrissian"""
           text: """After you roll dice, if you are not stressed, you may gain 1 stress token to reroll all of your blank results."""
        "Lando Calrissian (Scum) (Escape Craft)":
           display_name: """Lando Calrissian"""
           text: """After you roll dice, if you are not stressed, you may gain 1 stress token to reroll all of your blank results."""
        "Latts Razzi":
           display_name: """Latts Razzi"""
           text: """At the start of the Engagement Phase, you may choose a ship at range 1 and spend a lock you have on that ship. If you do, that ship gains 1 tractor token."""
        "Leevan Tenza":
           display_name: """Leevan Tenza"""
           text: """After you perform a %BARRELROLL% or %BOOST% action, you may perform a red %EVADE% action."""
        "Lieutenant Bastian":
           display_name: """Lieutenant Bastian"""
           text: """After a ship at range 1-2 is dealt a damage card, you may acquire a lock on that ship."""
        "Lieutenant Blount":
           display_name: """Lieutenant Blount"""
           text: """While you perform a primary attack, if there is at least 1 other friendly ship at range 0-1 of the defender, you may roll 1 additional attack die."""
        "Lieutenant Dormitz":
           display_name: """Lieutenant Dormitz"""
           text: """<strong>Setup</strong>: After you are placed, other friendly small ships can be placed anywhere in the play area at range 0-2 of you. %LINEBREAK% <i>Errata (since rules reference 1.3.0): Replaced "other friendly ship" with "friendly small ships"</i>"""
        "Lieutenant Karsabi":
           display_name: """Lieutenant Karsabi"""
           text: """After you gain a disarm token, if you are not stressed, you may gain 1 stress token to remove 1 disarm token."""
        "Lieutenant Kestal":
           display_name: """Lieutenant Kestal"""
           text: """While you perform an attack, after the defender rolls defense dice, you may spend 1 focus token to cancel all of the defender's blank/%FOCUS% results."""
        "Lieutenant Rivas":
           display_name: """Lieutenant Rivas"""
           text: """After a ship at range 1-2 gains a red or orange token, if you do not have that ship locked, you may acquire a lock on that ship."""
        "Lieutenant Sai":
           display_name: """Lieutenant Sai"""
           text: """After you a perform a %COORDINATE% action, if the ship you chose performed an action on your action bar, you may perform that action."""
        "Lieutenant Tavson":
           display_name: """Lieutenant Tavson"""
           text: """After you suffer damage, you may spend 1 %CHARGE% to perform an action."""
        "Lok Revenant":
           display_name: """Lok Revenant"""
           text: """<i class = flavor_text>The Nubian Design Collective crafted the Scurrg H-6 Bomber with combat versatility in mind, arming it with powerful shields and a bristling array of destructive weaponry.</i>"""
        "Lothal Rebel":
           display_name: """Lothal Rebel"""
           text: """<i class = flavor_text>Another successful Corellian Engineering Corporation freighter design, the VCX-100 is larger than the ubiquitous YT-series, boasting more living space and customizability.</i>"""
        "Lowhhrick":
           display_name: """Lowhhrick"""
           text: """After a friendly ship at range 0-1 becomes the defender, you may spend 1 reinforce token. If you do, that ship gains 1 evade token."""
        "Luke Skywalker":
           display_name: """Luke Skywalker"""
           text: """After you become the defender (before dice are rolled), you may recover 1 %FORCE%."""
        "Luminara Unduli":
           display_name: """Luminara Unduli"""
           text: """While a friendly ship at range 0-2 defends, if it is not in the attacker's %BULLSEYEARC%, you may spend 1 %FORCE%. If you do, change 1 %CRIT% result to a %HIT% result or 1 %HIT% result to a %FOCUS% result."""
        "Luminara Unduli (Delta-7b)":
           display_name: """Luminara Unduli"""
           text: """While a friendly ship at range 0-2 defends, if it is not in the attacker's %BULLSEYEARC%, you may spend 1 %FORCE%. If you do, change 1 %CRIT% result to a %HIT% result or 1 %HIT% result to a %FOCUS% result."""
        "L'ulo L'ampar":
           display_name: """L'ulo L'ampar"""
           text: """While you defend or perform a primary attack, if you are stressed, you <b>must</b> roll 1 fewer defense die or 1 additional attack die."""
        "Maarek Stele":
           display_name: """Maarek Stele"""
           text: """While you perform an attack, if the defender would be dealt a faceup damage card, instead draw 3 damage cards, choose 1, and discard the rest. """
        "Mace Windu":
           display_name: """Mace Windu"""
           text: """After you fully execute a red maneuver, recover 1 %FORCE%."""
        "Mace Windu (Delta-7b)":
           display_name: """Mace Windu"""
           text: """After you fully execute a red maneuver, recover 1 %FORCE%."""
        "Magva Yarro":
           display_name: """Magva Yarro"""
           text: """While a friendly ship at range 0-2 defends, the attacker cannot reroll more than 1 attack die."""
        "Major Rhymer":
           display_name: """Major Rhymer"""
           text: """While you perform a %TORPEDO% or %MISSILE% attack, you may increase or decrease the range requirement by 1, to a limit of 0-3. """
        "Major Stridan":
           display_name: """Major Stridan"""
           text: """While you coordinate or resolve the effect of one of your upgrades, you may treat friendly ships at range 2-3 as being at range 0 or range 1."""
        "Major Vermeil":
           display_name: """Major Vermeil"""
           text: """While you perform an attack, if the defender does not have any green tokens, you may change 1 of your blank or %FOCUS% results to a %HIT% result."""
        "Major Vynder":
           display_name: """Major Vynder"""
           text: """While you defend, if you are disarmed, roll 1 additional defense die."""
        "Manaroo":
           display_name: """Manaroo"""
           text: """At the start of the Engagement Phase, you may choose a friendly ship at range 0-1. If you do, transfer all green tokens assigned to you to that ship."""
        "Mining Guild Sentry":
           display_name: """Mining Guild Sentry"""
           text: """<i class = flavor_text>As part of its arrangement with the Empire, the Mining Guild receives modified TIE/ln Fighters to protect its operations. These craft have solar panels removed from their stabilizers for improved visibility, and feature more extensive life support systems for the benefit of their corporate pilots.</i>"""
        "Mining Guild Surveyor":
           display_name: """Mining Guild Surveyor"""
           text: """<i class = flavor_text>With Imperial construction projects consuming raw materials at an unprecedented rate, the Mining Guild ruthlessly exploits newly discovered deposits of doonium ore on worlds such as Batonn, Lothal, and Umbara.</i>"""
        "Miranda Doni":
           display_name: """Miranda Doni"""
           text: """While you perform a primary attack, you may either spend 1 shield to roll 1 additional attack die or, if you are not shielded, you may roll 1 fewer attack die to recover 1 shield."""
        "Moralo Eval":
           display_name: """Moralo Eval"""
           text: """If you would flee, you may spend 1 %CHARGE%. If you do, place yourself in reserves instead. At the start of the next Planning Phase, place yourself within range 1 of the edge of the play area that you fled from."""
        "Nien Nunb":
           display_name: """Nien Nunb"""
           text: """After you gain a stress token, if there is an enemy ship in your %FRONTARC% at range 0-1, you may remove that stress token."""
        "Norra Wexley (Y-Wing)":
           display_name: """Norra Wexley"""
           text: """While you defend, if there is an enemy ship at range 0-1, add 1 %EVADE% result to your dice results."""
        "Norra Wexley":
           display_name: """Norra Wexley"""
           text: """While you defend, if there is an enemy ship at range 0-1, add 1 %EVADE% result to your dice results. %LINEBREAK% <i>Errata (since rules reference 1.0.2): Removed “you may”</i>"""
        "Nu Squadron Pilot":
           display_name: """Nu Squadron Pilot"""
           text: """<i class = flavor_text>With a design inspired by other Cygnus Spaceworks vessels, the Alpha-class star wing is a versatile craft assigned to Imperial Navy specialist units that need a starfighter they can outfit for multiple roles.</i>"""
        "N'dru Suhlak":
           display_name: """N'dru Suhlak"""
           text: """While you perform a primary attack, if there are no other friendly ships at range 0-2, roll 1 additional attack die."""
        "Obi-Wan Kenobi":
           display_name: """Obi-Wan Kenobi"""
           text: """After a friendly ship at range 0-2 spends a focus token, you may spend 1 %FORCE%. If you do, that ship gains 1 focus token."""
        "Obi-Wan Kenobi (Delta-7b)":
           display_name: """Obi-Wan Kenobi"""
           text: """After a friendly ship at range 0-2 spends a focus token, you may spend 1 %FORCE%. If you do, that ship gains 1 focus token."""
        "Obsidian Squadron Pilot":
           display_name: """Obsidian Squadron Pilot"""
           text: """<i class = flavor_text>The TIE fighter's Twin Ion Engine system was designed for speed, making the TIE/ln one of the most maneuverable starships ever mass-produced.</i>"""
        "Old Teroch":
           display_name: """Old Teroch"""
           text: """At the start of the Engagement Phase, you may choose 1 enemy ship at range 1. If you do and you are in its %FRONTARC%, it removes all of its green tokens."""
        "Omega Squadron Ace":
           display_name: """Omega Squadron Ace"""
           text: """<i class = flavor_text>Only pilots who have demonstrated both exceptional skill and unwavering dedication are rewarded with coveted positions in the First Order squadrons operating secretly against the New Republic during the Cold War.</i>"""
        "Omega Squadron Expert":
           display_name: """Omega Squadron Expert"""
           text: """<i class = flavor_text>The TIE/sf is a versatile starfighter that carries specialized armament and experimental systems for long-range operations by First Order Special Forces.</i>"""
        "Omicron Group Pilot":
           display_name: """Omicron Group Pilot"""
           text: """<i class = flavor_text>Noted for its tri-wing design and advanced sensor suite, the Lambda-class shuttle serves a critical role as a light utility craft in the Imperial Navy.</i>"""
        "Onyx Squadron Ace":
           display_name: """Onyx Squadron Ace"""
           text: """<i class = flavor_text>The experimental TIE defender outclasses all other contemporary starfighters, though its size, speed, and array of weapons come at a tremendous cost in credits.</i>"""
        "Onyx Squadron Scout":
           display_name: """Onyx Squadron Scout"""
           text: """<i class = flavor_text>Designed for extended engagements, the TIE/ag is flown primarily by elite pilots trained to leverage both its unique weapons loadout and its maneuverability to full effect.</i>"""
        "Outer Rim Pioneer":
           display_name: """Outer Rim Pioneer"""
           text: """Friendly ships at range 0-1 can perform attacks at range 0 of obstacles."""
        "Outer Rim Smuggler":
           display_name: """Outer Rim Smuggler"""
           text: """<i class = flavor_text>Known for its durability and modular design, the YT-1300 is one of the most popular, widely used, and extensively customized freighters in the galaxy.</i>"""
        "Overseer Yushyn":
           display_name: """Overseer Yushyn"""
           text: """Before a friendly ship at range 1 would gain a disarm token, if that ship is not stressed, you may spend 1 %CHARGE%. If you do, that ship gains 1 stress token instead."""
        "Padmé Amidala":
           display_name: """Padmé Amidala"""
           text: """While an enemy ship in your %FRONTARC% defends or performs an attack that ship can modify only 1 %EVADE% result (other results can still be modified). """
        "Palob Godalhi":
           display_name: """Palob Godalhi"""
           text: """At the start of the Engagement Phase, you may choose 1 enemy ship in your firing arc at range 0-2. If you do, transfer 1 focus or evade token from that ship to yourself."""
        "Pammich Nerro Goode":
           text: """While you have 2 or fewer stress tokens, you may execute red maneuvers even while stressed"""
        "Partisan Renegade":
           display_name: """Partisan Renegade"""
           text: """<i class = flavor_text>Saw Gerrera's partisans were first established to oppose Separatist forces on Onderon during the Clone Wars, and continued to wage war against galactic tyranny as the Empire rose to power.</i>"""
        "Patrol Leader":
           display_name: """Patrol Leader"""
           text: """<i class = flavor_text>To be granted command of a VT-49 Decimator is seen as a significant promotion for a middling officer of the Imperial Navy.</i>"""
        "Petty Officer Thanisson":
           display_name: """Petty Officer Thanisson"""
           text: """During the Activation or Engagement Phase, after a ship in your %FRONTARC% at range 0-2 gains 1 stress token, you may spend 1 %CHARGE%. If you do, that ship gains 1 tractor token."""
        "Phoenix Squadron Pilot":
           display_name: """Phoenix Squadron Pilot"""
           text: """<i class = flavor_text>Led by Commander Jun Sato, the brave but inexperienced pilots of Phoenix Squadron face staggering odds in their battle against the Galactic Empire.</i>"""
        "Planetary Sentinel":
           display_name: """Planetary Sentinel"""
           text: """<i class = flavor_text>To protect its many military installations, the Empire requires a swift and vigilant defense force.</i>"""
        "Plo Koon":
           display_name: """Plo Koon"""
           text: """At the start of the Engagement Phase, you may spend 1 %FORCE% and choose another friendly ship at range 0-2. If you do, you may transfer 1 green token to it or transfer one orange token from it to yourself."""
        "Plo Koon (Delta-7b)":
           display_name: """Plo Koon"""
           text: """At the start of the Engagement Phase, you may spend 1 %FORCE% and choose another friendly ship at range 0-2. If you do, you may transfer 1 green token to it or transfer one orange token from it to yourself."""
        "Poe Dameron":
           display_name: """Poe Dameron"""
           text: """After you perform an action, you may spend 1 %CHARGE% to perform a white action, treating it as red."""
        "Prince Xizor":
           display_name: """Prince Xizor"""
           text: """While you defend, after the Neutralize Results step, another friendly ship at range 0-1 and in the attack arc may suffer 1 %HIT% or %CRIT% damage. If it does, cancel 1 matching result.%LINEBREAK%<strong>Microthrusters:</strong> While you perform a barrel roll, you <b>must</b> use the %BANKLEFT% or %BANKRIGHT% template instead of the %STRAIGHT% template."""
        "Quinn Jast":
           display_name: """Quinn Jast"""
           text: """At the start of the Engagement Phase, you may gain 1 disarm token to recover 1 %CHARGE% on 1 of your equipped upgrades. """
        "Rear Admiral Chiraneau":
           display_name: """Rear Admiral Chiraneau"""
           text: """While you perform an attack, if you are reinforced and the defender is in the %FULLFRONTARC% or %FULLREARARC% matching your reinforce token, you may change 1 of your %FOCUS% results to a %CRIT% result."""
        "Rebel Scout":
           display_name: """Rebel Scout"""
           text: """<i class = flavor_text>Designed to look like a bird in flight by the Corellian Engineering Corporation, “hawk” series ships are exemplary transport craft. Swift and rugged, the HWK-290 is often employed by Rebel agents as a mobile base of operations.</i>"""
        "Red Squadron Expert":
           display_name: """Red Squadron Expert"""
           text: """<i class = flavor_text>Although the bulk of the Resistance Starfighter Corps is made up of young volunteers from the New Republic, their ranks are bolstered by veterans of the Galactic Civil War determined to finish what they started decades ago.</i>"""
        "Red Squadron Veteran":
           display_name: """Red Squadron Veteran"""
           text: """<i class = flavor_text>Created as an elite starfighter squad, Red Squadron includes some of the best pilots in the Rebel Alliance.</i>"""
        "Resistance Sympathizer":
           display_name: """Resistance Sympathizer"""
           text: """<i class = flavor_text>After witnessing the Hosnian Cataclysm, some spacers willingly aided the Resistance with whatever ships they had.</i>"""
        "Rexler Brath":
           display_name: """Rexler Brath"""
           text: """After you perform an attack that hits, if you are evading, expose 1 of the defender's damage cards."""
        "Rey":
           display_name: """Rey"""
           text: """While you defend or perform an attack, if the enemy ship is in your %FRONTARC%, you may spend 1 %FORCE% to change 1 of your blank results to an %EVADE% or %HIT% result."""
        "Rho Squadron Pilot":
           display_name: """Rho Squadron Pilot"""
           text: """<i class = flavor_text>The elite pilots of Rho Squadron instill terror in the Rebellion, using both the Xg-1 assault configuration and Os-1 arsenal loadout of the Alpha-class star wing to devastating effect.</i>"""
        "Roark Garnet":
           display_name: """Roark Garnet"""
           text: """At the start of the Engagement Phase, you may choose 1 ship in your firing arc. If you do, it engages at initiative 7 instead of its standard initiative value this phase."""
        "Rogue Squadron Escort":
           display_name: """Rogue Squadron Escort"""
           text: """<i class = flavor_text>The elite pilots of Rogue Squadron are among the Rebellion's very best.</i> """
        "Rose Tico":
           text: """While you defend or perform an attack, you may reroll up to 1 of your results for each other friendly ship in the attack arc."""
        "Saber Squadron Ace":
           display_name: """Saber Squadron Ace"""
           text: """<i class = flavor_text>Led by Baron Soontir Fel, the pilots of Saber Squadron are among the Empire's best. Their TIE interceptors are marked with red stripes to designate pilots with at least ten confirmed kills. </i>"""
        "Sabine Wren":
           display_name: """Sabine Wren"""
           text: """Before you activate, you may perform a %BARRELROLL% or %BOOST% action."""
        "Sabine Wren (TIE Fighter)":
           display_name: """Sabine Wren"""
           text: """Before you activate, you may perform a %BARRELROLL% or %BOOST% action."""
        "Sabine Wren (Scum)":
           display_name: """Sabine Wren"""
           text: """While you defend, if the attacker is in your %SINGLETURRETARC% at range 0-2, you may add 1 %FOCUS% result to your dice results."""
        "Saesee Tiin":
           display_name: """Saesee Tiin"""
           text: """After a friendly ship at range 0-2 reveals its dial, you may spend 1 %FORCE%. If you do, set its dial to another maneuver of the same speed and difficulty."""
        "Saesee Tiin (Delta-7b)":
           display_name: """Saesee Tiin"""
           text: """After a friendly ship at range 0-2 reveals its dial, you may spend 1 %FORCE%. If you do, set its dial to another maneuver of the same speed and difficulty."""
        "Sarco Plank":
           display_name: """Sarco Plank"""
           text: """While you defend, you may treat your agility value as equal to the speed of the maneuver you executed this round."""
        "Saw Gerrera":
           display_name: """Saw Gerrera"""
           text: """While a damaged friendly ship at range 0-3 performs an attack, it may reroll 1 attack die."""
        "Scarif Base Pilot":
           display_name: """Scarif Base Pilot"""
           text: """<i class = flavor_text>The TIE reaper was designed to ferry elite troops to flashpoints on the battlefield, notably carrying Director Krennic's dreaded death troopers at the Battle of Scarif.</i>"""
        "Scimitar Squadron Pilot":
           display_name: """Scimitar Squadron Pilot"""
           text: """<i class = flavor_text>The TIE/sa is exceptionally nimble for a bomber, allowing it to pinpoint its target while avoiding excessive collateral damage to the surrounding area.</i> """
        "Separatist Bomber":
           display_name: """Separatist Bomber"""
           text: """<i class = flavor_text>The droid armies of the Separatists are callous to the plight of civilians and make no effort to limit collateral damage.</i>"""
        "Separatist Drone":
           display_name: """Separatist Drone"""
           text: """<i class = flavor_text>As the Clone Wars escalate, the Separatist Alliance continues to develop the technology of droid starfighters, as well as the tactical droids that command them.</i>"""
        "Serissu":
           display_name: """Serissu"""
           text: """While a friendly ship at range 0-1 defends, it may reroll 1 of its dice."""
        "Seventh Sister":
           display_name: """Seventh Sister"""
           text: """While you perform a primary attack, before the Neutralize Results step, you may spend 2 %FORCE% to cancel 1 %EVADE% result."""
        "Seyn Marana":
           display_name: """Seyn Marana"""
           text: """While you perform an attack, you may spend 1 %CRIT% result. If you do, deal 1 facedown damage card to the defender, then cancel your remaining results."""
        "Shadowport Hunter":
           display_name: """Shadowport Hunter"""
           text: """<i class = flavor_text>Crime syndicates augment the lethal skills of their loyal contractors with the best technology available, like the fast and formidable Lancer-class pursuit craft.</i>"""
        "Shara Bey":
           display_name: """Shara Bey"""
           text: """While you defend or perform a primary attack, you may spend 1 lock you have on the enemy ship to add 1 %FOCUS% result to your dice results."""
        "Sienar Specialist":
           display_name: """Sienar Specialist"""
           text: """<i class = flavor_text>During the development of the TIE aggressor, Sienar Fleet Systems valued performance and versatility over raw cost efficiency.</i>"""
        "Sienar-Jaemus Engineer":
           display_name: """Sienar-Jaemus Engineer"""
           text: """<i class = flavor_text>Developed by Sienar-Jaemus Fleet Systems as a successor to the vaunted TIE Defender, the TIE/vn Silencer incorporates bleeding-edge technologies developed at research facilities hidden in the Unknown Regions.</i>"""
        "Sigma Squadron Ace":
           display_name: """Sigma Squadron Ace"""
           text: """<i class = flavor_text>Featuring a hyperdrive and shields, the TIE phantom is also equipped with five laser cannons, giving it substantial firepower for an Imperial fighter.</i>"""
        "Skakoan Ace":
           display_name: """Skakoan Ace"""
           text: """<i class = flavor_text>With its powerful engines, devastating triple laser cannons, and high customizability, the Belbullab-22 is the chosen craft of several elite Separatist Alliance pilots, including the infamous General Grievous.</i>"""
        "Skull Squadron Pilot":
           display_name: """Skull Squadron Pilot"""
           text: """<i class = flavor_text>The aces of Skull Squadron favor an aggressive approach, using their craft's pivot wing technology to achieve unmatched agility in the pursuit of their quarry.</i> """
        "Sol Sixxa":
           display_name: """Sol Sixxa"""
           text: """If you would drop a device using a [1 %STRAIGHT%] template, you may drop it using any speed 1 template instead."""
        "Soontir Fel":
           display_name: """Soontir Fel"""
           text: """At the start of the Engagement Phase, if there is an enemy ship in your %BULLSEYEARC%, gain 1 focus token."""
        "Spice Runner":
           display_name: """Spice Runner"""
           text: """<i class = flavor_text>Though its cargo space is limited compared to other light freighters, the small, swift HWK-290 is a favorite choice of smugglers who specialize in discreetly transporting precious goods.</i>"""
        "Squad Seven Veteran":
           display_name: """Squad Seven Veteran"""
           text: """<i class = flavor_text>Clone Flight Seven serves as part of the Open Circle Fleet under legendary Jedi Generals such as Plo Koon and Obi-Wan Kenobi, and won glory at the battles of Coruscant and Cato Neimoidia.</i>"""
        "Starkiller Base Pilot":
           display_name: """Starkiller Base Pilot"""
           text: """<i class = flavor_text>The Upsilon-class command shuttle serves as a base of operations for many of the First Order's senior officers and agents. Its powerful sensors and communications equipment allow them to orchestrate the spread of terror across the galaxy.</i>"""
        "Storm Squadron Ace":
           display_name: """Storm Squadron Ace"""
           text: """<i class = flavor_text>The TIE Advanced x1 was produced in limited quantities, but Sienar engineers incorporated many of its best qualities into their next TIE model: the TIE Interceptor.</i>"""
        "Sunny Bounder":
           display_name: """Sunny Bounder"""
           text: """While you defend or perform an attack, after you roll or reroll your dice, if you have the same result on each of your dice, you may add 1 matching result."""
        "TN-3465":
           display_name: """TN-3465"""
           text: """While another friendly ship performs an attack, if you are at range 0-1 of the defender, you may suffer 1 %CRIT% damage to change 1 of the attacker's results to a %CRIT% result."""
        "Tala Squadron Pilot":
           display_name: """Tala Squadron Pilot"""
           text: """<i class = flavor_text>The AF4 series is the latest in a long line of Headhunter designs. Cheap and relatively durable, it is a favorite among independent outfits like the Rebellion.</i>"""
        "Tallissan Lintra":
           display_name: """Tallissan Lintra"""
           text: """While an enemy ship in your %BULLSEYEARC% performs an attack, you may spend 1 %CHARGE%.  If you do, the defender rolls 1 additional die."""
        "Talonbane Cobra":
           display_name: """Talonbane Cobra"""
           text: """While you defend at attack range 3 or perform an attack at attack range 1, roll 1 additional die."""
        "Tansarii Point Veteran":
           display_name: """Tansarii Point Veteran"""
           text: """<i class = flavor_text>The defeat of Black Sun ace Talonbane Cobra by Car'das smugglers turned the tide of the Battle of Tansarii Point Station. Survivors of the clash are respected throughout the sector.</i> """
        "Techno Union Bomber":
           display_name: """Techno Union Bomber"""
           text: """<i class = flavor_text>Baktoid Armor Workshop developed the Hyena as a strike craft compatible with Trade Federation Vulture swarm tactics.</i>"""
        "Tel Trevura":
           display_name: """Tel Trevura"""
           text: """If you would be destroyed, you may spend 1 %CHARGE%. If you do, discard all of your damage cards, suffer 5 %HIT% damage, and place yourself in reserves instead. At the start of the next Planning Phase, place yourself within range 1 of your player edge."""
        "Temmin Wexley":
           display_name: """Temmin Wexley"""
           text: """After you fully execute a speed 2-4 maneuver, you may perform a %BOOST% action."""
        "Tempest Squadron Pilot":
           display_name: """Tempest Squadron Pilot"""
           text: """<i class = flavor_text>The TIE Advanced improved on the popular TIE/ln design by adding shielding, better weapons systems, curved solar panels, and a hyperdrive.</i>"""
        "Ten Numb":
           display_name: """Ten Numb"""
           text: """While you defend or perform an attack, you may spend 1 stress token to change all of your %FOCUS% results to %EVADE% or %HIT% results."""
        "Thane Kyrell":
           display_name: """Thane Kyrell"""
           text: """While you perform an attack, you may spend 1 %FOCUS%, %HIT%, or %CRIT% result to look at the defender's facedown damage cards, choose 1, and expose it."""
        "Tomax Bren":
           display_name: """Tomax Bren"""
           text: """After you perform a %RELOAD% action, you may recover 1 %CHARGE% token on 1 of your equipped %TALENT% upgrade cards. """
        "Torani Kulda":
           display_name: """Torani Kulda"""
           text: """After you perform an attack, each enemy ship in your %BULLSEYEARC% suffers 1 %HIT% damage unless it removes 1 green token."""
        "Torkil Mux":
           display_name: """Torkil Mux"""
           text: """At the start of the Engagement Phase, you may choose 1 ship in your firing arc. If you do, that ship engages at initiative 0 instead of its normal initiative value this round."""
        "Trade Federation Drone":
           display_name: """Trade Federation Drone"""
           text: """<i class = flavor_text>The Trade Federation deployed countless Vulture Droids at the Battle of Naboo, and continues to use these inexpensive starfighters in the Clone Wars.</i>"""
        "Trandoshan Slaver":
           display_name: """Trandoshan Slaver"""
           text: """<i class = flavor_text>The spacious triple-decker design of the YV-666 makes it popular among bounty hunters and slavers, who often retrofit an entire deck for prisoner transport.</i>"""
        "Turr Phennir":
           display_name: """Turr Phennir"""
           text: """After you perform an attack, you may perform a %BARRELROLL% or %BOOST% action, even if you are stressed."""
        "Unkar Plutt":
           display_name: """Unkar Plutt"""
           text: """At the start of the Engagement Phase, if there are one or more other ships at range 0, you and each other ship at range 0 gain 1 tractor token."""
        "Valen Rudor":
           display_name: """Valen Rudor"""
           text: """After a friendly ship at range 0-1 defends (after damage is resolved, if any), you may perform an action."""
        "Ved Foslo":
           display_name: """Ved Foslo"""
           text: """While you execute a maneuver, you may execute a maneuver of the same bearing and difficulty of a speed 1 higher or lower instead."""
        "Vennie":
           display_name: """Vennie"""
           text: """While you defend, if the attacker is in a friendly ship's %SINGLETURRETARC%, you may add 1 %FOCUS% result to your roll."""
        "Viktor Hel":
           display_name: """Viktor Hel"""
           text: """After you defend, if you did not roll exactly 2 defense dice, the attacker gains 1 stress token."""
        "Warden Squadron Pilot":
           display_name: """Warden Squadron Pilot"""
           text: """<i class = flavor_text>Koensayr Manufacturing's K-wing boasts an advanced SubLight Acceleration Motor and an unprecedented 18 hard points, granting it unrivaled speed and firepower.</i>"""
        "Wat Tambor":
           display_name: """Wat Tambor"""
           text: """While you perform a primary attack, you may reroll 1 attack die for each calculating friendly ship at range 1 of the defender."""
        "Wedge Antilles":
           display_name: """Wedge Antilles"""
           text: """While you perform an attack, the defender rolls 1 fewer defense die."""
        "Wild Space Fringer":
           display_name: """Wild Space Fringer"""
           text: """<i class = flavor_text>Although stock YT-2400 light freighters have plenty of room for cargo, that space is often annexed to support modified weapon systems and oversized engines.</i>"""
        "Wullffwarro":
           display_name: """Wullffwarro"""
           text: """While you perform a primary attack, if you are damaged, you may roll 1 additional attack die."""
        "Zari Bangel":
           display_name: """Zari Bangel"""
           text: """You do not skip your Perform Action step after you partially execute a maneuver."""
        "Zealous Recruit":
           display_name: """Zealous Recruit"""
           text: """<i class = flavor_text>Mandalorian Fang fighter pilots must master the Concordia Faceoff maneuver, leveraging their ships' narrow attack profile to execute deadly head-on charges.</i> """
        "Zertik Strom":
           display_name: """Zertik Strom"""
           text: """During the End Phase, you may spend a lock you have on an enemy ship to expose 1 of that ship's damage cards."""
        "Zeta Squadron Pilot":
           display_name: """Zeta Squadron Pilot"""
           text: """<i class = flavor_text>Unhampered by a cumbersome galactic bureaucracy, technologies originally researched by the Empire's TIE Advanced program are now mass-produced on First Order starfighters. As a result, TIE/fo pilots enjoy higher survival rates than their predecessors in the Galactic Empire.</i>"""
        "Zeta Squadron Survivor":
           display_name: """Zeta Squadron Survivor"""
           text: """<i class = flavor_text>Humiliated by their failure, the remaining pilots from Starkiller Base are eager to prove their worth in pursuit of the Resistance.</i>"""
        "Zuckuss":
           display_name: """Zuckuss"""
           text: """While you perform a primary attack, you may roll 1 additional attack die. If you do, the defender rolls 1 additional defense die."""
        '"Avenger"':
           display_name: """“Avenger”"""
           text: """After another friendly ship is destroyed, you may perform an action, even while stressed."""
        '"Axe"':
           display_name: """“Axe”"""
           text: """After you defend or perform an attack, you may choose a friendly ship at range 1-2 in your %LEFTARC%  or %RIGHTARC%. If you do, transfer 1 green token to that ship."""
        '"Backdraft"':
           display_name: """“Backdraft”"""
           text: """While you perform a %SINGLETURRETARC% primary attack, if the defender is in your %REARARC%, roll 1 additional die."""
        '"Blackout"':
           display_name: """“Blackout”"""
           text: """While you perform an attack, if the attack is obstructed by an obstacle, the defender rolls 2 fewer defense dice."""
        '"Chopper"':
           display_name: """“Chopper”"""
           text: """At the start of the Engagement Phase, each enemy ship at range 0 gains 2 jam tokens. """
        '"Countdown"':
           display_name: """“Countdown”"""
           text: """While you defend, after the Neutralize Results step, if you are not stressed, you may suffer 1 %HIT% damage and gain 1 stress token. If you do, cancel all dice results."""
        '"Deathfire"':
           display_name: """“Deathfire”"""
           text: """After you are destroyed, before you are removed, you may perform an attack and drop or launch 1 device."""
        '"Deathrain"':
           display_name: """“Deathrain”"""
           text: """After you drop or launch a device, you may perform an action."""
        '"Double Edge"':
           display_name: """“Double Edge”"""
           text: """After you perform a %TURRET% or %MISSILE% attack that misses, you may perform a bonus attack using a different weapon."""
        '"Duchess"':
           display_name: """“Duchess”"""
           text: """You may choose not to use your <strong>Adaptive Ailerons</strong>. %LINEBREAK%You may use your <strong>Adaptive Ailerons</strong> even while stressed."""
        '"Dutch" Vander':
           display_name: """“Dutch” Vander"""
           text: """After you perform the %LOCK% action, you may choose 1 friendly ship at range 1-3. That ship may acquire a lock on the object you locked, ignoring range restrictions."""
        '"Echo"':
           display_name: """“Echo”"""
           text: """While you decloak, you <b>must</b> use the [2 %BANKLEFT%] or [2 %BANKRIGHT%] template instead of the [2 %STRAIGHT%] template."""
        '"Howlrunner"':
           display_name: """“Howlrunner”"""
           text: """While a friendly ship at range 0-1 performs a primary attack, that ship may reroll 1 attack die."""
        '"Jag"':
           display_name: """“Jag”"""
           text: """After a friendly ship at range 1-2 in your %LEFTARC%  or %RIGHTARC%  defends, you may acquire a lock on the attacker."""
        '"Kickback"':
           display_name: """“Kickback”"""
           text: """After you perform a %BARRELROLL% action, you may perform a red %LOCK% action."""
        '"Leebo"':
           display_name: """“Leebo”"""
           text: """After you defend or perform an attack, if you spent a calculate token, gain 1 calculate token."""
        '"Longshot"':
           display_name: """“Longshot”"""
           text: """While you perform a primary attack at attack range 3, roll 1 additional attack die."""
        '"Mauler" Mithel':
           display_name: """“Mauler” Mithel"""
           text: """While you perform an attack at attack range 1, roll 1 additional attack die."""
        '"Midnight"':
           display_name: """“Midnight”"""
           text: """While you defend or perform an attack, if you have a lock on the enemy ship, that ship's dice cannot be modified."""
        '"Muse"':
           display_name: """“Muse”"""
           text: """At the start of the Engagement Phase, you may choose a friendly ship at range 0-1. If you do, that ship removes 1 stress token."""
        '"Night Beast"':
           display_name: """“Night Beast”"""
           text: """After you fully execute a blue maneuver, you may perform a %FOCUS% action."""
        '"Null"':
           display_name: """“Null”"""
           text: """While you are not damaged, treat your initiative value as 7."""
        '"Odd Ball"':
           display_name: """“Odd Ball”"""
           text: """After you fully execute a red maneuver or perform a red action, if there is an enemy ship in your %BULLSEYEARC%, you may acquire a lock on that ship."""
        '"Odd Ball" (ARC-170)':
           display_name: """“Odd Ball”"""
           text: """After you fully execute a red maneuver or perform a red action, if there is an enemy ship in your %BULLSEYEARC%, you may acquire a lock on that ship."""
        '"Pure Sabacc"':
           display_name: """“Pure Sabacc”"""
           text: """While you perform an attack, if you have 1 or fewer damage cards, you may roll 1 additional attack die."""
        '"Quickdraw"':
           display_name: """“Quickdraw”"""
           text: """After you lose a shield, you may spend 1 %CHARGE%. If you do, you may perform a bonus primary attack."""
        '"Recoil"':
           display_name: """“Recoil”"""
           text: """While you are stressed, you may treat enemy ships in your %FRONTARC% at range 0-1 as being in your %BULLSEYEARC%."""
        '"Redline"':
           display_name: """“Redline”"""
           text: """You can maintain up to 2 locks. %LINEBREAK%After you perform an action, you may acquire a lock."""
        '"Scorch"':
           display_name: """“Scorch”"""
           text: """While you perform a primary attack, if you are not stressed, you may gain 1 stress token to roll 1 additional attack die."""
        '"Scourge" Skutu':
           display_name: """“Scourge” Skutu"""
           text: """While you perform an attack against a defender in your %BULLSEYEARC%, roll 1 additional attack die."""
        '"Sinker"':
           display_name: """“Sinker”"""
           text: """While a friendly ship at range 1-2 in your %LEFTARC% or %RIGHTARC% performs a primary attack, it may reroll 1 attack die."""
        '"Static"':
           display_name: """“Static”"""
           text: """While you perform a primary attack, you may spend your lock on the defender and a focus token to change all of your results to %CRIT% results."""
        '"Swoop"':
           display_name: """“Swoop”"""
           text: """After a friendly small or medium ship fully executes a speed 3-4 maneuver, if it is at range 0-1, it may perform a red %BOOST% action."""
        '"Tucker"':
           display_name: """“Tucker”"""
           text: """After a friendly ship at range 1-2 performs an attack against an enemy ship in your %FRONTARC%, you may perform a %FOCUS% action."""
        '"Vizier"':
           display_name: """“Vizier”"""
           text: """After you move using your <strong>Controlled Ailerons</strong> ship ability, you may perform a %COORDINATE% action. If you do, skip your Perform Action step."""
        '"Wampa"':
           display_name: """“Wampa”"""
           text: """While you perform an attack, you may spend 1 %CHARGE% to roll 1 additional attack die.%LINEBREAK%After defending, lose 1 %CHARGE%."""
        '"Whisper"':
           display_name: """“Whisper”"""
           text: """After you perform an attack that hits, gain 1 evade token."""
        '"Wolffe"':
           display_name: """“Wolffe”"""
           text: """While you perform a primary %FRONTARC% attack, you may spend 1 %CHARGE% to reroll 1 attack die. %LINEBREAK%While you perform a primary %REARARC% attack, you may recover 1 %CHARGE% to roll 1 additional attack die. """
        '"Zeb" Orrelios':
           display_name: """“Zeb” Orrelios"""
           text: """While you defend, %CRIT% results are neutralized before %HIT% results."""
        '"Zeb" Orrelios (Sheathipede)':
           display_name: """“Zeb” Orrelios"""
           text: """While you defend, %CRIT% results are neutralized before %HIT% results."""
        '"Zeb" Orrelios (TIE Fighter)':
           display_name: """“Zeb” Orrelios"""
           text: """While you defend, %CRIT% results are neutralized before %HIT% results."""
        "Bombardment Drone":
           text: """If you would drop a device, you may launch that device instead, using the same template."""
        "Haor Chall Prototype":
           display_name: """Haor Chall Prototype"""
           text: """After an enemy ship in your %BULLSEYEARC% at range 0-2 declares another friendly ship as the defender, you may perform a %CALCULATE% or %LOCK% action."""
        "Precise Hunter":
           display_name: """Precise Hunter"""
           text: """While you perform an attack, if the defender is in your %BULLSEYEARC%, you may reroll 1 blank result."""
        "Rose Tico":
           display_name: """Rose Tico"""
           text: """While you defend or perform an attack, you may reroll up to 1 of your results for each other friendly ship in the attack arc."""
        "Pammich Nerro Goode":
           display_name: """Pammich Nerro Goode"""
           text: """While you have 2 or fewer stress tokens, you may execute red maneuvers even while stressed."""
        "Padmé Amidala":
           display_name: """Padmé Amidala"""
           text: """While an enemy ship in your %FRONTARC% defends or performs an attack, that ship can modify only 1 %FOCUS% result (other results can still be modified). """
        "Anakin Skywalker (N-1 Starfighter)":
           display_name: """Anakin Skywalker"""
           text: """Before you reveal your maneuver, you may spend 1 %FORCE% to barrel roll (this is not an action). """
        "Ric Olié":
           display_name: """Ric Olié"""
           text: """While you defend or perform a primary attack, if the speed of your revealed maneuver is higher than the enemy ship's, roll 1 additional die. """
        "Dineé Ellberger":
           display_name: """Dineé Ellberger"""
           text: """While you defend or perform an attack, if the speed of your revealed maneuver is the same as the enemy ship's, that ship's dice cannot be modified. """
        "Naboo Handmaiden":
           display_name: """Naboo Handmaiden"""
           text: """<strong>Setup:</strong> After placing forces, assign the <strong>Decoyed</strong> condition to 1 friendly ship other than <strong>Naboo Handmaiden</strong>. """
        "Bravo Flight Officer":
           display_name: """Bravo Flight Officer"""
           text: """ """
        "BB-8":
           display_name: """BB-8"""
           text: """During the System Phase, you may perform a red %BARRELROLL% or %BOOST% action."""
        "Finn":
           display_name: """Finn"""
           text: """While you defend or perform an attack, you may add 1 blank result, or you may gain 1 strain token to add 1 focus result instead."""
        "Cova Nell":
           display_name: """Cova Nell"""
           text: """While you defend or perform a primary attack, if your revealed maneuver is red, roll 1 additional die."""
        "Nodin Chavdri":
           display_name: """Nodin Chavdri"""
           text: """After you coordinate or are coordinated, if you have 2 or fewer stress tokens, you may perform 1 action on your action bar as a red action, even if you are stressed."""
        "Vi Moradi":
           display_name: """Vi Moradi"""
           text: """<strong>Setup:</strong> After placing forces, assign the <strong>Compromising Intel</strong> condition to 1 enemy ship."""
        "Shadow Squadron Veteran":
           text: """"""
        "Red Squadron Bomber":
           text: """"""
        '"Goji"':
           text: """While a friendly ship at range 0-3 defends, it may roll 1 additional defense die for each friendly bomb at 0-1 of it.  %LINEBREAK% <i>Errata (since rules reference 1.1.0): Removed "or mine"</i>"""
        '"Broadside"':
           text: """While you perform a %SINGLETURRETARC% attack, if your %SINGLETURRETARC% indicator is in your %LEFTARC% or %RIGHTARC%, you may change 1 blank result to a %FOCUS% result. """
        '"Matchstick"':
           text: """While you perform a primary or %SINGLETURRETARC% attack, you may reroll 1 attack die for each red token you have. """
        '"Odd Ball" (Y-Wing)':
           display_name: """“Odd Ball”"""
           text: """After you execute a red maneuver or perform a red action, if there is an enemy ship in your %BULLSEYEARC%, you may acquire a lock on that ship. """
        "R2-D2":
           text: """At the start of the Engagement Phase, if there is an enemy ship in your %REARARC%, gain 1 calculate token."""
        "Anakin Skywalker (Y-Wing)":
           display_name: """Anakin Skywalker"""
           text: """After you fully execute a maneuver, if there is an enemy ship in your %FRONTARC% at range 0-1 or in your %BULLSEYEARC%, you may spend 1 %FORCE% to remove 1 stress token."""
        "Sun Fac":
           text: """While you perform a primary attack, if the defender is tractored, roll 1 additional attack die."""
        "Stalgasin Hive Guard":
           text: """ """
        "Petranaki Arena Ace":
           text: """ """
        "Berwer Kret":
           text: """After you perform an attack that hits, each friendly ship with %CALCULATE% on its action bar and a lock on the defender may perform a red %CALCULATE% action. """
        "Chertek":
           text: """While you perform a primary attack, if the defender is tractored, you may reroll up to 2 attack dice. """
        "Gorgol":
           text: """During the System Phase, you may gain 1 disarm token and choose a friendly ship at range 1-2. If you do, it gains 1 tractor token, then repairs 1 of its faceup <strong>Ship</strong> trait damage cards. """
        "Kazuda Xiono":
           text: """While you defend or perform a primary attack, if the enemy ship's initiative is higher than the number of damage cards you have, you may roll 1 additional die. """
        "Major Vonreg":
           text: """During the System Phase, you may choose 1 enemy ship in your %BULLSEYEARC%. That ship gains 1 deplete or strain token of your choice. """
        "First Order Provocateur":
           text: """"""
        '"Ember"':
           text: """While you perform an attack, if there is a damaged ship friendly to the defender at range 0-1 of the defender, the defender cannot spend focus or calculate tokens. """
        '"Holo"':
           text: """At the start of the Engagement Phase, you <b>must</b> transfer 1 of your tokens to another friendly ship at range 0-2. """
        "Captain Phasma":
           text: """While you defend, after the Neutralize Results step, another friendly ship at range 0-1 <b>must</b> suffer 1 %HIT%/%CRIT% damage to cancel 1 matching result. """
        '"Rush"':
           text: """While you are damaged, treat your initiative as 6. """
        "Zizi Tlo":
           text: """After you defend or perform an attack, you may spend 1 %CHARGE% to gain 1 focus or evade token. """
        "Ronith Blario":
           text: """While you defend or perform an attack, if the enemy ship is in another friendly ship's %SINGLETURRETARC%, you may spend 1 focus token from that friendly ship to change 1 of your %FOCUS% results to an %EVADE% or %HIT% result. """
        "Gina Moonsong":
           text: """At the start of the Engagement Phase, you <b>must</b> transfer 1 of your stress tokens to another friendly ship at range 0-2."""
        "K-2SO":
           text: """After you gain a stress token, gain 1 calculate token."""
        "Alexsandr Kallus":
           text: """While you defend, if the attacker modified any attack dice, you may roll 1 additional defense die.  <br><i>Errata (since rules reference 1.2.0): Added missing ship ability"""
        "Leia Organa":
           text: """After a friendly ship fully executes a red maneuver, if it is at range 0-3, you may spend 1 %FORCE%. If you do, that ship gains 1 focus token or recovers 1 %FORCE%."""
        "Paige Tico":
           text: """After you drop a device, you may spend 1 %CHARGE% to drop an additional device."""
        "Fifth Brother":
           text: """While you perform an attack, after the Neutralize Results step, if the attack hit, you may spend 2 %FORCE% to add 1 %CRIT% result."""
        '"Vagabond"':
           text: """After you move using your <strong>Adaptive Ailerons</strong>, if you are not stressed you may drop 1 device. """
        "Morna Kee":
           text: """During the End Phase, you may spend 1 %CHARGE% to flip 1 of your reinforce tokens to the other full arc instead of removing it."""
        "Lieutenant LeHuse":
           text: """While you perform an attack, you may spend another friendly ship's lock on the defender to reroll any number of your results. """
        "Bossk (Z-95 Headhunter)":
           display_name: """Bossk"""
           text: """While you perform a primary attack, after the Neutralize Results step, you may spend 1 %CRIT% result to add 2 %HIT% results."""
        "G4R-GOR V/M":
           text: """After you defend, each other ship at range 0 suffers 1 %CRIT% damage. """
        "Nom Lumb":
           text: """After you become the defender, if the attacker is not in your %SINGLETURRETARC%, you <b>must</b> rotate your %SINGLETURRETARC% indicator to a standard arc the attacker is in."""
        "Jarek Yeager":
           text: """While you have 2 or fewer stress tokens, if you are damaged, you can execute red basic maneuvers even while stressed. If you are critically damaged, you can execute red advanced maneuvers even while stressed. """
        "R1-J5":
           text: """Before you expose 1 of your damage cards, you may look at your facedown damage cards, choose 1 and expose that card instead. """
        "Colossus Station Mechanic":
           text: """"""
        "212th Battalion Pilot":
           text: """"""
        '"Hawk"':
           text: """At the start of the End Phase, each friendly ship at range 0-1 that has a revealed maneuver of speed 3-5 may gain 1 strain token to perform a %BARRELROLL% or %BOOST% action. """
        '"Hound"':
           text: """After a friendly small ship in your %SINGLETURRETARC% gains a deplete or strain token, if you have no tokens of that type, you may transfer that token to yourself. """
        '"Warthog"':
           text: """After you or a friendly non-limited ship at range 0-2 are destroyed during the Engagement Phase, that ship is not removed until the end of that phase. """
        "Baktoid Drone":
           text: """"""
        "Separatist Predator":
           text: """"""
        "DGS-286":
           text: """Before you engage, you may choose another friendly ship at range 0-1. That ship transfers 1 calculate token to you. """
        "DGS-047":
           text: """After you perform an attack, if the defender is in your %FRONTARC%, you may acquire a lock on it. Then, if the defender is in your %BULLSEYEARC%, it gains 1 strain token. """
        "Geonosian Prototype":
           text: """While you perform a %MISSILE% or %CANNON% attack, you may remove 1 tractor token from the defender to reroll up to 2 attack dice. """
        "Onderon Oppressor":
           text: """After you barrel roll or sideslip, if you are stressed. Gain 1 calculate token. """
        "Jedi General":
           text: """"""
        "Yoda":
           text: """After another friendly ship at range 0-3 spends 1 or more %FORCE%, you may spend 1 %FORCE%. If you do, that ship recovers 1 %FORCE%. """
        "Shaak Ti":
           text: """At the start of the End Phase, you may spend any number of %FORCE% to choose that many friendly ships at range 0-2. Each chosen ship does not remove 1 focus or evade token during this End Phase. """
        "Aayla Secura":
           text: """While an enemy ship in your %FRONTARC% at range 0-1 performs an attack, the defender may change 1 blank result to a %FOCUS% result. """
        "Obi-Wan Kenobi (Eta-2)":
           display_name: """Obi-Wan Kenobi"""
           text: """After you or a friendly <b>Anakin Skywalker</b> at range 0-3 executes a maneuver, if there are more enemy ships than other friendly ships at range 0-1 of that ship, you may spend 1 %FORCE%. If you do, that ship gains 1 focus token. """
        "Anakin Skywalker (Eta-2)":
           display_name: """Anakin Skywalker"""
           text: """After you or a friendly <b>Obi-Wan Kenobi</b> ship at range 0-3 executes a maneuver, if there are more enemy ships than other friendly ships at range 0-1 of that ship, you may spend 1 %FORCE%. If you do, that ship removes 1 red token of your choice. """
        "TransGalMeg Control Link":
           text: """<strong>Hyperspace Docking Ring:</strong> 1 Delta-7 Aethersprite, Eta-2 Actis, or Nimbus-class V-wing can dock with you. %LINEBREAK% While a ship is docked with you, you gain that ship's initiative and are assigned that ship's dial. While you execute a maneuver, reduce its speed to 1. Before you execute an advanced maneuver, execute a white stationary maneuver (%STOP%) instead, then you may rotate 90º or 180º. %LINEBREAK% While no ship is docked with you, you are not assigned a maneuver dial and do not activate or engage."""
        "Jango Fett":
           text: """While you defend or perform a primary attack, if the difficulty of your revealed maneuver is less than that of the enemy ship's, you may change 1 of the enemy ship's %FOCUS% results to a blank result."""
        "Separatist Interceptor":
           text: """ """
        "Colicoid Interceptor":
           text: """ """
        "Phlac-Arphocc Prototype":
           text: """During the System Phase, you may spend your lock on a ship to look at that ship's dial. """
        "Fearsome Predator":
           text: """<strong>Setup:</strong> After placing forces, assign the <b>Fearful Prey</b> condition to 1 enemy ship. """
        "DIS-347":
           text: """At the start of the Engagement Phase, you may acquire a lock on an object at range 1-3 that has a friendly lock. """
        "DIS-T81":
           text: """While you defend or perform an attack, you may spend 1 calculate token from a friendly ship in the enemy ship's firing arc to change 1 %FOCUS% result to an %EVADE% or %HIT% result. """
        "Lyttan Dree":
           text: """While a friendly ship at range 0-2 performs an attack, if you are in the defender's %LEFTARC% or %RIGHTARC%, the attacker may reroll 1 attack die. """
        '"Rampage"':
           text: """After you execute a speed 3-4 maneuver, you may choose a ship in your %SINGLETURRETARC% at range 0-1. If you do, that ship gains 1 strain token, or 2 strain tokens if you are damaged. """
        "Onyx Squadron Sentry":
           text: """"""
        "Carida Academy Cadet":
           text: """"""
        "Poe Dameron (HoH)":
           text: """After a friendly ship at range 0-2 performs an action during its activation, you may spend 2 %CHARGE%. If you do, that ship may perform a white action, treating it as red. """
        "Temmin Wexley (HoH)":
           text: """At the start of the Engagement Phase, each friendly T-70 X-wing at range 0-3 may gain 1 strain token to flip its equipped %CONFIGURATION% upgrade. If it does, that ship gains 1 calculate token. """
        "C'ai Threnalli":
           text: """After you fully execute a maneuver, if you moved through a friendly ship, you may perform an %EVADE% action. """
        "Nimi Chireen":
           text: """While you perform an attack, if the defender's initiative is higher than yours, you may change 1 blank result to a %FOCUS% result. """
        "Merl Cobben":
           text: """While a friendly ship at range 0-2 performs a primary attack, if you are in the defender's %BULLSEYEARC%, the defender rolls 1 fewer defense die. """
        "Seftin Vanik":
           text: """After you perform a %BOOST% action, you may transfer 1 evade token to a friendly ship at range 1. """
        "Suralinda Javos":
           text: """After you partially execute a maneuver, you may gain 1 strain token to rotate 90º or 180º. """
        "Wrobie Tyce":
           text: """After you defend at attack range 1, if the attacker modified its dice, the attacker gains 1 deplete token. """
        "Agent Terex":
           text: """<strong>Setup:</strong> After placing forces, choose any number of your equipped %ILLICIT% upgrades and equip them to friendly TIE/fo or TIE/sf fighters. Each ship can be assigned only 1 %ILLICIT% this way. %LINEBREAK% <strong>End of Game:</strong> Return all %ILLICIT% upgrades to their original ships."""
        "Commander Malarus (Xi Shuttle)":
           display_name: """Commander Malarus"""
           text: """While a friendly ship at range 0-2 performs a primary attack, before the Modify Dice step, if it has 1 or more blank results, that ship <b>must</b> gain 1 strain token to reroll 1 blank result, if able. %LINEBREAK% <i>Errata (RR: 1.2.0 [06/14/2021]): Added a specific timing window to prevent players from circumventing the downsides of the Pilot Ability</i>"""
        "Gideon Hask (Xi Shuttle)":
           display_name: """Gideon Hask"""
           text: """While you or a friendly small ship at range 0-2 performs a primary attack against a damaged defender, if the attacker rolled 2 or fewer attack dice, it may gain 1 strain token to roll 1 additional attack die."""
        "Loyalist Volunteer":
           text: """"""
        "Shadow Squadron Escort":
           text: """"""
        "Wilhuff Tarkin":
           text: """During the System Phase, you may choose an object that you have locked at range 1-3. Another friendly ship at range 1-3 may acquire a lock on that object. """
        '"Klick"':
           text: """While a ship that you have locked at range 1-3 defends or performs an attack, you may spend 1 %CHARGE% to prevent range bonuses from being applied. """
        '"Contrail"':
           text: """While you defend or perform an attack, if the bearing of your revealed maneuver is the same as the enemy ship's, you may change 1 of the enemy ship's %FOCUS% results to a blank result. """
        '"Odd Ball" (V-wing)':
           display_name: """“Odd Ball”"""
           text: """After you fully execute a red maneuver or perform a red action, if there is an enemy ship in your %BULLSEYEARC%, you may acquire a lock on that ship. """
        "Boba Fett (Separatist)":
           display_name: """Boba Fett"""
           text: """While you defend, if there are no other friendly ships at range 0-2, you may change 1 of your blank results to a %FOCUS% result."""
        "Zam Wesell":
           text: """<strong>Setup:</strong> Lose 2 %CHARGE%. %LINEBREAK% During the System Phase, you may assign 1 of your secret conditions to yourself facedown: <strong> %LINEBREAK% You Should Thank Me %LINEBREAK% You'd Better Mean Business. </strong>"""
        "Jango Fett":
           text: """While you defend or perform a primary attack, if the difficulty of your revealed maneuver is less than that of the enemy ship's, you may change 1 of the enemy ship's %FOCUS% results to a blank result."""
        "Hera Syndulla (B-Wing)":
           display_name: """Hera Syndulla"""
           text: """While another friendly ship at range 1-2 defends or performs an attack, during a Modify Dice step, you may transfer 1 of your focus tokens, evade tokens, or locks to that ship. %LINEBREAK% <i>Errata (RR: 1.2.0 [06/14/2021]): Added a specific timing window to prevent players from circumventing the downsides of the Pilot Ability</i>"""
        "Netrem Pollard":
           text: """After you barrel roll, you may choose 1 friendly ship that is not stressed at range 0-1. That ship gain's 1 stress token, then you rotate 180º."""
        "Hera Syndulla (A-Wing)":
           display_name: """Hera Syndulla"""
           text: """While another friendly ship at range 1-2 defends or performs an attack, during a Modify Dice step, you may transfer 1 of your focus tokens, evade tokens, or locks to that ship. %LINEBREAK% <i>Errata (RR: 1.2.0 [06/14/2021]): Added a specific timing window to prevent players from circumventing the downsides of the Pilot Ability</i>"""
        "Wedge Antilles (A-Wing)":
           display_name: """Wedge Antilles"""
           text: """While you perform a primary attack, if the defender is in your %FRONTARC%, the defender rolls 1 fewer defense die. """
        "Sabine Wren (A-Wing)":
           display_name: """Sabine Wren"""
           text: """While you defend or perform an attack, if the attack range is 1 and  you are in the enemy's %FRONTARC%, you may change 1 of your results to an %EVADE% or %HIT% result. """
        "Derek Klivian":
           text: """After you acquire or spend a lock, you may remove 1 red token from yourself. """
        "Ahsoka Tano (A-Wing)":
           display_name: """Ahsoka Tano"""
           text: """After you fully execute a maneuver, you may choose a friendly ship at range 1-2 and spend 2 %FORCE%. That ship may perform an action, even while stressed. """
        "Shara Bey (A-Wing)":
           display_name: """Shara Bey"""
           text: """While you defend or perform a primary attack, you may spend 1 lock you have on the enemy ship to add 1 %FOCUS% result to your dice results. """
        "Darth Vader (TIE Defender)":
           display_name: """Darth Vader"""
           text: """You cannot spend %FORCE% except while attacking. %LINEBREAK% While you perform an attack, you may spend 1 %FORCE% to change 1 blank result to a %HIT% result. """
        "Captain Dobbs":
           text: """While another friendly ship at range 0-1 defends, before the Neutralize Results step, if you are in the attack arc and are not ionized, you may gain 1 ion token to cancel 1 %HIT% result. """
        "Vult Skerris":
           text: """<strong>Action:</strong> Gain 1 strain token to recover 1 %CHARGE%. %LINEBREAK% Before you engage, you may spend 1 %CHARGE% to perform an action. """
        "Vult Skerris (TIE Interceptor)":
           display_name: """Vult Skerris"""
           text: """<strong>Action:</strong> Gain 1 strain token to recover 1 %CHARGE%. %LINEBREAK% Before you engage, you may spend 1 %CHARGE% to perform an action. """
        "Gideon Hask (TIE Interceptor)":
           display_name: """Gideon Hask"""
           text: """While you perform an attack against a damaged defender, roll 1 additional attack die."""
        "Commandant Goran":
           text: """At the start of the Engagement Phase, choose a friendly ship at range 0-3 with a lower initiative than yours. The chosen ship gains 1 evade token and removes 1 non-stress red token.%LINEBREAK%<i>Errata (since rules reference 1.4): ability reworked</i>"""
        "Nash Windrider":
           text: """During the Engagement Phase, after a friendly small ship at range 0-3 is destroyed, if that ship has not engaged this phase, you may spend 1 %CHARGE%. If you do, that ship engages at the current initiative. """
        "Ciena Ree":
           text: """After you perform an attack, if the defender was destroyed, gain 1 stress token. %LINEBREAK% After a friendly ship at range 0-3 is destroyed, remove 1 stress token. """
        "Lieutenant Lorrir":
           text: """While you barrel roll, you <b>must</b> use the (%BANKLEFT% or %BANKRIGHT%) template instead of the %STRAIGHT% template. """
        "Kanan Jarrus (HWK-290)":
           display_name: """Kanan Jarrus"""
           text: """While you or a ship in your %SINGLETURRETARC% defends, you may spend 1 %FORCE%. If you do, the attacker rolls 1 fewer attack die."""
        "Tápusk":
           text: """During the End Phase, before an enemy ship in your %SINGLETURRETARC% recovers 1 recurring %CHARGE% or %FORCE%, you may spend 2 %CHARGE%. If you do, that ship does not recover that %CHARGE% or %FORCE%"""
        "Gamut Key":
           text: """At the start of the End Phase, you may spend 2 %CHARGE% to choose yourself or a ship in your %SINGLETURRETARC% with 1 or more circular tokens. During the End Phase, circular tokens are not removed from that ship."""
        "Arliz Hadrassian":
           text: """While you perform a %FRONTARC% attack, if you are damaged, before the Modify Dice step, you may change 1 of your %FOCUS% results to a %CRIT% result. %LINEBREAK% While you defend, if you are damaged, you <b>must</b> change 1 of your %FOCUS% results to a blank result. %LINEBREAK% <i>Errata (RR: 1.2.0 [06/14/2021]): Added a specific timing window to prevent players from circumventing the downsides of the Pilot Ability</i>"""
        "Leema Kai":
           text: """Before you engage, if you are not in any enemy ship's %FRONTARC%, you may acquire a lock on an enemy ship in your %FULLFRONTARC%."""
        "Padric":
           text: """After a friendly device that you have locked detonates, each enemy ship at range 0-1 of that device gains 1 strain token."""
        "New Republic Patrol":
           text: """"""
        "Kijimi Spice Runner":
           text: """"""
        "Corus Kapellim":
           text: """Before you engage, you may choose 1 ship in your firing arc at range 0-1. If you do, transfer 1 green token from that ship to yourself. """
        "C'ai Threnalli (Y-Wing)":
           display_name: """C'ai Threnalli"""
           text: """After you fully execute a maneuver, if you moved through a friendly ship, you may perform an %EVADE% action. """
        "Lega Fossang":
           text: """While you perform a primary or %TURRET% attack, you may reroll 1 attack die for each friendly device or calculating friendly ship in the attack arc. """
        "Shasa Zaro":
           text: """After you defend, you may choose a friendly ship in your %FULLREARARC% at range 0-2 and 1 of your green tokens. If you do, that ship gains a matching token. """
        "Teza Nasz":
           text: """While a friendly ship at range 0-2 performs an attack, if the defender has a ship friendly to the attacker in each of its side arcs (%LEFTARC% or %RIGHTARC%), the attacker may reroll 1 attack die. """
        "Wilsa Teshlo":
           text: """After you perform an attack, if the defender was dealt a faceup damage card, the defender gains 1 strain token unless it chooses 1 non-recurring %CHARGE% from 1 of its equipped upgrades and loses that %CHARGE%. """
        "Aftab Ackbar":
           text: """After you execute a red basic maneuver or perform a red action, if you have exactly 1 stress token, you may gain 1 strain token to remove that stress token. """
        "Zorii Bliss":
           text: """After a ship at range 1 performs an action during its Perform Action step, if that action is on your action bar, you may spend 1 %CHARGE% to perform that action, treating it as red."""
        "Kylo Ren (TIE Whisper)":
           display_name: """Kylo Ren"""
           text: """Before an enemy ship in your %BULLSEYEARC% is dealt a facedown damage card, you may spend 1 %FORCE%. If you do, that damage card is dealt face up instead. """
        '"Wrath"':
           text: """After you perform a %BULLSEYEARC% attack, if you have 1 or more non-lock red or orange tokens, you may perform a bonus attack against a different target. """
        '"Nightfall"':
           text: """After you fully execute a maneuver or perform a %BOOST% action, each ship you moved through gains 2 jam tokens. """
        '"Whirlwind"':
           text: """Before you engage, you may remove any number of jam tokens, then you may gain 1 focus token for each enemy ship that has you in its %FRONTARC%. """
        "709th Legion Ace":
           text: """"""
        "Red Fury Zealot":
           text: """"""
        "Sienar-Jaemus Test Pilot":
           text: """"""
        "First Order Cadet":
           text: """"""
        '"Grudge"':
           text: """While a friendly bomb or mine at range 0-2 detonates, each time attack dice are rolled to resolve its effect, you may reroll up to 1 of those dice. """
        '"Dread"':
           text: """After you reload, each ship in your %BULLSEYEARC% gains 1 deplete token. """
        '"Scorch" (TIE/Se Bomber)':
           display_name: '''"Scorch"'''
           text: """While a friendly ship at range 0-1 performs a primary attack, it may spend 1 %HIT% result. If it does, after defending, the defender gains 1 strain token. """
        '"Breach"':
           text: """After you fully execute a maneuver or perform a %BOOST% action, if you moved through an enemy ship, you may acquire a lock on that ship. """
        "Fenn Rau (Rebel Fang)":
           display_name: """Fenn Rau"""
           text: """Before a friendly ship at range 1-2 engages, if there is an enemy ship in its %FRONTARC% at range 1, that friendly ship may remove 1 non-lock red token. """
        "Bodica Venj":
           display_name: """Bodica Venj"""
           text: """After another friendly ship defends, if you are not depleted, you may perform a bonus primary attack against the attacker. If you do, after performing that attack, gain 1 deplete token. """
        "Dirk Ullodin":
           display_name: """Dirk Ullodin"""
           text: """After you fully execute a red maneuver or perform a red action, you may acquire a lock on an enemy ship in your %FRONTARC% at range 1. """
        "Clan Wren Volunteer":
           display_name: """Clan Wren Volunteer"""
           text: """While you perform an attack at range 1, if the speed of your maneuver matches that of a friendly ship at range 1, you may reroll 1 attack die. """
        "Mandalorian Royal Guard":
           display_name: """Mandalorian Royal Guard"""
           text: """While a friendly non-small ship defends, if you are in the attack arc, you may gain 1 deplete and 1 strain token. If you do, the defender may change 1 result to an %EVADE% result. """
        "ISB Jingoist":
           display_name: """ISB Jingoist"""
           text: """Before you engage, you may choose 1 enemy ship in your %FRONTARC% at range 0-1. If you do, that ship gains 1 deplete or strain token of your choice unless it chooses to remove 1 green token."""
        "Moff Gideon":
           display_name: """Moff Gideon"""
           text: """While an enemy ship at range 1-3 defends, before attack dice are rolled, you may spend 1 %CHARGE% and choose a friendly ship at range 0-1 of the defender. If you do, defense dice cannot be modified during this attack and the chosen friendly ship gains 1 strain token."""
        "Maul":
           display_name: """Maul"""
           text: """While you perform a %COORDINATE% action, if you choose a ship with an initiative lower than yours, you may spend 1 %FORCE%. If you do, treat the action as white and you may coordinate 1 additional friendly ship with an initiative lower than yours; each friendly ship you coordinate this way gains 1 strain token."""
        "Bo-Katan Kryze":
           display_name: """Bo-Katan Kryze"""
           text: """Before a friendly ship at range 0-2 activates, you may spend 1 %CHARGE%. If you do, that ship may gain 1 strain token to remove 1 non-stress red or orange token."""
        "Bo-Katan Kryze (Republic)":
           display_name: """Bo-Katan Kryze"""
           text: """After you fully execute a maneuver, you may gain 1 deplete token to choose an object in your %FRONTARC% at range 1-2. If you do, another friendly ship may perform a %LOCK% action to lock that object."""
        "Captain Hark":
           display_name: """Captain Hark"""
           text: """After you reveal a [0 %STOP%] maneuver, if you are equipped with <b>Swivel Wings (Down)</b>, you <b>must</b> execute a [1 %BANKLEFT%] or [1 %BANKRIGHT%] sideslip maneuver of the same difficulty instead. After you execute that maneuver, you <b>must</b> flip <b>Swivel Wings (Down)</b>."""
        "Gar Saxon":
           display_name: """Gar Saxon"""
           text: """While a friendly unit at range 0-2 performs a primary attack, if the attacker is in the defender's %REARARC%, you may spend 1 %CHARGE%. If you do, the attacker rolls 1 additional die."""
        "Pre Vizsla":
           display_name: """Pre Vizsla"""
           text: """While you perform an attack, if the defender's initiative is equal to or greater than yours, you may spend 2 %CHARGE% to roll 1 additional die."""
        "Pre Vizsla":
           display_name: """Pre Vizsla"""
           text: """While you perform an attack, if the defender's initiative is equal to or greater than yours, you may spend 2 %CHARGE% to roll 1 additional die."""
        "Rook Kast":
           display_name: """Rook Kast"""
           text: """Before you engage, you may gain 1 strain token. While you perform a primary attack, if you are strained, you may change 1 of your blank or %FOCUS% results to a %HIT% result."""
        "Ezra Bridger (Gauntlet Fighter)":
           display_name: """Ezra Bridger"""
           text: """While you defend or perform an attack, if you are stressed, you may spend 1 %FORCE% to change up to 2 of your %FOCUS% results to %EVADE% or %HIT% results."""
        '"Chopper" (Gauntlet Fighter)':
           display_name: """Chopper"""
           text: """At the start of the Engagement Phase, each enemy ship at range 0 gains 2 jam tokens."""
        "The Mandalorian":
           display_name: """The Mandalorian"""
           text: """While you defend or perform an attack, if you are in the %FRONTARC% at range 1-2 of 2 or more enemy ships, you may change 1 of your blank results to a %FOCUS% result."""
        "Q9-0":
           display_name: """Q9-0"""
           text: """After you fully execute an advanced maneuver, you may perform a %CALCULATE% or %BARRELROLL% action, even while stressed. If you do, gain 1 strain token."""
        "Guild Bounty Hunter":
           display_name: """Guild Bounty Hunter"""
           text: """While you perform an attack at attack range 1-2, you may spend 1 non-recurring %CHARGE% from 1 of your equipped %ILLICIT% upgrades to change 1 %FOCUS% result to a %CRIT% result."""
        "Cad Bane":
           display_name: """Cad Bane"""
           text: """After you perform an attack that hits, you may spend 2 %CHARGE% to transfer 1 of your non-lock red or orange tokens to the defender. """
        "Cad Bane (Separatist)":
           display_name: """Cad Bane"""
           text: """During the Engagement Phase, after another ship at range 0-3 is destroyed, you may spend 1 %CHARGE% to perform an action, even while stressed. """
        "Viktor Hel (Rogue)":
           display_name: """Viktor Hel"""
           text: """After you defend, if you did not roll exactly 2 defense dice, the attacker gains 1 stress token. """
        "Nom Lumb (Rogue)":
           display_name: """Nom Lumb"""
           text: """At the start of the Engagement Phase, you may choose 1 enemy ship in your %FRONTARC%. If you do, treat your initiative as equal to that ship's until the end of the round. """
        "Outer Rim Hunter":
           display_name: """Outer Rim Hunter"""
           text: """"""
        "IG-101":
           display_name: """IG-101"""
           text: """At the start of the System Phase, you may repair 1 faceup damage card. """
        "IG-102":
           display_name: """IG-102"""
           text: """While you defend, if the attacker's initiative is equal to or greater than yours, you may change 1 blank result to a %FOCUS% result. """
        "IG-111":
           display_name: """IG-111"""
           text: """After you perform an attack that missed, you may choose 1 enemy ship in your %BULLSEYEARC% and gain 1 deplete token. If you do, that ship suffers 1 %HIT% damage. """
        "MagnaGuard Executioner":
           display_name: """MagnaGuard Executioner"""
           text: """"""
        "MagnaGuard Protector":
           display_name: """MagnaGuard Protector"""
           text: """<strong>Setup:</strong> After placing forces, assign the <b>Guarded</b> condition to 1 friendly ship other than the <b>MagnaGuard Protector</b> """
        '"Killer"':
           display_name: """“Killer”"""
           text: """While you perform an attack, if the defender has 2 or fewer hull remaining, you may roll 1 additional attack die. If you do, gain 1 deplete token after rolling attack dice. """
        '"Drift"':
           display_name: """“Drift”"""
           text: """While a friendly ship at range 0-1 performs an attack, if you have exactly 1 non-lock red token or exactly 1 orange token, that ship may reroll 1 attack die. """
        '"Boost"':
           display_name: """“Boost”"""
           text: """At the start of the Engagement Phase, if there is a friendly ship at range 0-1 whose revealed maneuver is blue, you may perform a %BOOST% action."""
        '"Stub"':
           display_name: """“Stub”"""
           text: """While you defend, if the speed of your revealed maneuver is even, roll 1 additional defense die. While you perform a primary attack, if the speed of your revealed maneuver is odd, roll 1 additional attack die. """
        '"Hawk" (Z-95)':
           display_name: """“Hawk”"""
           text: """At the start of the End Phase, each friendly ship at range 0-1 that has a revealed maneuver of speed 3-5 may gain 1 strain token to perform a %BARRELROLL% or %BOOST% action.  """
        '"Slider"':
           display_name: """“Slider”"""
           text: """When you reveal a [2 %BANKLEFT%] or [2 %BANKRIGHT%] maneuver, you may spend 2 %CHARGE% to execute it as a sideslip. """
        '"Warthog" (Z-95)':
           display_name: """“Warthog”"""
           text: """After you or a friendly non-limited ship at range 0-2 are destroyed during the Engagement Phase, that ship is not removed until the end of that phase. """
        '"Knack"':
           display_name: """“Knack”"""
           text: """After you are destroyed, you may choose a friendly non-limited ship at range 0-2 and assign 1 of your equipped %TALENT% upgrades to it. %LINEBREAK% <strong>End of Game:</strong> Return all %TALENT% upgrades to their original ships. """
        "Reaper Squadron Scout":
           display_name: """Reaper Squadron Scout"""
           text: """"""

        # Battle of Yavin Pilots
        "Han Solo (BoY)":
           display_name: """Han Solo (BoY)"""
           text: """After performing an attack that hits, you may spend 1 %CHARGE% to perform a %COORDINATE% action."""
        "Garven Dreis (BoY)":
           display_name: """Garven Dreis (BoY)"""
           text: """After you spend a focus token, you may choose 1 friendly ship at range 1-3. That ship gains 1 focus token."""
        "Luke Skywalker (BoY)":
           display_name: """Luke Skywalker (BoY)"""
           text: """After you become the defender (before dice are rolled), you may recover 1 %FORCE%."""
        "Wedge Antilles (BoY)":
           display_name: """Wedge Antilles (BoY)"""
           text: """While you perform a primary attack, if there is another friendly ship in the defender's firing arc, the defender rolls 1 less defense dice."""
        "Biggs Darklighter (BoY)":
           display_name: """Biggs Darklighter (BoY)"""
           text: """During the System Phase, you may choose 1 friendly ship at range 1. If you do, treat your initiative as equal to the chosen ship's initiative until the end of the Activation Phase."""
        "Jek Porkins (BoY)":
           display_name: """Jek Porkins (BoY)"""
           text: """After you receive a stress token, you may roll 1 attack die to remove it. On a %HIT% result, suffer 1 %HIT% damage."""
        "Hol Okand (BoY)":
           display_name: """Hol Okand (BoY)"""
           text: """During the System Phasse, if there are no enemy ships at range 1-2, you may recover 1 %CHARGE% on any upgrade."""
        '"Pops" Krail (BoY)':
           display_name: """“Pops” Krail (BoY)"""
           text: """While you perform a %SINGLETURRETARC% attack, you may reroll up to 2 attack dice."""
        '"Dutch" Vander (BoY)':
           display_name: """“Dutch” Vander (BoY)"""
           text: """After you spend a lock during an attack, choose a friendly ship at range 1-3. The chosen ship may acquire a lock on the defender. %LINEBREAK% <i>Errata (since rules reference 1.4.4): Corrected pilot ability and adjusted initiative value</i>"""
        "Dex Tiree (BoY)":
           display_name: """Dex Tiree (BoY)"""
           text: """While you defend, if there is at least 1 other friendly ship at range 0-1, you may roll 1 additional defense die."""
        '"Wampa" (BoY)':
           display_name: """“Wampa” (BoY)"""
           text: """While you perform an attack, you may spend 1 %CHARGE% to roll 1 additional attack die.%LINEBREAK%After defending, lose 1 %CHARGE%."""
        '"Dark Curse" (BoY)':
           display_name: """“Dark Curse” (BoY)"""
           text: """While you defend, the attacker's dice cannot be modified."""
        "Darth Vader (BoY)":
           display_name: """Darth Vader (BoY)"""
           text: """While you perform an attack, you may spend 1 %FORCE% to change 1 blank result to a %HIT% result."""
        "Iden Versio (BoY)": 
           display_name: """Iden Versio (BoY)"""
           text: """Before a friendly TIE at range 0-1 would suffer damage, you may spend 2 %CHARGE%. If you do, prevent 1 damage. <i>Errata (since rules reference 1.4.4): Corrected pilot ability</i>"""
        '"Backstabber" (BoY)': 
           display_name: """“Backstabber” (BoY)"""
           text: """While you perform a primary attack, if a friendly Darth Vader or "Mauler" Mithel is in your %LEFTARC% or %RIGHTARC% at range 0-1, roll 1 additional attack die."""
        "Sigma 4 (BoY)":
           display_name: """Sigma 4 (BoY)"""
           text: """After you perform a %BARRELROLL% action, you may spend 1 %CHARGE% to perform a %BOOST% action."""
        "Sigma 5 (BoY)":
           display_name: """Sigma 5 (BoY)"""
           text: """After you perform an attack that hits, you may spend 1 %CHARGE% to perform an %EVADE% action."""
        "Sigma 6 (BoY)":
           display_name: """Sigma 6 (BoY)"""
           text: """After you fully execute a speed 3-5 maneuver, you may spend 1 %CHARGE% to perform a %SLAM% action."""
        "Sigma 7 (BoY)":
           display_name: """Sigma 7 (BoY)"""
           text: """During the System Phase, you may spend 1 %CHARGE% to acquire a lock on an enemy ship at range 0-1."""
        '"Mauler" Mithel (BoY)':
           display_name: """“Mauler” Mithel (BoY)"""
           text: """While you perform a primary attack, if a friendly Darth Vader or "Backstabber" is in your %LEFTARC% or %RIGHTARC% at range 0-1, roll 1 additional attack die."""

        # Siege of Coruscant Pilots
        "Anakin Skywalker (SoC)":
           display_name: """Anakin Skywalker (SoC)"""
           text: """After you or a friendly <b>Obi-Wan Kenobi</b> ship at range 0-3 fully executes a maneuver, if there are more enemy ships than other friendly ships at range 0-1 of that ship, you may spend 1 %FORCE%. If you do, that ship may perform a %BARRELROLL% action."""
        "Obi-Wan Kenobi (SoC)":
           display_name: """Obi-Wan Kenobi (SoC)"""
           text: """After you or a friendly <b>Anakin Skywalker</b> at range 0-3 fully executes a maneuver, if there are more enemy ships than other friendly ships at range 0-1 of that ship, you may spend 1 %FORCE%. If you do, that ship may perform a %BOOST% action."""
        "Shaak Ti (SoC)":
           display_name: """Shaak Ti (SoC)"""
           text: """At the start of the End Phase, you may perfrom a purple %COORDINATE% action, even while stressed %LINEBREAK% After you perform a %COORDINATE% action, if the chosen ship has the <b>Born for This</b> ship ability, you may coordinate 1 additional ship."""
        '"Odd Ball" (SoC)':
           display_name: """“Odd Ball” (SoC)"""
           text: """After you fully execute a red maneuver or perform a red action, you camy choose a friendly ship at range 0-3 and an enemy at range 0-1. The chosen frendly ship gains a lock on the enemy ship."""
        '"Wolffe" (SoC)':
           display_name: """“Wolffe” (SoC)"""
           text: """While you perform a primary %FRONTARC% attack, you may spend 1 %CHARGE% to reroll 1 attack die. While you perform a primary %REARARC% attack, you may recover 1 %CHARGE% to roll 1 additional die."""
        '"Jag" (SoC)':
           display_name: """“Jag” (SoC)"""
           text: """After a friendly ship at range 0-2 in your %LEFTARC% or %RIGHTARC% performs an attack, if you are not strained, you may acquire a lock on the defender."""
        '"Contrail" (SoC)':
           display_name: """“Contrail” (SoC)"""
           text: """While you defend or perform an attack, if the bearing of your revealed maneuver is the same as the enemy ship's, you may change 1 of the enemy ship's %FOCUS% results to a blank result. """
        '"Klick" (SoC)':
           display_name: """“Klick” (SoC)"""
           text: """While a ship that you have locked at range 1-3 defends or performs an attack, you may spend 1 %CHARGE% to prevent range bonuses from being applied. """
        '"Kickback" (SoC)':
           display_name: """“Kickback” (SoC)"""
           text: """After you perform a %BARRELROLL% action, you may perform a red %LOCK% action. If you do, before you perfrom the %LOCK% action, you may gain 1 strain to treat it as white."""
        '"Axe" (SoC)':
           display_name: """“Axe” (SoC)"""
           text: """After you perform an attack, you may choose another friendly ship with the <b>Born for This</b> ability at range 0-2 in your %LEFTARC% or %RIGHTARC%. The chosen ship gains a lock on the defender."""
        "Count Dooku (SoC)":
           display_name: """Count Dooku (SoC)"""
           text: """During an attack, before a ship at range 0-2 rolls attack or defense dice, if all of your %FORCE% are active, you may spend 1 %FORCE% and name a result. If the roll does not contain the named result, the ship must change 1 die to that result."""
        "DBS-32C (SoC)":
           display_name: """DBS-32C (SoC)"""
           text: """After you perform a %CALCULATE% action, you may spend 1 %CHARGE% to perform a %JAM% action."""
        "DBS-404 (SoC)":
           display_name: """DBS-404 (SoC)"""
           text: """While you perform an attack at range 1, you <b>must</b> roll 1 additional die. After the attack hits, suffer 1 %CRIT% damage."""
        "Baktoid Prototype (SoC)":
           display_name: """Baktoid Prototype (SoC)"""
           text: """While you perform a special attack, if a friendly ship with the <strong>Networked Calculations</strong> ship ability has a lock on the defender, you may ingore the %FOCUS%, %CALCULATE% or %LOCK% requirement of the attack."""
        "DIS-347 (SoC)":
           display_name: """DIS-347 (SoC)"""
           text: """At the start of the Engagement Phase, you may acquire a lock on an object at range 1-3 that has a friendly lock."""
        "DIS-T81 (SoC)":
           display_name: """DIS-T81 (SoC)"""
           text: """While you defend or perform an attack, you may reroll any number of your dice. Then if you were defending, gain 1 strain token for each die that was rerolled. If you were attacking, gain 1 deplete token for each die that was rerolled instead."""
        "Phlac-Arphocc Prototype (SoC)":
           display_name: """Phlac-Arphocc Prototype (SoC)"""
           text: """At the start of the Engagement Phase, if there is an enemy ship in your %BULLSEYEARC%, gain a calculate token"""
        "DFS-081 (SoC)":
           display_name: """DFS-081 (SoC)"""
           text: """While defending, you may spend 1 %CHARGE% and 1 calculate token to cancel 1 %CRIT% result."""
        "DFS-311 (SoC)":
           display_name: """DFS-311 (SoC)"""
           text: """At the start of the Engagement Phase, you may transfer 1 of your calculate tokens to another friendly ship at range 0-3."""
        "Haor Chall Prototype (SoC)":
           display_name: """Haor Chall Prototype (SoC)"""
           text: """After an enemy ship in your %BULLSEYEARC% declares a scenario feature or another friendly ship as the defender, you may perform a %CALCULATE% or %LOCK% action."""

        # Hotshots and Aces 2
        "Corran Horn (X-Wing)":
           display_name: """Corran Horn"""
           text: """After you declare the defender of an attack, if you have a lock on the defender, a friendly ship may transfer their lock token from you to the defender."""
        "Wes Janson":
           display_name: """Wes Janson"""
           text: """After you perform an attack, you may spend 1 %CHARGE% to assign the defender 1 jam token. %LINEBREAK% After you defend, you may spend 1 %CHARGE% to assign the attacker 1 jam token."""
        "Tycho Celchu":
           display_name: """Tycho Celchu"""
           text: """While you have 2 or fewer stress tokens, you may perform actions, even while stressed."""
        "Keo Venzee":
           display_name: """Keo Venzee"""
           text: """If you have no active %FORCE%, after you reveal a bank [%BANKLEFT% or %BANKRIGHT%] or turn [%TURNLEFT% or %TURNRIGHT%] maneuver, you may increase the difficulty of the maneuver. If you do, perform that maneuver as a sideslip and recover 1 %FORCE%."""
        '"Pops" Krail':
           display_name: """“Pops” Krail"""
           text: """After you fully execute a white maneuver, you may choose a friendly ship at range 0-1. If you do, it may perform a %FOCUS% action."""
        "Flight Leader Ubbel":
           display_name: """Flight Leader Ubbel"""
           text: """After a friendly ship at range 0-2 defends, if it was dealt a damage card, you may perform a bonus attack against the attacker."""
        "Juno Eclipse":
           display_name: """Juno Eclipse"""
           text: """After you perform an action, you may perform a red %BOOST% action."""
        "Second Sister":
           display_name: """Second Sister"""
           text: """While you perform an attack, after the Neutralize Results step, if the attack hit, you may spend 2 %FORCE%. If you do, change all of your %HIT% results to %CRIT% results."""
        "Magna Tolvan":
           display_name: """Magna Tolvan"""
           text: """While you have 2 or fewer stress tokens, you can perform white actions, even while stressed. %LINEBREAK% After you gain a stress token, you may perform a white action, if able."""
        "Yrica Quell":
           display_name: """Yrica Quell"""
           text: """After you fully execute a maneuver, you may acquire a lock on an enemy ship in your %BULLSEYEARC%."""
        "Poe Dameron (YT-1300)":
           display_name: """Poe Dameron"""
           text: """Before you execute a maneuver, you may spend 1 %CHARGE%. If you do, ignore obstacles during that maneuver.%LINEBREAK% After you fully execute a maneuver, you may spend 2 %CHARGE% to perform a white %BOOST% or red %BARRELROLL% action. Then if you performed a red %BARRELROLL% action, expose 1 damage card, if able."""
        "Lando Calrissian (Resistance)":
           display_name: """Lando Calrissian"""
           text: """After you fully execute a red maneuver or perform a red action, you may spend any number of %CHARGE% to choose that many friendly ships at range 0-2. The chosen ships may perform an action, even while stressed."""
        "Venisa Doza":
           display_name: """Venisa Doza"""
           text: """While you perform a %TORPEDO% or %MISSILE% attack, you may treat the %FRONTARC% requirement as %REARARC% for that attack. If you do, treat the range requirement as 1-2."""
        "Zay Versio":
           display_name: """Zay Versio"""
           text: """While you defend, if the attacker is damaged, you may reroll 1 defense die."""
        "Taka Jamoreesa":
           display_name: """Taka Jamoreesa"""
           text: """After you jam, you <b>must</b> assign 1 jam token to another ship at range 0-1 of the jammed ship, if able."""
        "Hondo Ohnaka":
           display_name: """Hondo Ohnaka"""
           text: """<strong>Action:</strong> Choose 2 non-huge ships at range 0-3 of you that are not friendly to each other. Each chosen ship may perform an action that is on your action bar, even while stressed, in the order of your choice. Then, gain 1 calculate token."""
        "Tor Phun":
           display_name: """Tor Phun"""
           text: """After you perform an attack, if the defender was destroyed, you may perform an action, even while stressed. Then you may gain 2 strain tokens to perform a bonus attack."""
        "Durge":
           display_name: """Durge"""
           text: """While you defend, after the Neutralize Results step, if there are more %HIT%/%CRIT% results than your active %SHIELD%, you may change 1 %HIT% result to a %CRIT% and cancel 1 %HIT% result."""
        "Doctor Aphra":
           display_name: """Doctor Aphra"""
           text: """Before you engage, you may spend 1 green token and 1 %CHARGE%. If you do, you may choose another ship at range 0-1 that is not stressed. The chosen ship gains 1 stress token."""
        "Lapin":
           display_name: """Lapin"""
           text: """While you defend or perform an attack, if the enemy ship is stressed, that ship's dice cannot be modified."""
        "Volan Das":
           display_name: """Volan Das"""
           text: """After you fully execute a red maneuver, you may chose an enemy ship at range 1. The chosen ship gains 1 strain token and you may remove 1 stress token."""
        "Aurra Sing":
           display_name: """Aurra Sing"""
           text: """Before you engage, you may spend 1 %FORCE% to choose 2 enemy ships at range 0-1. Transfer any number of orange and red tokens between those two ships."""
        "Durge (Separatist)":
           display_name: """Durge"""
           text: """When you would be destroyed, you may spend 1 %CHARGE% to reveal all of your facedown damage cards. If you do, discard each <strong>Direct Hit!</strong> and each of your damage cards with the <strong>Pilot</strong> trait, then repair all of your faceup damage cards."""
        "The Iron Assembler":
           display_name: """The Iron Assembler"""
           text: """After a friendly ship at range 0-1 skips its execute maneuver step, you may spend 1 %CHARGE%. If you do, if there is an asteroid or debris cloud at range 0 of it, that ship may repair 1 damage."""
        "Kelrodo-Ai Holdout":
           display_name: """Kelrodo-Ai Holdout"""
           text: """After you are destroyed, you may transfer each of your locks and green tokens to another friendly Kelrodo-Ai Holdout at range 0-3"""
        "Lieutenant Galek":
           display_name: """Lieutenant Galek"""
           text: """After another friendly ship at range 0-2 is destroyed, you may perform a %COORDINATE% action, even while stressed. While you coordinate, the ship you choose can perform an action only if that action is also on your action bar."""
        "Jul Jerjerrod":
           display_name: """Jul Jerjerrod"""
           text: """After you perform a %BOOST% action, you may spend 1 %CHARGE% to remove 1 non-lock red or orange token."""
        "DT-798":
           display_name: """DT-798"""
           text: """While you perform a primary attack, if you are not strained, you may gain 1 strain token to roll 1 additional die."""
        "Lin Gaava":
           display_name: """Lin Gaava"""
           text: """<strong>Setup:</strong> After placing forces, assign the <strong>Primed for Speed</strong> condition to yourself and up to 2 other friendly TIE/fo or TIE/sf Fighters that have no equipped %MODIFICATION% upgrades."""
        "Agent Tierny":
           display_name: """Agent Tierny"""
           text: """<strong>Setup:</strong> After placing forces, you <b>must</b> assign the <strong>Broken Trust</strong> condition to an enemy ship."""
        "Adi Gallia":
           display_name: """Adi Gallia"""
           text: """While you defend at attack range 1, you may spend 1 %FORCE%. If you do, the attacker cannot apply the range bonus. %LINEBREAK% While you perform an attack against a defender at attack range 3, you may spend 1 %FORCE%, the defender cannot apply the range bonus."""
        "Adi Gallia (Delta-7B)":
           display_name: """Adi Gallia"""
           text: """While you defend at attack range 1, you may spend 1 %FORCE%. If you do, the attacker cannot apply the range bonus. %LINEBREAK% While you perform an attack against a defender at attack range 3, you may spend 1 %FORCE%, the defender cannot apply the range bonus."""
        '"Sicko"':
           display_name: """“Sicko”"""
           text: """After you execute a basic maneuver, you may assign the <strong>Sickening Maneuver</strong> condition to yourself."""
        "Kit Fisto":
           display_name: """Kit Fisto"""
           text: """While another friendly ship defends, if the attacker is in its %BULLSEYEARC%, you may spend 1 %FORCE% to change 1 of the defender's blank results to a %FOCUS% result."""
        '"Slammer"':
           display_name: """“Slammer”"""
           text: """After you fully execute a maneuver, you may spend 2 %CHARGE% to peform a %SLAM% action, even while stressed."""
        "Gavyn Sykes":
           display_name: """Gavyn Sykes"""
           text: """While you defend or perfrom an attack, if the speed of your revealed maneuver is greater than the enemy ship's, you may reroll your blank results."""


        # Epic Ships
        "Republic Judiciary":
           display_name: """Republic Judiciary"""
           text: """<i class = flavor_text>The Galactic Republic uses small, swift warships such as the CR90 corvette to respond rapidly to Separatist incursions across the galaxy.</i> %LINEBREAK% <strong>Broadside Batteries:</strong> You can acquire locks and perform primary attacks at range 1-4."""
        "Alderaanian Guard":
           display_name: """Alderaanian Guard"""
           text: """<i class = flavor_text>A craft used since before the Clone Wars, the CR90 corvette is favored by the Royal House of Alderaan for its versatility.</i> %LINEBREAK% <strong>Broadside Batteries:</strong> You can acquire locks and perform primary attacks at range 1-4."""
        "Outer Rim Patrol":
           display_name: """Outer Rim Patrol"""
           text: """<i class = flavor_text>The <untalic>Raider</untalic>-class corvette is one of the Empire's smallest warships, often used for reconnaissance missions, surgical strikes, or suppressing enemy starfighters with its powerful ordnance.</i> %LINEBREAK% <strong>Concentrated Batteries:</strong> While you perform a primary, %TORPEDO%, or %MISSILE% attack, if the defender is in your %BULLSEYEARC%, roll 1 additional die."""
        "First Order Collaborators":
           display_name: """First Order Collaborators"""
           text: """<i class = flavor_text>The First Order's supporters make use of former Imperial vessels, such as the <untalic>Raider</untalic>-class corvette. Though it has outlived the regime that created it, this craft still spreads terror across the galaxy.</i> %LINEBREAK% <strong>Concentrated Batteries:</strong> While you perform a primary, %TORPEDO%, or %MISSILE% attack, if the defender is in your %BULLSEYEARC%, roll 1 additional die."""
        "Echo Base Evacuees":
           display_name: """Echo Base Evacuees"""
           text: """<i class = flavor_text>The GR-75 medium transport acquitted itself well at battles such as the evacuation of Hoth, where several of these ships were pivotal to the Rebel forces' escape.</i> %LINEBREAK% <strong>Resupply Craft:</strong> After another friendly ship at range 0-1 performs an action, you may spend 1 %ENERGY%. If you do, it removes 1 orange or red token, or recovers 1 shield."""
        "New Republic Volunteers":
           display_name: """New Republic Volunteers"""
           text: """<i class = flavor_text>In use since the Galactic Civil War, groups within the New Republic still utilize the GR-75 medium transport for supply and aid missions.</i> %LINEBREAK% <strong>Resupply Craft:</strong> After another friendly ship at range 0-1 performs an action, you may spend 1 %ENERGY%. If you do, it removes 1 orange or red token, or recovers 1 shield."""
        "Outer Rim Garrison":
           display_name: """Outer Rim Garrison"""
           text: """<i class = flavor_text>Capable of carrying TIE fighters and operating independently for long periods of time, the <untalic>Gozanti</untalic>-class cruiser is a common sight in the skies of downtrodden worlds across the Outer Rim.</i> %LINEBREAK% <strong>Docking Clamps:</strong> You can dock up to 4 small ships."""
        "First Order Sympathizers":
           display_name: """First Order Sympathizers"""
           text: """<i class = flavor_text>The First Order's swift rise to power rests upon ruthless innovation. However, sympathizers often repurpose Imperial designs, like the venerable <untalic>Gozanti</untalic>-class cruiser, in surveillance and patrol operations.</i> %LINEBREAK% <strong>Docking Clamps:</strong> You can dock up to 4 small ships."""
        "Separatist Privateers":
           display_name: """Separatist Privateers"""
           text: """<i class = flavor_text>The Separatist Alliance makes use of all manner of unsavory contacts in its fight against the Galactic Republic, including corsairs and criminal cartels.</i> %LINEBREAK% <strong>Overdrive Burners:</strong> While you defend, if your revealed maneuver is speed 3-5, roll 1 additional defense die."""
        "Syndicate Smugglers":
           display_name: """Syndicate Smugglers"""
           text: """<i class = flavor_text>Vessels like the C-ROC Cruiser allow criminal operations across the Outer Rim to move massive amounts of illicit materials, or project power that can bully small colonies into compliance.</i> %LINEBREAK% <strong>Overdrive Burners:</strong> While you defend, if your revealed maneuver is speed 3-5, roll 1 additional defense die."""
        "Colicoid Destroyer":
           display_name: """Colicoid Destroyer"""
           text: """<i class = flavor_text>Designed by the Colicoid Creation Nest and equipped with powerful tentacles and a massive drill to tear through the hull of even the toughest starships and fortifications, the Trident-class Assault Ship is a terrifying testament to the threat posed by the Separatist Alliance.</i> %LINEBREAK% <strong>Tractor Grasp:</strong> After you perform a <b>Tractor Tentacles</b> attack that hits, the defender gains 1 tractor token."""
        "Lawless Pirates":
           display_name: """Lawless Pirates"""
           text: """<i class = flavor_text>The Separatist Alliance has close ties to certain mercenaries and criminal groups and, as the war rages on, its technology sometimes finds its way into unsavory hands.</i> %LINEBREAK% <strong>Tractor Grasp:</strong> After you perform a <b>Tractor Tentacles</b> attack that hits, the defender gains 1 tractor token."""

    upgrade_translations =
        "0-0-0":
           display_name: """0-0-0"""
           text: """At the start of the Engagement Phase, you may choose 1 enemy ship at range 0-1. If you do, you gain 1 calculate token unless that ship chooses to gain 1 stress token."""
        "4-LOM":
           display_name: """4-LOM"""
           text: """While you perform an attack, after rolling attack dice, you may name a type of green token. If you do, gain 2 ion tokens and, during this attack, the defender cannot spend tokens of the named type."""
        "Andrasta":
           display_name: """Andrasta"""
           text: """ """
        "Black One":
           display_name: """Black One"""
           text: """After you perform a %SLAM% action, lose 1 %CHARGE%. Then you may gain 1 ion token to remove 1 disarm token.%LINEBREAK%If your %CHARGE% is inactive, you cannot perform the %SLAM% action."""
        "Dauntless":
           display_name: """Dauntless"""
           text: """After you partially execute a maneuver, you may perform 1 white action, treating that action as red."""
        "Ghost":
           display_name: """Ghost"""
           text: """You can dock 1 attack shuttle or Sheathipede-class shuttle.%LINEBREAK%Your docked ships can deploy only from your rear guides."""
        "Havoc":
           display_name: """Havoc"""
           text: """  """
        "Hound's Tooth":
           display_name: """Hound's Tooth"""
           text: """1 Z-95-AF4 headhunter can dock with you."""
        "IG-2000":
           display_name: """IG-2000"""
           text: """You have the pilot ability of each other friendly ship with the <strong>IG-2000</strong> upgrade."""
        "Marauder":
           display_name: """Marauder"""
           text: """While you perform a primary %REARARC% attack, you may reroll 1 attack die."""
        "Millennium Falcon":
           display_name: """Millennium Falcon"""
           text: """While you defend, if you are evading, you may reroll 1 defense die."""
        "Mist Hunter":
           display_name: """Mist Hunter"""
           text: """ """
        "Moldy Crow":
           display_name: """Moldy Crow"""
           text: """Gain a %FRONTARC% primary weapon with a value of “3.”%LINEBREAK%During the End Phase, do not remove up to 2 focus tokens."""
        "Outrider":
           display_name: """Outrider"""
           text: """ While you perform an attack that is obstructed by an obstacle, the defender rolls 1 fewer defense die. %LINEBREAK% After you fully execute a maneuver, if you moved through or overlapped an obstacle, you may remove 1 of your red or orange tokens. %LINEBREAK% <i>Errata (since rules reference 1.0.2): changed "obstructed attack" to "an attack that is obstructed by an obstacle"</i>"""
        "Phantom":
           display_name: """Phantom"""
           text: """You can dock at range 0-1."""
        "Punishing One":
           display_name: """Punishing One"""
           text: """While you perform a primary attack, if the defender is in your %FRONTARC%, roll 1 additional attack die."""
        "ST-321":
           display_name: """ST-321"""
           text: """After you perform a %COORDINATE% action, you may choose an enemy ship at range 0-3 of the ship you coordinated. If you do, acquire a lock on that enemy ship, ignoring range restrictions."""
        "Scimitar":
           display_name: """Scimitar"""
           text: """<strong>Setup:</strong> After the Place Forces step, you may cloak.%LINEBREAK%After you decloak, you may choose an enemy ship in your %BULLSEYEARC%. If you do, it gains 1 jam token."""
        "Shadow Caster":
           display_name: """Shadow Caster"""
           text: """After you perform an attack that hits, if the defender is in your %SINGLETURRETARC% and your %FRONTARC%, the defender gains 1 tractor token."""
        "Slave I":
           display_name: """Slave I"""
           text: """After you reveal a turn (%TURNLEFT% or %TURNRIGHT%) or bank (%BANKLEFT% or %BANKRIGHT%) maneuver you may set your dial to the maneuver of the same speed and bearing in the other direction. %LINEBREAK%<i>Errata (since rules reference 1.0.2): removed "you may gain 1 stress token. If you do,"</i>"""
        "Virago":
           display_name: """Virago"""
           text: """During the End Phase, you may spend 1 %CHARGE% to perform a red %BOOST% action."""
        "Soulless One":
           display_name: """Soulless One"""
           text: """While you defend, if the attacker is outside your firing arc, you may reroll 1 defense die."""
        "Ablative Plating":
           display_name: """Ablative Plating"""
           text: """Before you would suffer damage from an obstacle or from a friendly bomb detonating, you may spend 1 %CHARGE%. If you do, prevent 1 damage."""
        "Admiral Sloane":
           display_name: """Admiral Sloane"""
           text: """After another friendly ship at range 0-3 defends, if it is destroyed, the attacker gains 2 stress tokens.%LINEBREAK%While a friendly ship at range 0-3 performs an attack against a stressed ship, it may reroll 1 attack die."""
        "Adv. Proton Torpedoes":
           display_name: """Adv. Proton Torpedoes"""
           text: """<strong>Attack (%LOCK%):</strong> Spend 1 %CHARGE%. Change 1 %HIT% result to a %CRIT% result."""
        "Advanced Optics":
           display_name: """Advanced Optics"""
           text: """While you perform an attack, you may spend 1 focus token to change 1 of your blank results to a %HIT% result."""
        "Advanced SLAM":
           display_name: """Advanced SLAM"""
           text: """After you perform a %SLAM% action, if you fully executed the maneuver, you may perform a white action on your action bar, treating that action as red."""
        "Advanced Sensors":
           display_name: """Advanced Sensors"""
           text: """After you reveal your dial, you may perform 1 action.%LINEBREAK%If you do, you cannot perform another action during your activation."""
        "Afterburners":
           display_name: """Afterburners"""
           text: """After you fully execute a speed 3-5 maneuver, you may spend 1 %CHARGE% to perform a %BOOST% action, even while stressed."""
        "Agent Kallus":
           display_name: """Agent Kallus"""
           text: """<strong>Setup:</strong> After placing forces, assign the <strong>Hunted</strong> condition to 1 enemy ship.%LINEBREAK%While you perform an attack against the ship with the <strong>Hunted</strong> condition, you may change 1 of your %FOCUS% results to a %HIT% result.%LINEBREAK%<i>Errata (since rules reference 1.1.0)</i>:"Added After placing forces,"</i>"""
        "Agile Gunner":
           display_name: """Agile Gunner"""
           text: """During the End Phase, you may rotate your %SINGLETURRETARC% indicator."""
        "Autoblasters":
           text: """<strong>Attack:</strong>If the defender is in your %BULLSEYEARC%, roll 1 additional die. During the Neutralize Results step, if you are not in the defenders %FRONTARC%, %EVADE% results do not cancel %CRIT% results."""
        "BB Astromech":
           display_name: """BB Astromech"""
           text: """During the System Phase, you may spend 1 %CHARGE% to perform a %BARRELROLL% action. %LINEBREAK% <i>Errata (since rules reference 1.4.2): Changed the effect timing to the System Phase</i>"""
        "BB-8":
           display_name: """BB-8"""
           text: """During the System Phase, you may spend 1 %CHARGE% to perform a %BARRELROLL% or %BOOST% action. %LINEBREAK% <i>Errata (since rules reference 1.4.2): Changed the effect timing to the System Phase</i>"""
        "BT-1":
           display_name: """BT-1"""
           text: """While you perform an attack, you may change 1 %HIT% result to a %CRIT% result for each stress token the defender has."""
        "Barrage Rockets":
           display_name: """Barrage Rockets"""
           text: """<strong>Attack (%FOCUS%):</strong> Spend 1 %CHARGE%. If the defender is in your %BULLSEYEARC%, you may spend 1 or more %CHARGE% to reroll that many attack dice."""
        "Battle Meditation":
           display_name: """Battle Meditation"""
           text: """You cannot coordinate limited ships.%LINEBREAK% While you perform a purple %COORDINATE% action, you may coordinate 1 additional friendly non-limited ship of the same type. Both ships must perform the same action."""
        "Baze Malbus":
           display_name: """Baze Malbus"""
           text: """While you perform a %FOCUS% action, you may treat it as red. If you do, gain 1 additional focus token for each enemy ship at range 0-1, to a maximum of 2."""
        "Biohexacrypt Codes":
           display_name: """Biohexacrypt Codes"""
           text: """While you coordinate or jam, if you have a lock on a ship, you may spend that lock to choose that ship, ignoring range restrictions."""
        "Bistan":
           display_name: """Bistan"""
           text: """After you perform a primary attack, if you are focused, you may perform a bonus %SINGLETURRETARC% attack against a ship you have not already attacked this round."""
        "Boba Fett":
           display_name: """Boba Fett"""
           text: """<strong>Setup:</strong> Start in reserve.%LINEBREAK%At the end of Setup, place yourself at range 0 of an obstacle and beyond range 3 of any enemy ship."""
        "Bomblet Generator":
           display_name: """Bomblet Generator"""
           text: """<strong>Bomb</strong>%LINEBREAK%During the System Phase, you may spend 1 %CHARGE% to drop a Bomblet with the [1 %STRAIGHT%] template.%LINEBREAK%At the start of the Activation Phase, you may spend 1 shield to recover 2 %CHARGE%."""
        "Bossk":
           display_name: """Bossk"""
           text: """After you perform a primary attack that misses, if you are not stressed, you <b>must</b> receive 1 stress token to perform a bonus primary attack against the same target."""
        "Brilliant Evasion":
           display_name: """Brilliant Evasion"""
           text: """While you defend, if you are not in the attacker's %BULLSEYEARC%, you may spend 1 %FORCE% to change 2 of your %FOCUS% results to %EVADE% results."""
        "C-3PO":
           display_name: """C-3PO"""
           text: """Before rolling defense dice, you may spend 1 calculate token to guess aloud a number 1 or higher. If you do and you roll exactly that many %EVADE% results, add 1 %EVADE% result.%LINEBREAK%After you perform the %CALCULATE% action, gain 1 calculate token."""
        "C-3PO (Resistance)":
           display_name: """C-3PO"""
           text: """While you coordinate, you can choose friendly ships beyond range 2 if they have %CALCULATE% on their action bar.%LINEBREAK%After you perform the %CALCULATE% or %COORDINATE% action, gain 1 calculate token."""
        "Cad Bane":
           display_name: """Cad Bane"""
           text: """After you drop or launch a device, you may perform a red %BOOST% action."""
        "Calibrated Laser Targeting":
           display_name: """Calibrated Laser Targeting"""
           text: """While you perform a primary attack, if the defender is in your %BULLSEYEARC%, add 1 %FOCUS% result."""
        "Captain Phasma":
           display_name: """Captain Phasma"""
           text: """At the end of the Engagement Phase, each enemy ship at range 0-1 that is not stressed gains 1 stress token."""
        "Cassian Andor":
           display_name: """Cassian Andor"""
           text: """During the System Phase, you may choose 1 enemy ship at range 1-2 and guess aloud a bearing and speed, then look at that ship's dial. If the chosen ship's bearing and speed match your guess, you may set your dial to another maneuver."""
        "Chancellor Palpatine":
           display_name: """Chancellor Palpatine"""
           text: """Chancellor Palpatine:%LINEBREAK%<strong>Setup:</strong> Equip this side faceup.%LINEBREAK%After you defend, if the attacker is at range 0-2, you may spend 1 %FORCE%. If you do, the attacker gains 1 stress token.%LINEBREAK%During the End Phase, you may flip this card.%LINEBREAK%Darth Sidious%LINEBREAK%After you perform a purple %COORDINATE% action, the ship you coordinated gains 1 stress token. Then, it gains 1 focus token or recovers 1 %FORCE%."""
        "Chewbacca":
           display_name: """Chewbacca"""
           text: """At the start of the Engagement Phase, you may spend 2 %CHARGE% to repair 1 faceup damage card."""
        "Chewbacca (Scum)":
           display_name: """Chewbacca"""
           text: """At the start of the End Phase, you may spend 1 focus token to repair 1 of your faceup damage cards."""
        "Chewbacca (Resistance)":
           display_name: """Chewbacca"""
           text: """<strong>Setup:</strong> Lose 1 %CHARGE%.%LINEBREAK%After a friendly ship at range 0-3 is dealt 1 damage card, recover 1 %CHARGE%.%LINEBREAK%While you perform an attack, you may spend 2 %CHARGE% to change 1 %FOCUS% result to a %CRIT% result."""
        "Ciena Ree":
           display_name: """Ciena Ree"""
           text: """After you perform a %COORDINATE% action, if the ship you coordinated performed a %BARRELROLL% or %BOOST% action, it may gain 1 stress token to rotate 90°."""
        "Cikatro Vizago":
           display_name: """Cikatro Vizago"""
           text: """During the End Phase, you may choose 2 %ILLICIT% upgrades equipped to friendly ships at range 0-1. If you do, you may exchange these upgrades.%LINEBREAK%<strong>End of Game:</strong> Return all %ILLICIT% upgrades to their original ships."""
        "Cloaking Device":
           display_name: """Cloaking Device"""
           text: """<strong>Action:</strong> Spend 1 %CHARGE% to perform a %CLOAK% action.%LINEBREAK%At the start of the Planning Phase, roll 1 attack die. On a %FOCUS% result, decloak or discard your cloak token."""
        "Clone Commander Cody":
           display_name: """Clone Commander Cody"""
           text: """After you perform an attack that missed, if 1 or more %HIT%/%CRIT% results were neutralized, the defender gains 1 strain token."""
        "Cluster Missiles":
           display_name: """Cluster Missiles"""
           text: """<strong>Attack (%LOCK%):</strong> Spend 1 %CHARGE%. After this attack, you may perform this attack as a bonus attack against a different target at range 0-1 of the defender, ignoring the %LOCK% requirement."""
        "Collision Detector":
           display_name: """Collision Detector"""
           text: """While you boost or barrel roll, you can move through and overlap obstacles.%LINEBREAK%After you move through or overlap an obstacle, you may spend 1 %CHARGE% to ignore its effects until the end of the round."""
        "Composure":
           display_name: """Composure"""
           text: """After you fail an action, if you have no green tokens, you may perform a %FOCUS% action. If you do, you cannot perform additional actions this round. %LINEBREAK% <i>Errata (since rules reference 1.1.0): Added "If you do, you cannot perform additional actions this round."</i>"""
        "Concussion Missiles":
           display_name: """Concussion Missiles"""
           text: """<strong>Attack (%LOCK%):</strong> Spend 1 %CHARGE%. After this attack hits, each ship at range 0-1 of the defender exposes 1 of its damage cards."""
        "Conner Nets":
           display_name: """Conner Nets"""
           text: """<strong>Mine</strong>%LINEBREAK%During the System Phase, you may spend 1 %CHARGE% to drop a Conner Net using the [1 %STRAIGHT%] template.%LINEBREAK%This card's %CHARGE% cannot be recovered."""
        "Contraband Cybernetics":
           display_name: """Contraband Cybernetics"""
           text: """Before you activate, you may spend 1 %CHARGE%. If you do, until the end of the round, you can perform actions and execute red maneuvers, even while stressed. This card's %CHARGE% cannot be recovered. %LINEBREAK% <i>Errata (since rules reference 1.4.2): Added restriction on recovering charges</i>"""
        "Count Dooku":
           display_name: """Count Dooku"""
           text: """During an attack, before a ship at range 0-2 rolls attack or defense dice, if all of your %FORCE% are active, you may spend 1 %FORCE% and name a result. If the roll does not contain the named result, the ship must change 1 die to that result.%LINEBREAK%<i>Errata (since rules reference 1.4): Added "During an attack"</i>"""
        "Crack Shot":
           display_name: """Crack Shot"""
           text: """While you perform a primary attack, if the defender is in your %BULLSEYEARC%, before the Neutralize Results step, you may spend 1 %CHARGE% to cancel 1 %EVADE% result."""
        "DRK-1 Probe Droids":
           display_name: """DRK-1 Probe Droids"""
           text: """During the End Phase, you may spend 1 %CHARGE% to drop or launch 1 DRK-1 probe droid using a speed 3 template.%LINEBREAK%This card's %CHARGE% cannot be recovered."""
        "Daredevil":
           display_name: """Daredevil"""
           text: """While you perform a white %BOOST% action, you may treat it as red to use the [1 %TURNLEFT%] or [1 %TURNRIGHT%] template instead."""
        "Darth Vader":
           display_name: """Darth Vader"""
           text: """At the start of the Engagement Phase, you may choose 1 ship in your firing arc at range 0-2 and spend 1 %FORCE%. If you do, that ship suffers 1 %HIT% damage unless it chooses to remove 1 green token."""
        "Deadman's Switch":
           display_name: """Deadman's Switch"""
           text: """After you are destroyed, each other ship at range 0-1 suffers 1 %HIT% damage."""
        "Death Troopers":
           display_name: """Death Troopers"""
           text: """During the Activation Phase, enemy ships at range 0-1 cannot remove stress tokens."""
        "Debris Gambit":
           display_name: """Debris Gambit"""
           text: """While you perform a red %EVADE% action, if there is an obstacle at range 0-1, treat the action as white instead."""
        "Dedicated":
           display_name: """Dedicated"""
           text: """While another friendly ship in your %LEFTARC% or %RIGHTARC% at range 0-2 defends, if it is limited or has the <strong>Dedicated</strong> upgrade and you are not strained, you may gain 1 strain token. If you do, the defender rerolls 1 of their blank results.%LINEBREAK%<i>Errata (since rules reference 1.4): Removed Non-Limited restriction and added Clone restriction</i>"""
        "Delayed Fuses":
           display_name: """Delayed Fuses"""
           text: """After you drop, launch or place a bomb or mine, you may place 1 fuse marker on that device."""
        "Delta-7B":
           display_name: """Delta-7B"""
           text: """<i class = flavor_text>The Delta-7B was designed as a heavier variant of the Delta-7 Aethersprite-class Interceptor, identifiable by the repositioned astromech slot. Many Jedi Generals favor this craft's greater firepower and durability.</i>"""
        "Dengar":
           display_name: """Dengar"""
           text: """After you defend, if the attacker is in your firing arc, you may spend 1 %CHARGE%. If you do, roll 1 attack die unless the attacker chooses to remove 1 green token. On a %HIT% or %CRIT% result, the attacker suffers 1 %HIT% damage."""
        "Diamond-Boron Missiles":
           display_name: """Diamond-Boron Missiles"""
           text: """<strong>Attack (%LOCK%):</strong> Spend 1 %CHARGE%. After this attack hits, you may spend 1 %CHARGE%. If you do, each ship at range 0-1 of the defender with agility equal to or less than the defender's rolls 1 attack die and suffers 1 %HIT%/%CRIT% damage for each matching result. """
        "Director Krennic":
           display_name: """Director Krennic"""
           text: """<strong>Setup:</strong> Before placing forces, assign the <strong>Optimized Prototype</strong> condition to another friendly ship."""
        "Discord Missiles":
           display_name: """Discord Missiles"""
           text: """At the start of the Engagement Phase, you may spend 1 calculate token and 1 %CHARGE% to launch 1 buzz droid swarm using the [3 %BANKLEFT%], [3 %STRAIGHT%], or [3 %BANKRIGHT%] template.%LINEBREAK%This card's %CHARGE% cannot be recovered."""
        "Dorsal Turret":
           display_name: """Dorsal Turret"""
           text: """<strong>Attack</strong>"""
        "Electronic Baffle":
           display_name: """Electronic Baffle"""
           text: """During the End Phase, you may suffer 1 %HIT% damage to remove 1 red token."""
        "Elusive":
           display_name: """Elusive"""
           text: """While you defend, you may spend 1 %CHARGE% to reroll 1 defense die.%LINEBREAK%After you fully execute a red maneuver, recover 1 %CHARGE%."""
        "Emperor Palpatine":
           display_name: """Emperor Palpatine"""
           text: """While another friendly ship defends or performs an attack, you may spend 1 %FORCE% to modify 1 of its dice as though that ship had spent 1 %FORCE%."""
        "Energy-Shell Charges":
           display_name: """Energy-Shell Charges"""
           text: """<strong>Attack (%CALCULATE%):</strong> Spend 1 %CHARGE%. While you perform this attack, you may spend 1 calculate token to change 1 %FOCUS% result to a %CRIT% result.%LINEBREAK%<strong>Action</strong>: Reload this card."""
        "Engine Upgrade":
           display_name: """Engine Upgrade"""
           text: """<i class = flavor_text>Large military forces such as the Galactic Empire have standardized engines, but individual pilots and small organizations often replace the power couplings, add thrusters, or use high-performance fuel to get extra push out of their engines.</i>"""
        "Ensnare":
           text: """At the end of the Activation Phase, if you are tractored, you may choose 1 ship in your %SINGLETURRETARC% arc at range 0-1. Transfer 1 tractor token to it."""
        "Expert Handling":
           display_name: """Expert Handling"""
           text: """<i class = flavor_text>While heavy fighters can often be coaxed into a barrel roll, seasoned pilots know how to do it without putting undue stress on their craft or leaving themselves open to attack.</i>"""
        "Ezra Bridger":
           display_name: """Ezra Bridger"""
           text: """After you perform a primary attack, you may spend 1 %FORCE% to perform a bonus %SINGLETURRETARC% attack from a %SINGLETURRETARC% you have not attacked from this round. If you do and you are stressed, you may reroll 1 attack die."""
        "Fanatical":
           display_name: """Fanatical"""
           text: """While you perform a primary attack, if you are not shielded, you may change 1 %FOCUS% result to a %HIT% result."""
        "Fearless":
           display_name: """Fearless"""
           text: """While you perform a %FRONTARC% primary attack, if the attack range is 1 and you are in the defender's %FRONTARC%, you may change 1 of your results to a %HIT% result."""
        "Feedback Array":
           display_name: """Feedback Array"""
           text: """Before you engage, you may gain 1 ion token and 1 disarm token. If you do, each ship at range 0 suffers 1 %HIT% damage."""
        "Ferrosphere Paint":
           display_name: """Ferrosphere Paint"""
           text: """After an enemy ship locks you, if you are not in that ship's %BULLSEYEARC%, that ship gains 1 stress token unless it chooses to break its lock.%LINEBREAK%<i>Errata (since rules reference 1.4): Abilty adjusted to allow counterplay</i>"""
        "Fifth Brother":
           display_name: """Fifth Brother"""
           text: """While you perform an attack, you may spend 1 %FORCE% to change 1 of your %FOCUS% results to a %CRIT% result."""
        "Finn":
           display_name: """Finn"""
           text: """While you defend or perform a primary attack, if the enemy ship is in your %FRONTARC%, you may add 1 blank result to your roll (this die can be rerolled or otherwise modified)."""
        "Fire-Control System":
           display_name: """Fire-Control System"""
           text: """While you perform an attack, if you have a lock on the defender, you may reroll 1 attack die. If you do, you cannot spend your lock during this attack."""
        "Freelance Slicer":
           display_name: """Freelance Slicer"""
           text: """While you defend, before attack dice are rolled, you may spend a lock you have on the attacker to roll 1 attack die. If you do, the attacker gains 1 jam token. Then, on a %HIT% or %CRIT% result, gain 1 jam token."""
        "GA-97":
           text: """<strong>Setup:</strong> Before placing forces, you may spend 3-5 %CHARGE%. If you do, choose another friendly ship and assign the <strong>It's the Resistance</strong> condition to it."""
        'GNK "Gonk" Droid':
           display_name: """GNK “Gonk” Droid"""
           text: """<strong>Setup:</strong> Lose 1 %CHARGE%.%LINEBREAK%<strong>Action:</strong> Recover 1 %CHARGE%.%LINEBREAK%<strong>Action:</strong> Spend 1 %CHARGE% to recover 1 shield."""
        "General Grievous":
           display_name: """General Grievous"""
           text: """While you defend, after the Neutralize Results step, if there are 2 or more %HIT%/%CRIT% results, you may spend 1 %CHARGE% to cancel 1 %HIT% or %CRIT% result. %LINEBREAK%After a friendly ship is destroyed, recover 1 %CHARGE%."""
        "General Hux":
           display_name: """General Hux"""
           text: """While you perform a white %COORDINATE% action, you may treat it as red. If you do, you may coordinate up to 2 additional ships of the same ship type, and each ship you coordinate must perform the same action, treating that action as red."""
        "Grand Inquisitor":
           display_name: """Grand Inquisitor"""
           text: """After an enemy ship at range 0-2 reveals its dial, you may spend 1 %FORCE% to perform 1 white action on your action bar, treating that action as red."""
        "Grand Moff Tarkin":
           display_name: """Grand Moff Tarkin"""
           text: """During the System Phase, you may spend 2 %CHARGE%. If you do, each friendly ship may acquire a lock on a ship that you have locked."""
        "Grappling Struts":
           display_name: """Grappling Struts"""
           text: """Closed:%LINEBREAK%<strong>Setup:</strong> Equip this side faceup.%LINEBREAK%After you execute a maneuver, if you overlap an asteroid or debris cloud and there are 1 or fewer other friendly ships at range 0 of that obstacle, you may flip this card. If you do, you do not suffer the effects of overlapping the asteroid or debris cloud.%LINEBREAK% Open:%LINEBREAK%You ignore obstacles at range 0. You cannot perform %BARRELROLL% actions. After you reveal your dial, if you reveal a maneuver other than a [2%STRAIGHT%] and are at range 0 of an asteroid or debris cloud, skip your Execute Maneuver step and remove 1 stress token; if you revealed a right or left maneuver, rotate your ship 90° in that direction. After you execute a maneuver, flip this card.%LINEBREAK%<i>Errata (since rules reference 1.4): Updated text to work as intended</i>"""
        "Greedo":
           display_name: """Greedo"""
           text: """While you perform an attack, you may spend 1 %CHARGE% to change 1 %HIT% result to a %CRIT% result.%LINEBREAK%While you defend, if your %CHARGE% is active, the attacker may change 1 %HIT% result to a %CRIT% result."""
        "Han Solo":
           display_name: """Han Solo"""
           text: """During the Engagement Phase, at initiative 7, you may perform a %SINGLETURRETARC% attack. You cannot attack from that %SINGLETURRETARC% again this round."""
        "Han Solo (Scum)":
           display_name: """Han Solo"""
           text: """Before you engage, you may perform a red %FOCUS% action."""
        "Han Solo (Resistance)":
           display_name: """Han Solo"""
           text: """After you perform an %EVADE% action, gain additional evade tokens equal to the number of enemy ships at range 0-1."""
        "Hate":
           display_name: """Hate"""
           text: """After you suffer 1 or more damage, recover that many %FORCE%."""
        "Heavy Laser Cannon":
           display_name: """Heavy Laser Cannon"""
           text: """<strong>Attack:</strong> After the Modify Attack Dice step, change all %CRIT% results to %HIT% results."""
        "Heightened Perception":
           display_name: """Heightened Perception"""
           text: """At the start of the Engagement Phase, you may spend 1 %FORCE%. If you do, engage at initiative 7 instead of your standard initiative value this phase."""
        "Hera Syndulla":
           display_name: """Hera Syndulla"""
           text: """You can execute red maneuvers even while stressed. After you fully execute a red maneuver, if you have 3 or more stress tokens, remove 1 stress token and suffer 1 %HIT% damage."""
        "Heroic":
           display_name: """Heroic"""
           text: """While you defend or perform an attack, if you have only blank results and have 2 or more results, you may reroll any number of your dice."""
        "Homing Missiles":
           display_name: """Homing Missiles"""
           text: """<strong>Attack (%LOCK%):</strong> Spend 1 %CHARGE%. After you declare the defender, the defender may choose to suffer 1 %HIT% damage. If it does, skip the Attack and Defense Dice steps and the attack is treated as hitting."""
        "Hotshot Gunner":
           display_name: """Hotshot Gunner"""
           text: """While you perform a %SINGLETURRETARC% attack, after the Modify Defense Dice step, the defender removes 1 focus or calculate token."""
        "Hull Upgrade":
           display_name: """Hull Upgrade"""
           text: """<i class = flavor_text>For those who cannot afford an enhanced shield generator, bolting additional plates onto the hull of a ship can serve as an adequate substitute.</i>"""
        "Hyperspace Tracking Data":
           display_name: """Hyperspace Tracking Data"""
           text: """<strong>Setup:</strong> Before placing forces, you may choose a number between 0 and 6. Treat your initiative as the chosen value during Setup.%LINEBREAK%After Setup, assign 1 focus or evade token to each friendly ship at range 0-2."""
        "IG-88D":
           display_name: """IG-88D"""
           text: """You have the pilot ability of each other friendly ship with the <strong>IG-2000</strong> upgrade.%LINEBREAK%After you perform a %CALCULATE% action, gain 1 calculate token."""
        "Ion Bombs":
           display_name: """Ion Bombs"""
           text: """<strong>Bomb</strong>%LINEBREAK% During the System Phase, you may spend 1 %CHARGE% to drop an Ion Bomb using the [1 %STRAIGHT%] template."""
        "ISB Slicer":
           display_name: """ISB Slicer"""
           text: """During the End Phase, enemy ships at range 1-2 cannot remove jam tokens."""
        "Impervium Plating":
           display_name: """Impervium Plating"""
           text: """Before you would be dealt a faceup <strong>Ship</strong> damage card, you may spend 1 %CHARGE% to discard it instead."""
        "Inertial Dampeners":
           display_name: """Inertial Dampeners"""
           text: """Before you would execute a maneuver, you may spend 1 shield. If you do, execute a white [0 %STOP%] instead of the maneuver you revealed, then gain 1 stress token."""
        "Informant":
           display_name: """Informant"""
           text: """<strong>Setup:</strong> After placing forces, choose 1 enemy ship and assign the <strong>Listening Device</strong> condition to it."""
        "Instinctive Aim":
           display_name: """Instinctive Aim"""
           text: """While you perform a special attack, you may spend 1 %FORCE% to ignore the %FOCUS% or %LOCK% requirement."""
        "Integrated S-Foils":
           display_name: """Integrated S-Foils"""
           text: """<strong>Closed: </strong><i>%BARRELROLL%, %FOCUS% <i class="xwing-miniatures-font xwing-miniatures-font-linked"></i> <r>%BARRELROLL%</r></i>%LINEBREAK% While you perform a primary attack, if the defender is not in your %BULLSEYEARC%, roll 1 fewer attack die. %LINEBREAK% Before you activate, you may flip this card. %LINEBREAK% <b>Open:</b> Before you activate, you may flip this card."""
        "Intimidation":
           display_name: """Intimidation"""
           text: """While an enemy ship at range 0 defends, it rolls 1 fewer defense die."""
        "Ion Cannon":
           display_name: """Ion Cannon"""
           text: """<strong>Attack:</strong> If this attack hits, spend 1 %HIT% or %CRIT% result to cause the defender to suffer 1 %HIT% damage. All remaining %HIT%/%CRIT% results inflict ion tokens instead of damage."""
        "Ion Cannon Turret":
           display_name: """Ion Cannon Turret"""
           text: """<strong>Attack:</strong> If this attack hits, spend 1 %HIT% or %CRIT% result to cause the defender to suffer 1 %HIT% damage. All remaining %HIT%/%CRIT% results inflict ion tokens instead of damage."""
        "Ion Missiles":
           display_name: """Ion Missiles"""
           text: """<strong>Attack (%LOCK%):</strong> Spend 1 %CHARGE%. If this attack hits, spend 1 %HIT% or %CRIT% result to cause the defender to suffer 1 %HIT% damage. All remaining %HIT%/%CRIT% results inflict ion tokens instead of damage."""
        "Ion Torpedoes":
           display_name: """Ion Torpedoes"""
           text: """<strong>Attack (%LOCK%):</strong> Spend 1 %CHARGE%. If this attack hits, spend 1 %HIT% or %CRIT% result to cause the defender to suffer 1 %HIT% damage. All remaining %HIT%/%CRIT% results inflict ion tokens instead of damage."""
        "Jabba the Hutt":
           display_name: """Jabba the Hutt"""
           text: """During the End Phase, you may choose 1 friendly ship at range 0-2 and spend 1 %CHARGE%. If you do, that ship recovers 1 %CHARGE% on 1 of its equipped %ILLICIT% upgrades."""
        "Jamming Beam":
           display_name: """Jamming Beam"""
           text: """<strong>Attack:</strong> If this attack hits, all %HIT%/%CRIT% results inflict jam tokens instead of damage."""
        "Juke":
           display_name: """Juke"""
           text: """While you perform an attack, if you are evading, you may change 1 of the defender's %EVADE% results to a %FOCUS% result."""
        "Jyn Erso":
           display_name: """Jyn Erso"""
           text: """If a friendly ship at range 0-3 would gain a focus token, it may gain 1 evade token instead."""
        "K2-B4":
           display_name: """K2-B4"""
           text: """While a friendly ship at range 0-3 defends, it may spend 1 calculate token. If it does, add 1 %EVADE% result unless the attacker chooses to gain 1 strain token."""
        "Kaydel Connix":
           text: """After you reveal your dial, you may set your dial to a basic maneuver of the next higher speed. While you execute that maneuver, increase its difficulty"""
        "Kanan Jarrus":
           display_name: """Kanan Jarrus"""
           text: """After a friendly ship at range 0-2 fully executes a white maneuver, you may spend 1 %FORCE% to remove 1 stress token from that ship."""
        "Ketsu Onyo":
           display_name: """Ketsu Onyo"""
           text: """At the start of the End Phase, you may choose 1 enemy ship at range 0-2 in your firing arc. If you do, that ship does not remove its tractor tokens."""
        "Kraken":
           display_name: """Kraken"""
           text: """During the End Phase, you may choose up to 3 friendly ships at range 0-3. If you do, each of these ships does not remove 1 calculate token."""
        "Kylo Ren":
           display_name: """Kylo Ren"""
           text: """<strong>Action:</strong> Choose 1 enemy ship at range 1-3. If you do, spend 1 %FORCE% to assign the <strong>I'll Show You the Dark Side</strong> condition to that ship."""
        "L3-37":
           display_name: """L3-37"""
           text: """<strong>Setup:</strong> Equip this side faceup.%LINEBREAK%While you defend, you may flip this card. If you do, the attacker must reroll all attack dice.%LINEBREAK%<strong>L3-37's Programming:</strong> If you are not shielded, decrease the difficulty of your bank (%BANKLEFT% and %BANKRIGHT%) maneuvers."""
        "Kylo Ren":
           display_name: """Kylo Ren"""
           text: """<strong>Action:</strong> Choose 1 enemy ship at range 1-3. If you do, spend 1 %FORCE% to assign the <strong>I'll Show You the Dark Side</strong> condition to that ship."""
        "Landing Struts":
           display_name: """Landing Struts"""
           text: """Closed:%LINEBREAK%<strong>Setup:</strong> Equip this side faceup.%LINEBREAK% After you execute a maneuver, if you overlap an asteroid or debris cloud and there are 1 or fewer other friendly ships at range 0 of that obstacle, you may flip this card. If you do, you do not suffer the effects of overlapping the asteroid or debris cloud. %LINEBREAK% Open:%LINEBREAK% You ignore obstacles at range 0. You cannot perform %BARRELROLL% actions. After you reveal your dial, if you reveal a maneuver other than a [2 %STRAIGHT%] and are at range 0 of an asteroid or debris cloud, skip your Execute Maneuver step and remove 1 stress token; if you revealed a right or left maneuver, rotate your ship 90° in that direction. After you execute a maneuver, flip this card.%LINEBREAK%<i>Errata (since rules reference 1.4): Updated text to work as intended</i>"""
        "Lando Calrissian":
           display_name: """Lando Calrissian"""
           text: """<strong>Action:</strong> Roll 2 defense dice. For each %FOCUS% result, gain 1 focus token. For each %EVADE% result, gain 1 evade token. If both results are blank, the opposing player chooses focus or evade. You gain 1 token of that type."""
        "Lando Calrissian (Scum)":
           display_name: """Lando Calrissian"""
           text: """After you roll dice, you may spend 1 green token to reroll up to 2 of your results."""
        "Lando's Millennium Falcon":
           display_name: """Lando's Millennium Falcon"""
           text: """1 escape shuttle may dock with you.%LINEBREAK%While you have an escape shuttle docked, you may treat its shields as if they were on your ship card.%LINEBREAK%While you perform a primary attack against a stressed ship, roll 1 additional attack die. %LINEBREAK%<i>Errata (since rules reference 1.1.0): Replaced “spend" with "treat"</i>"""
        "Latts Razzi":
           display_name: """Latts Razzi"""
           text: """While you defend, if the attacker is stressed, you may remove 1 stress from the attacker to change 1 of your blank/%FOCUS% results to an %EVADE% result."""
        "Leia Organa":
           display_name: """Leia Organa"""
           text: """At the start of the Activation Phase, you may spend 3 %CHARGE%. During this phase, each friendly ship reduces the difficulty of its red maneuvers."""
        "Lone Wolf":
           display_name: """Lone Wolf"""
           text: """While you defend or perform an attack, if there are no other friendly ships at range 0-2, you may spend 1 %CHARGE% to reroll 1 of your dice."""
        "Luke Skywalker":
           display_name: """Luke Skywalker"""
           text: """At the start of the Engagement Phase, you may spend 1 %FORCE% and gain 1 deplete token to rotate your %SINGLETURRETARC% indicator. %LINEBREAK%<i>Errata (since rules reference 1.4): Added an additional cost</i>"""
        "M9-G8":
           display_name: """M9-G8"""
           text: """While a ship you are locking performs an attack, you may choose 1 attack die. If you do, the attacker rerolls that die."""
        "Magva Yarro":
           display_name: """Magva Yarro"""
           text: """After you defend, if the attack hit, you may acquire a lock on the attacker."""
        "Marksmanship":
           display_name: """Marksmanship"""
           text: """While you perform an attack, if the defender is in your %BULLSEYEARC%, you may change 1 %HIT% result to a %CRIT% result."""
        "Maul":
           display_name: """Maul"""
           text: """After you suffer damage, you may gain 1 stress token to recover 1 %FORCE%.%LINEBREAK%You can equip “Dark Side” upgrades."""
        "Minister Tua":
           display_name: """Minister Tua"""
           text: """At the start of the Engagement Phase, if you are damaged, you may perform a red %REINFORCE% action."""
        "Moff Jerjerrod":
           display_name: """Moff Jerjerrod"""
           text: """During the System Phase, you may spend 2 %CHARGE%. If you do, choose the [1 %BANKLEFT%], [1 %STRAIGHT%], or [1 %BANKRIGHT%] template. Each friendly ship may perform a red %BOOST% action using that template."""
        "Munitions Failsafe":
           display_name: """Munitions Failsafe"""
           text: """While you perform a %TORPEDO% or %MISSILE% attack, after rolling attack dice, you may cancel all dice results to recover 1 %CHARGE% you spent as a cost for the attack."""
        "Nien Nunb":
           display_name: """Nien Nunb"""
           text: """Decrease the difficulty of your bank maneuvers (%BANKLEFT% and %BANKRIGHT%)."""
        "Novice Technician":
           display_name: """Novice Technician"""
           text: """At the end of the round, you may roll 1 attack die to repair 1 faceup damage card. Then on a %HIT% result, expose 1 damage card."""
        "Os-1 Arsenal Loadout":
           display_name: """Os-1 Arsenal Loadout"""
           text: """While you have exactly 1 disarm token, you can still perform %TORPEDO% and %MISSILE% attacks against targets you have locked. If you do, you cannot spend your lock during the attack."""
        "Outmaneuver":
           display_name: """Outmaneuver"""
           text: """While you perform a %FRONTARC% attack, if you are not in the defender's firing arc, the defender rolls 1 fewer defense die."""
        "Paige Tico":
           display_name: """Paige Tico"""
           text: """After you perform a primary attack, you may drop 1 bomb or rotate your %SINGLETURRETARC%.%LINEBREAK%After you are destroyed, you may drop 1 bomb."""
        "Pattern Analyzer":
           display_name: """Pattern Analyzer"""
           text: """While you fully execute a red maneuver, before the Check Difficulty step, you may perform 1 action."""
        "Perceptive Copilot":
           display_name: """Perceptive Copilot"""
           text: """After you perform a %FOCUS% action, gain 1 focus token."""
        "Petty Officer Thanisson":
           display_name: """Petty Officer Thanisson"""
           text: """During the Activation or Engagement Phase, after an enemy ship in your %FRONTARC% at range 0-1 gains a red or orange token, if you are not stressed, you may gain 1 stress token. If you do, that ship gains 1 additional token of the type that it gained."""
        "Plasma Torpedoes":
           display_name: """Plasma Torpedoes"""
           text: """<strong>Attack (%LOCK%):</strong> Spend 1 %CHARGE%. During the Neutralize Results step, %CRIT% results are cancelled before %HIT% results. After this attack hits, the defender loses 1 shield."""
        "Pivot Wing":
           display_name: """Pivot Wing"""
           text: """<strong>Closed: </strong>While you defend, roll 1 fewer defense die.%LINEBREAK%After you execute a [0 %STOP%] maneuver, you may rotate your ship 90º or 180º.%LINEBREAK%Before you activate, you may flip this card.%LINEBREAK%<strong>Open:</Strong> Before you activate, you may flip this card."""
        "Predator":
           display_name: """Predator"""
           text: """While you perform a primary attack, if the defender is in your %BULLSEYEARC%, you may reroll 1 attack die."""
        "Predictive Shot":
           display_name: """Predictive Shot"""
           text: """After you declare an attack, if the defender is in your %BULLSEYEARC%, you may spend 1 %FORCE%. If you do, during the Roll Defense Dice step, the defender cannot roll more defense dice than the number of your %HIT%/%CRIT% results."""
        "Primed Thrusters":
           display_name: """Primed Thrusters"""
           text: """While you have 2 or fewer stress tokens, you can perform %BARRELROLL% and %BOOST% actions even while stressed."""
        "Proton Bombs":
           display_name: """Proton Bombs"""
           text: """<strong>Bomb</strong>%LINEBREAK%During the System Phase, you may spend 1 %CHARGE% to drop a Proton Bomb using the [1 %STRAIGHT%] template."""
        "Proton Rockets":
           display_name: """Proton Rockets"""
           text: """<strong>Attack (%FOCUS%):</strong> Spend 1 %CHARGE%."""
        "Proton Torpedoes":
           display_name: """Proton Torpedoes"""
           text: """<strong>Attack (%LOCK%):</strong> Spend 1 %CHARGE%. Change 1 %HIT% result to a %CRIT% result."""
        "Proximity Mines":
           display_name: """Proximity Mines"""
           text: """<strong>Mine</strong>%LINEBREAK%During the System Phase, you may spend 1 %CHARGE% to drop a Proximity Mine using the [1 %STRAIGHT%] template.%LINEBREAK%This card's %CHARGE% cannot be recovered."""
        "Qi'ra":
           display_name: """Qi'ra"""
           text: """While you move and perform attacks, you ignore obstacles that you are locking."""
        "R2 Astromech":
           display_name: """R2 Astromech"""
           text: """After you reveal your dial, you may spend 1 %CHARGE% and gain 1 disarm token to recover 1 shield."""
        "R2-C4":
           text: """While you perform an attack, you may spend 1 evade token to change 1 %FOCUS% result to a %HIT% result."""
        "R2-D2 (Crew)":
           display_name: """R2-D2"""
           text: """During the End Phase, if you are damaged and not shielded, you may roll 1 attack die to recover 1 shield. On a %HIT% result, expose 1 of your damage cards."""
        "R2-D2":
           display_name: """R2-D2"""
           text: """After you reveal your dial, you may spend 1 %CHARGE% and gain 1 disarm token to recover 1 shield."""
        "R2-HA":
           display_name: """R2-HA"""
           text: """While you defend, you may spend your lock on the attacker to reroll any number of your defense dice."""
        "R3 Astromech":
           display_name: """R3 Astromech"""
           text: """You can maintain up to 2 locks. Each lock must be on a different object.%LINEBREAK%After you perform a %LOCK% action, you may acquire a lock."""
        "R4 Astromech":
           display_name: """R4 Astromech"""
           text: """Decrease the difficulty of your speed 1-2 basic maneuvers (%TURNLEFT%, %BANKLEFT%, %STRAIGHT%, %BANKRIGHT%, %TURNRIGHT%)."""
        "R4-P Astromech":
           display_name: """R4-P Astromech"""
           text: """Before you execute a basic maneuver, you may spend 1 %CHARGE%. If you do, while you execute that maneuver, reduce its difficulty."""
        "R4-P17":
           display_name: """R4-P17"""
           text: """After you fully execute a red maneuver, you may spend 1 %CHARGE% to perform an action, even while stressed."""
        "R4-P44":
           display_name: """R4-P44"""
           text: """After you fully execute a red maneuver, if there is an enemy ship in your %BULLSEYEARC%, gain 1 calculate token."""
        "R5 Astromech":
           display_name: """R5 Astromech"""
           text: """<strong>Action:</strong> Spend 1 %CHARGE% to repair 1 facedown damage card.%LINEBREAK%<strong>Action:</strong> Repair 1 faceup <strong>Ship</strong> damage card."""
        "R5-D8":
           display_name: """R5-D8"""
           text: """<strong>Action:</strong> Spend 1 %CHARGE% to repair 1 facedown damage card.%LINEBREAK%<strong>Action:</strong> Repair 1 faceup <strong>Ship</strong> damage card."""
        "R5-P8":
           display_name: """R5-P8"""
           text: """While you perform an attack against a defender in your %FRONTARC%, you may spend 1 %CHARGE% to reroll 1 attack die. If the rerolled result is a %CRIT% result, suffer 1 %CRIT% damage."""
        "R5-TK":
           display_name: """R5-TK"""
           text: """You can perform attacks against friendly ships."""
        "R5-X3":
           display_name: """R5-X3"""
           text: """Before you activate or engage, you may spend 1 %CHARGE% to ignore obstacles until the end of this phase."""
        "Rey":
           display_name: """Rey"""
           text: """While you defend or perform an attack, if the enemy ship is in your %SINGLETURRETARC%, you may spend 1 %FORCE% to change 1 of your blank results to a %EVADE% or %HIT% result."""
        "Rey's Millennium Falcon":
           display_name: """Rey's Millennium Falcon"""
           text: """If you have 2 or fewer stress tokens, you can execute red Segnor's Loop [%SLOOPLEFT% or %SLOOPRIGHT%] maneuvers and perform %BOOST% and %ROTATEARC% actions even while stressed."""
        "Rigged Cargo Chute":
           display_name: """Rigged Cargo Chute"""
           text: """<strong>Action:</strong> Spend 1 %CHARGE%. Drop 1 loose cargo using the [1 %STRAIGHT%] template."""
        "Rose Tico":
           display_name: """Rose Tico"""
           text: """While you defend or perform an attack, you may spend 1 of your results to acquire a lock on the enemy ship."""
        "Ruthless":
           display_name: """Ruthless"""
           text: """While you perform an attack, you may choose another friendly ship at range 0-1 of the defender. If you do, that ship suffers 1 %HIT% damage and you may change 1 of your die results to a %HIT% result."""
        "Sabine Wren":
           display_name: """Sabine Wren"""
           text: """<strong>Setup:</strong> Place 1 ion, 1 jam, 1 stress, and 1 tractor token on this card. %LINEBREAK%After a ship suffers the effect of a friendly bomb, you may remove 1 ion, jam, stress, or tractor token from this card. If you do, that ship gains a matching token."""
        "Saturation Salvo":
           display_name: """Saturation Salvo"""
           text: """While you perform a %TORPEDO% or %MISSILE% attack, you may spend 1 %CHARGE% from that upgrade. If you do, choose two defense dice. The defender must reroll those dice."""
        "Saw Gerrera":
           display_name: """Saw Gerrera"""
           text: """While you perform an attack, you may suffer 1 %HIT% damage to change all of your %FOCUS% results to %CRIT% results."""
        "Seasoned Navigator":
           display_name: """Seasoned Navigator"""
           text: """After you reveal your dial, you may set your dial to another non-red maneuver of the same speed. While you execute that maneuver, increase its difficulty."""
        "Seismic Charges":
           display_name: """Seismic Charges"""
           text: """<strong>Bomb</strong>%LINEBREAK%During the System Phase, you may spend 1 %CHARGE% to drop a Seismic Charge with the [1 %STRAIGHT%] template."""
        "Selfless":
           display_name: """Selfless"""
           text: """While another friendly ship at range 0-1 defends, before the Neutralize Results step, if you are in the attack arc, you may suffer 1 %CRIT% damage to cancel 1 %CRIT% result."""
        "Sense":
           display_name: """Sense"""
           text: """During the System Phase, you may choose 1 ship at range 0-1 and look at its dial. If you spend 1 %FORCE%, you may choose a ship at range 0-3 instead."""
        "Servomotor S-Foils":
           display_name: """Servomotor S-Foils"""
           text: """<strong>Closed: </strong><i>%BOOST%, %FOCUS% <i class="xwing-miniatures-font xwing-miniatures-font-linked"></i> <r>%BOOST%</r></i>%LINEBREAK% While you perform a primary attack, roll 1 fewer attack die.%LINEBREAK%Before you activate, you may flip this card.%LINEBREAK%<strong>Open:</strong> Before you activate, you may flip this card."""
        "Seventh Fleet Gunner":
           display_name: """Seventh Fleet Gunner"""
           text: """While another friendly ship performs a primary attack, if the defender is in your firing arc, you may spend 1 %CHARGE%. If you do, the attacker rolls 1 additional die, to a maximum of 4. During the System Phase, you may gain 1 disarm token to recover 1 %CHARGE%."""
        "Seventh Sister":
           display_name: """Seventh Sister"""
           text: """If an enemy ship at range 0-1 would gain a stress token, you may spend 1 %FORCE% to have it gain 1 jam or tractor token instead."""
        "Shield Upgrade":
           display_name: """Shield Upgrade"""
           text: """<i class = flavor_text>Deflector shields are a substantial line of defense on most starships beyond the lightest fighters. While enhancing a ship's shield capacity can be costly, all but the most confident or reckless pilots see the value in this sort of investment.</i>"""
        "Skilled Bombardier":
           display_name: """Skilled Bombardier"""
           text: """If you would drop or launch a device, you may use a template of the same bearing with a speed 1 higher or lower."""
        "Spare Parts Canisters":
           display_name: """Spare Parts Canisters"""
           text: """<strong>Action:</strong> Spend 1 %CHARGE% to recover 1 charge on one of your equipped %ASTROMECH% upgrades. %LINEBREAK%<strong>Action:</strong> Spend 1 %CHARGE% to drop 1 spare parts, then break all locks assigned to you."""
        "Special Forces Gunner":
           display_name: """Special Forces Gunner"""
           text: """While you perform a primary %FRONTARC% attack, if your %SINGLETURRETARC% is in your %FRONTARC%, you may roll 1 additional attack die.%LINEBREAK%After you perform a primary %FRONTARC% attack, if your %SINGLETURRETARC% is in your %REARARC%, you may perform a bonus primary %SINGLETURRETARC% attack."""
        "Squad Leader":
           display_name: """Squad Leader"""
           text: """While you coordinate, the ship you choose can perform an action only if that action is also on your action bar."""
        "Static Discharge Vanes":
           display_name: """Static Discharge Vanes"""
           text: """Before you would gain 1 ion or jam token, if you are not stressed, you may choose another ship at range 0-1 and gain 1 stress token. If you do, the chosen ship gains that ion or jam token instead, then you suffer 1 %HIT% damage. %LINEBREAK%<i>Errata (since rules reference 1.1.0): Changed from "If you would gain an ion or jam token, if you are not stressed, you may choose a ship at range 0-1. If you do, gain 1 stress token and transfer 1 ion or jam token to that ship."</i>"""
        "Stealth Device":
           display_name: """Stealth Device"""
           text: """While you defend, if your %CHARGE% is active, roll 1 additional defense die.%LINEBREAK%After you suffer damage, lose 1 %CHARGE%."""
        "Supernatural Reflexes":
           display_name: """Supernatural Reflexes"""
           text: """Before you activate, you may spend 1 %FORCE% to perform a %BARRELROLL% or %BOOST% action. Then, if you performed an action you do not have on your action bar, suffer 1 %HIT% damage."""
        "Supreme Leader Snoke":
           display_name: """Supreme Leader Snoke"""
           text: """During the System Phase, you may choose any number of enemy ships beyond range 1. If you do, spend that many %FORCE% to flip each chosen ship's dial faceup."""
        "Swarm Tactics":
           display_name: """Swarm Tactics"""
           text: """At the start of the Engagement Phase, you may choose 1 friendly ship at range 1. If you do, that ship treats its initiative as equal to yours until the end of the round."""
        "Synchronized Console":
           display_name: """Synchronized Console"""
           text: """After you perform an attack, you may choose a friendly ship at range 1 or a friendly ship with the <strong>Synchronized Console</strong> upgrade at range 1-3 and spend a lock you have on the defender. If you do, the friendly ship you chose may acquire a lock on the defender."""
        "TA-175":
           display_name: """TA-175"""
           text: """After a friendly ship at range 0-3 with %CALCULATE% on its action bar is destroyed, each friendly ship at range 0-3 with %CALCULATE% in its action bar gains 1 calculate token."""
        "TV-94":
           display_name: """TV-94"""
           text: """While a friendly ship at range 0-3 performs a primary attack against a defender in its %BULLSEYEARC%, if there are 2 or fewer attack dice, it may spend 1 calculate token to add 1 %HIT% result."""
        "Tactical Officer":
           display_name: """Tactical Officer"""
           text: """<i class = flavor_text>In the chaos of a starfighter battle, a single order can mean the difference between a victory and a massacre.</i>"""
        "Tactical Scrambler":
           display_name: """Tactical Scrambler"""
           text: """While you obstruct an enemy ship's attack, the defender rolls 1 additional defense die."""
        "Targeting Computer":
           text: """ """
        "Targeting Synchronizer":
           display_name: """Targeting Synchronizer"""
           text: """While a friendly ship at range 1-2 performs an attack against a target you have locked, that ship ignores the %LOCK% attack requirement."""
        "Tobias Beckett":
           display_name: """Tobias Beckett"""
           text: """<strong>Setup:</strong> After placing forces, you may choose 1 obstacle in the play area. If you do, place it anywhere in the play area beyond range 2 of any board edge or ship and beyond range 1 of other obstacles."""
        "Tractor Beam":
           display_name: """Tractor Beam"""
           text: """<strong>Attack:</strong> If this attack hits, all %HIT%/%CRIT% results inflict tractor tokens instead of damage."""
        "Trajectory Simulator":
           display_name: """Trajectory Simulator"""
           text: """During the System Phase, if you would drop or launch a bomb, you may launch it using the [5 %STRAIGHT%] template instead."""
        "Treacherous":
           display_name: """Treacherous"""
           text: """While you defend, you may choose a ship obstructing the attack and spend 1 %CHARGE%. If you do, cancel 1 %HIT% or %CRIT% result, and the ship you chose gains 1 strain token.%LINEBREAK%After a ship at range 0-3 is destroyed, recover 1 %CHARGE%."""
        "Trick Shot":
           display_name: """Trick Shot"""
           text: """While you perform an attack that is obstructed by an obstacle, roll 1 additional attack die."""
        "Unkar Plutt":
           display_name: """Unkar Plutt"""
           text: """After you partially execute a maneuver, you may suffer 1 %HIT% damage to perform 1 white action."""
        "Veteran Tail Gunner":
           display_name: """Veteran Tail Gunner"""
           text: """After you perform a primary %FRONTARC% attack, you may perform a bonus primary %REARARC% attack."""
        "Veteran Turret Gunner":
           display_name: """Veteran Turret Gunner"""
           text: """After you perform a primary attack, you may perform a bonus %SINGLETURRETARC% attack using a %SINGLETURRETARC% you did not already attack from this round."""
        "Xg-1 Assault Configuration":
           display_name: """Xg-1 Assault Configuration"""
           text: """While you have exactly 1 disarm token, you can still perform %CANNON% attacks. While you perform a %CANNON% attack while disarmed, roll a maximum of 3 attack dice."""
        "Zuckuss":
           display_name: """Zuckuss"""
           text: """While you perform an attack, if you are not stressed, you may choose 1 defense die and gain 1 stress token. If you do, the defender must reroll that die."""
        '"Chopper" (Crew)':
           display_name: """“Chopper”"""
           text: """During the Perform Action step, you may perform 1 action, even while stressed. After you perform an action while stressed, suffer 1 %HIT% damage unless you expose 1 of your damage cards."""
        '"Chopper" (Astromech)':
           display_name: """“Chopper”"""
           text: """<strong>Action:</strong> Spend 1 non-recurring  %CHARGE% from another equipped upgrade to recover 1 shield. %LINEBREAK%<strong>Action:</strong> Spend 2 shields to recover 1 non-recurring %CHARGE% on an equipped upgrade."""
        '"Genius"':
           display_name: """“Genius”"""
           text: """After you fully execute a maneuver, if you have not dropped or launched a device this round, you may drop 1 bomb."""
        '"Zeb" Orrelios':
           display_name: """“Zeb” Orrelios"""
           text: """While you perform an attack at attack range 0, you may spend focus tokens for their default effect to modify results. While defending at attack range 0, the attacker may spend focus tokens for their default effect to modify results.%LINEBREAK%<i>Errata (since rules reference 1.4): Ability reworked</i>"""
        "Kaydel Connix":
           display_name: """Kaydel Connix"""
           text: """After you reveal your dial, you may set your dial to a basic maneuver of the next higher speed. While you execute that maneuver, increase its' difficulty."""
        "Autoblasters":
           display_name: """Autoblasters"""
           text: """<strong>Attack:</strong> If the defender is in your %BULLSEYEARC%, roll 1 additional die. During the Neutralize Results step, if you are not in the defender's %FRONTARC%, %EVADE% results do not cancel %CRIT% results. """
        "R2-C4":
           display_name: """R2-C4"""
           text: """While you perform an attack, you may spend 1 evade token to change 1 %FOCUS% result to a %HIT% result. """
        "Electro-Proton Bomb":
           display_name: """Electro-Proton Bomb"""
           text: """<strong>Bomb</strong>%LINEBREAK%During the System Phase, you may spend 1 %CHARGE% to drop an Electro-Proton Bomb with the [1 %STRAIGHT%] template. Then place 1 fuse marker on that device. %LINEBREAK%This card's %CHARGE% cannot be recovered."""
        "Passive Sensors":
           display_name: """Passive Sensors"""
           text: """<strong>Action:</strong> Spend 1 %CHARGE%. You can only perform this action in your Perform Action step. %LINEBREAK% While your %CHARGE% is inactive, you cannot be coordinated. Before you engage, if your %CHARGE% is inactive, you may perform a %CALCULATE% or %LOCK% action."""
        "R2-A6":
           display_name: """R2-A6"""
           text: """ After you reveal your dial, you may set your dial to a maneuver of the same bearing of a speed 1 higher or lower."""
        "Amilyn Holdo":
           display_name: """Amilyn Holdo"""
           text: """ Before you engage, you may choose another friendly ship at range 1-2. You may transfer to that ship 1 token of a type that ship does not have. That ship may transfer 1 token to you of a type you do not have."""
        "Larma D'Acy":
           display_name: """Larma D'Acy"""
           text: """ While you have 2 or fewer stress tokens, you can perform %REINFORCE%, %COORDINATE%, and %JAM% actions, even while stressed.%LINEBREAK% While you perform a white %REINFORCE%, %COORDINATE%, or %JAM% action, if you are stressed, treat that action as red."""
        "PZ-4CO":
           display_name: """PZ-4CO"""
           text: """At the end of the Activation Phase, you may choose 1 friendly ship at range 1-2. If you do, transfer 1 calculate token to that ship. If your revealed maneuver is blue, you may transfer 1 focus token instead."""
        "Leia Organa (Resistance)":
           display_name: """Leia Organa"""
           text: """After a friendly ship reveals a non-[0 %STOP%] maneuver, you may spend 1 %FORCE%. If you do, the chosen ship reduces the difficulty of that maneuver.%LINEBREAK%<i>Errata (since rules reference 1.4): Added restriction on maneuver type)</i>"""
        "Korr Sella":
           display_name: """Korr Sella"""
           text: """After you fully execute a blue maneuver, remove all of your stress tokens."""
        "Precognitive Reflexes":
           display_name: """Precognitive Reflexes"""
           text: """After you reveal your dial, you may spend 1 %FORCE% to perform a %BARRELROLL% or %BOOST% action. Then, if you performed an action you do not have on your action bar, gain 1 strain token. %LINEBREAK% If you do, you cannot perform another action during your activation."""
        "Foresight":
           display_name: """Foresight"""
           text: """After an enemy ship executes a maneuver, you may spend 1 %FORCE% to perform this attack against it as a bonus attack. %LINEBREAK% <strong>Attack:</strong> You may change 1 %FOCUS% result to a %HIT% result; your dice cannot be modified otherwise."""
        "Angled Deflectors":
           display_name: """Angled Deflectors"""
           text: """ """
        "C1-10P":
           display_name: """C1-10P"""
           text: """<strong>C1-10P: </strong>Setup: Equip this side faceup. %LINEBREAK% After you fully execute a maneuver, you may spend 1 %CHARGE% to perform a red %EVADE% action, even while stressed. %LINEBREAK% During the End Phase, if this card has 0 active %CHARGE%, flip it. %LINEBREAK% <strong>C1-10P (Erratic):</strong> After you fully execute a maneuver, you <strong>must</strong> choose a ship at range 0-1. It gains 1 jam token.%LINEBREAK%<i>Errata (since rules reference 1.4): added "fully"</i>"""
        "Ahsoka Tano":
           display_name: """Ahsoka Tano"""
           text: """After you execute a maneuver, you may spend 1 %FORCE% and choose a friendly ship at range 1-3 in your firing arc. If you do, it may perform a red %FOCUS% action, even while stressed."""
        "C-3PO (Republic)":
           display_name: """C-3PO"""
           text: """While you defend, if you are calculating, you may reroll 1 defense die. %LINEBREAK% After you perform a %CALCULATE% action, gain 1 calculate token."""
        "Gravitic Deflection":
           display_name: """Gravitic Deflection"""
           text: """While you defend, you may reroll 1 defense die for each tractored ship in the attack arc."""
        "Snap Shot":
           display_name: """Snap Shot"""
           text: """After an enemy ship executes a maneuver, you may perform this attack against it as a bonus attack. %LINEBREAK% <strong>Attack:</strong> Your dice cannot be modified."""
        "Deuterium Power Cells":
           display_name: """Deuterium Power Cells"""
           text: """During the System Phase, you may spend 1 %CHARGE% and gain 1 disarm token to recover 1 %SHIELD%. Before you would gain 1 non-lock token, if you are not stressed, you may spend 1 %CHARGE% to gain 1 stress token instead."""
        "Mag-Pulse Warheads":
           display_name: """Mag-Pulse Warheads"""
           text: """<strong>Attack (%LOCK%):</strong> Spend 1 %CHARGE%. If this attack hits, the defender suffers 1 %CRIT% damage and gains 1 deplete and 1 jam token. Then cancel all %HIT%/%CRIT% results."""
        "Coaxium Hyperfuel":
           display_name: """Coaxium Hyperfuel"""
           text: """You can perform the %SLAM% action even while stressed. If you do, you suffer 1 %CRIT% damage unless you expose 1 of your damage cards. %LINEBREAK% After you partially execute a maneuver, you may expose 1 of your damage cards or suffer 1 %CRIT% damage to perform a %SLAM% action."""
        "R1-J5":
           display_name: """R1-J5"""
           text: """While you have 2 or fewer stress tokens, you can perform actions on damage cards even while stressed. %LINEBREAK% After you repair a damage card with the <b>Ship</b> trait, you may spend 1 %CHARGE% to repair that card again."""
        "Stabilized S-Foils":
           display_name: """Stabilized S-Foils"""
           text: """<strong>Closed: </strong><i><r>%RELOAD%</r>, %BARRELROLL% <i class="xwing-miniatures-font xwing-miniatures-font-linked"></i><r> %EVADE%</r></i>%LINEBREAK% Before you activate, if you are not critically damaged, you may flip this card. %LINEBREAK% <strong>Open:</strong> <i>%BARRELROLL% <i class="xwing-miniatures-font xwing-miniatures-font-linked"></i><r> %LOCK%</r></i>%LINEBREAK% After you perform an attack, you may spend your lock on the defender to perform a bonus %CANNON% attack against that ship using a %CANNON% upgrade you have not attacked with this turn. %LINEBREAK% Before you activate, if you are not critically damaged, you may flip this card."""
        "K-2SO":
           text: """During the System Phase, you may choose a friendly ship at range 0-3. That ship gains 1 calculate token and 1 stress token."""
        "Proud Tradition":
           text: """<strong>Proud Tradition</strong>%LINEBREAK%<strong>Setup:</strong> Equip this side faceup. %LINEBREAK% While you have 2 or fewer stress tokens, you may perform %FOCUS% actions even while stressed. After you perform an attack, if you are stressed, the defender may spend 1 focus token or suffer 1 %CRIT% damage to flip this card. %LINEBREAK% <strong>False Tradition</strong>%LINEBREAK% Treat your %FOCUS% actions as red."""
        "Cluster Mines":
           text: """<strong>Mine</strong>%LINEBREAK% During the System Phase, you may spend 1 %CHARGE% to drop a Cluster Mine set using the [1 %STRAIGHT%] template. %LINEBREAK% This card's %CHARGE% cannot be recovered."""
        "Kaz's Fireball":
           text: """<strong>Setup:</strong> When you resolve <strong>Explosion with Wings</strong>, you may search the damage deck and choose a damage card with the <b>Ship</b> trait: you are dealt that card instead. Then, shuffle the damage deck. %LINEBREAK% You can perform actions of damage cards even while ionized."""
        "Agent Terex":
           text: """<strong>Setup:</strong> Equip this side faceup and place 3 calculate tokens on this card. %LINEBREAK% At the start of the Engagement Phase, you may choose a friendly ship at range 0-3 and remove 1 calculate token from this card to have that ship gain a matching token. Then, if there are no calculate tokens on this card, flip it. %LINEBREAK%<strong>Cyborg:</strong> During the System Phase, roll 1 attack die. On a %HIT% or %CRIT% result, gain 1 calculate token. Otherwise gain 1 jam token. %LINEBREAK% <strong>Action:</strong> Transfer 1 calculate token or 1 jam token to a ship at range 0-3."""
        "Clone Captain Rex":
           text: """While you perform an attack, you may spend 1 %FOCUS% result. If you do, each friendly ship that has the defender in its %BULLSEYEARC% may gain 1 strain token to perform a %FOCUS% action."""
        '"Fives"':
           text: """After you perform an attack that missed, if the defender's initiative is equal or greater than your initiative, place 1 evade or focus token on this card. %LINEBREAK% Before you engage, you may remove 1 token from this card to gain 1 matching token."""
        "Suppressive Gunner":
           text: """While you perform an attack, you may spend 1 %FOCUS% result. If you do, the defender gains 1 deplete token unless it chooses to suffer 1 %HIT% damage."""
        "Ghost Company":
           text: """After you perform a primary attack, if you are focused, you may perform a %SINGLETURRETARC% attack against a ship you have not attacked this round as a bonus attack."""
        "Wolfpack":
           text: """After a friendly ship at range 0-3 defends, if the attacker is in your firing arc, the defender may gain 1 strain token to acquire a lock on the attacker."""
        "Yoda":
           text: """After another friendly ship at range 0-2 fully executes a purple maneuver or performs a purple action, you may spend 1 %FORCE%. If you do, that ship recovers 1 %FORCE%."""
        "Kit Fisto":
           text: """At the start of the Engagement Phase, you may choose 1 friendly ship at range 0-1 and spend 1 %FORCE%. If you do, it may perform a red %EVADE% action."""
        "Plo Koon":
           text: """At the start of the End Phase, if you are reinforced, you may choose 1 friendly ship at range 0 or in your %LEFTARC% or %RIGHTARC% at range 1. That ship removes 1 deplete or strain token, or repairs 1 faceup damage card."""
        "Repulsorlift Stabilizers":
           text: """<strong>Inactive: Setup:</strong> Equip this side faceup. Reduce the difficulty of your straight (%STRAIGHT%) maneuvers. %LINEBREAK% After you fully execute a maneuver, you may flip this card. %LINEBREAK%<strong>Active: </strong> After you reveal a bank (%BANKLEFT% or %BANKRIGHT%) or turn (%TURNLEFT% or %TURNRIGHT%), you <b>must</b> perform that maneuver as a slideslip, then flip this card. %LINEBREAK% After you fully execute a non-sideslip maneuver, you may flip this card."""
        "Multi-Missile Pods":
           text: """<strong>Attack (%CALCULATE% or %LOCK%):</strong> Spend 1 %CHARGE%. If the defender is in your %FRONTARC%, you may spend 1 %CHARGE% to roll 1 additional attack die. If the defender is in your %BULLSEYEARC%, you may spend up to 2 %CHARGE% to roll that many additional attack dice instead."""
        "Synced Laser Cannons":
           text: """<strong>Attack:</strong> If you are calculating, the defender does not apply the range bonus."""
        "Concussion Bombs":
           text: """During the System Phase, if any of this card's %CHARGE% are inactive, you <b>must</b> spend 1 %CHARGE% to drop 1 concussion bomb, if able, using the [1 %STRAIGHT%] template. Otherwise, you may spend 1 %CHARGE% to drop 1 concussion bomb. %LINEBREAK% <i>Errata (since rules reference 1.3.0): Added ""using the [1 %STRAIGHT%] template"</i>"""
        "Maneuver-Assist MGK-300":
           text: """Reduce the difficulty of your 3 straight (%STRAIGHT%) and bank (%BANKLEFT% or %BANKRIGHT%) maneuvers."""
        "Target-Assist MGK-300":
           text: """Before you engage, if you have no green tokens and you are not stressed, gain 1 calculate token for each enemy ship at range 2-3 in your firing arc, to a maximum of 2."""
        "Deadeye Shot":
           text: """While you perform a primary attack, if the defender is in your %BULLSEYEARC%, you may spend 1 %HIT% result or change 1 %CRIT% result to a %HIT% result. If you do, the defender exposes 1 of its damage cards."""
        "Marg Sabl Closure":
           text: """After you fully execute a maneuver, if you moved through an obstacle, structure, or huge ship, or if you deployed, you may choose 1 enemy ship in your %FRONTARC% at range 1-2. That ship gains 1 strain token."""
        "Hondo Ohnaka":
           text: """<strong>Action:</strong> Choose 2 ships at range 1-3 of you that are friendly to each other. Coordinate one of the chosen ships, then jam the other, ignoring range restrictions."""
        "Boba Fett (Separatist)":
           text: """While you perform an attack, if there are no other ships in the attack arc, you may change 1 of your %FOCUS% results to a %HIT% result."""
        "R2-D2 (Republic)":
           text: """After you activate, you may spend 1 %CHARGE% and gain 1 deplete token to repair 1 damage card, recover 1 shield or remove 1 device at range 0-1."""
        "Aayla Secura":
           text: """While an enemy ship in your %BULLSEYEARC% performs an attack, if the defender is friendly and at range 0-2, the defender may change 1 blank result to a %FOCUS% result."""
        "Patience":
           text: """At the start of the Engagement Phase, if there is an enemy ship in your %FRONTARC%, you may gain 1 deplete token to recover 1 %FORCE%."""
        "Syliure-31 Hyperdrive":
           text: """<strong>Setup:</strong> You can be placed anywhere in the play area beyond range 1 of obstacles, beyond range 3 of enemy ships, and beyond range 3 of the enemy table edge."""
        "Jedi Commander":
           text: """<strong>Setup Side:</strong>%LINEBREAK%Setup: Equip this side faceup. %LINEBREAK% You are a <b>wing leader</b>. Your wingmates must be 2-5 V-19 Torrents or 2-5 Nimbus-class V-wings. %LINEBREAK% After you are placed, flip this card. %LINEBREAK% <strong>Play Side:</strong>%LINEBREAK% While your wingmates execute purple maneuvers, they treat those maneuvers as red instead. %LINEBREAK% While you defend, up to 2 of your wingmates in the attack arc may each suffer 1 %HIT%/%CRIT% damage to cancel 1 matching result."""
        "Extreme Maneuvers":
           text: """While you perform a %BOOST% action, you may spend 1 %FORCE% to use the turn (%TURNLEFT% or %TURNRIGHT%) template instead."""
        "Starbird Slash":
           text: """After you fully execute a maneuver, you may choose 1 enemy ship you moved through. That ship gains 1 strain token. Then, if you are in that ship's firing arc, you gain 1 strain token."""
        "Backwards Tailslide":
           text: """While you boost or barrel roll, if your equipped %CONFIGURATION% upgrade has the "(Closed)" side faceup, you can move through and overlap obstacles. %LINEBREAK% After you boost or barrel roll through an obstacle, if you are not at range 0 of it, gain 1 evade token. """
        "Overdrive Thruster":
           text: """While you perform a red %BOOST%. %BARRELROLL%, or %SLAM% action, you <b>must</b> use a template of 1 speed higher if able."""
        "R2-D2 (Resistance)":
           text: """During the End Phase, you may spend 1 %CHARGE% and 1 %SHIELD% to remove 1 red token. %LINEBREAK% During the End Phase, if you have no active %SHIELD%, you may spend 2 %CHARGE% to recover 1 %SHIELD% and gain 1 deplete token."""
        "R6-D8":
           text: """While you perform an attack, you may reroll a number of attack dice up to the number of friendly ships at range 0-3 that have the defender in their %BULLSEYEARC%."""
        "Underslung Blaster Cannon":
           text: """After an enemy ship executes a maneuver, you may perform this attack against it as a bonus attack. %LINEBREAK% <strong>Attack (%LOCK%):</strong> Your dice can be modified only by spending a lock for the default effect."""
        "Commander Pyre":
           text: """<strong>Setup:</strong> After placing forces, choose an enemy ship. It gains 2 stress tokens. %LINEBREAK% While you defend, if the attacker is stressed, you may reroll 1 defense die."""
        "Commander Malarus":
           text: """<strong>Setup:</strong> Equip this side face up. %LINEBREAK% While a friendly non-limited ship at range 0-1 performs a primary attack, that ship may reroll 1 blank result. If it does and the attack does not hit, you <b>must</b> flip this card. %LINEBREAK%<strong>Perfected:</strong> While you perform an attack, if the defender is in your %BULLSEYEARC%, you <b>must</b> convert all %FOCUS% results to %HIT% results and gain 1 stress token. Then, if you have 2 or more stress tokens, suffer 1 %HIT% damage."""
        "Automated Target Priority":
           text: """While you perform an attack, you <b>must</b> choose a defender at the closest valid attack range. %LINEBREAK% After you perform an attack that missed, place 1 calculate token on this card. %LINEBREAK% Before you engage, you may remove 1 calculate token from this card to gain a matching token."""
        "Sensor Buoy Suite":
           text: """<strong>Setup:</strong> Before placing forces, place 2 sensor buoy remotes beyond range 2 of any edge. %LINEBREAK% Before you engage, you may acquire a lock on a ship at range 0-1 of a friendly sensor buoy, ignoring range restrictions."""
        "Kalani":
           text: """After an enemy ship executes a maneuver, if it is in the %BULLSEYEARC% of a friendly ship at range 0-3, you may spend 1 %CHARGE%. If you do, that friendly ship acquires a lock on that enemy ship, then gains 1 stress token."""
        'Alpha-3B "Besh"':
           text: """While you perform a primary attack, you may spend your lock on the defender to change 1 of your blank or %FOCUS% results to a %HIT% result."""
        'Alpha-3E "Esk"':
           text: """While you perform a primary attack, before rolling attack dice, you may spend 2 charges. If you do, your %CRIT% results inflict ion tokens instead of damage."""
        "Thermal Detonators":
           text: """<strong>Bomb</strong>%LINEBREAK% During the System Phase, you may spend up to 2 %CHARGE% to drop that many Thermal Detonators using the [1 %STRAIGHT%] or [2 %STRAIGHT%] template. Each must be placed using a different template. %LINEBREAK% When you reload this card, recover 1 additional %CHARGE%."""
        "R7-A7":
           text: """While you perform an attack, you may spend 1 %CHARGE% to change 1 %HIT% result to a %CRIT% result."""
        "Q7 Astromech":
           text: """While you barrel roll or boost, you can move through and overlap obstacles."""
        "Ion Limiter Override":
           text: """After you fully execute a red maneuver, you may perform a %BARRELROLL% action, even while stressed. If you do, roll an attack die: On a %HIT% result gain 1 strain token, and on a %CRIT% result gain 1 ion token."""
        "Precision Ion Engines":
           text: """Before you execute a speed 1-3 Koiogran Turn [%KTURN%] maneuver, you may spend 1 %CHARGE% to execute that maneuver as a Segnor's Loop [%SLOOPLEFT% or %SLOOPRIGHT%] maneuver instead."""
        "Intercept Booster":
           text: """<strong>Attached:</strong> %SLAM% <i class="xwing-miniatures-font xwing-miniatures-font-linked"></i> <r>%LOCK%</r></i>%LINEBREAK% <strong>Setup:</strong> Equip this side faceup. %LINEBREAK% <i>(Added Actions available on this side only)</i>%LINEBREAK% During the System Phase, gain 1 disarm token unless you flip this card. %LINEBREAK% At the end of the End Phase, if you have no active %CHARGE%, flip this card. %LINEBREAK% <strong>Detached:</strong> <i>Empty</i>"""
        "XX-23 S-Thread Tracers":
           text: """<strong>Attack: [%FOCUS%, %CALCULATE%, or %LOCK%]</strong>Spend 1 %CHARGE%. If this attack hits, each friendly ship at range 1-3 of the defender may acquire a lock on the defender. Then cancel all dice results."""
        "Independent Calculations":
           text: """Replace your <strong>Networked Calculations</strong> ship ability with the following: %LINEBREAK% <strong>Independent Calculations:</strong> While you perform a white %CALCULATE% action, you may treat it as red to gain 1 additional calculate token. Other ships cannot spend your calculate tokens using the <strong>Networked Calculations</strong> ship ability."""
        "Jango Fett":
           text: """While you defend or perform an attack, you may spend your lock on the enemy ship to change 1 of the enemy ship's %FOCUS% results to a blank result."""
        "Zam Wesell":
           text: """<strong>Setup:</strong> Lose 2 %CHARGE%. %LINEBREAK% During the System Phase, you may assign 1 of your secret conditions to yourself facedown: <strong> %LINEBREAK% You Should Thank Me %LINEBREAK% You'd Better Mean Business. </strong>"""
        "Boba Fett (Separatist)":
           display_name: """Boba Fett"""
           text: """While you perform an attack, if there are no other ships in the attack arc, you may change 1 of your %FOCUS% results to a %HIT% result."""
        "Slave I (Separatist)":
           display_name: """Slave I"""
           text: """While you perform a %FRONTARC% attack, if you are in the defender's %FULLREARARC%, you may change 1 %HIT% result to a %CRIT% result."""
        "Weapons Systems Officer":
           text: """After you perform a special attack with the %LOCK% requirement, you may acquire a lock on the defender."""
        "False Transponder Codes":
           text: """After you acquire a lock on an object or an object acquires a lock on you, if you have 1 active %CHARGE%, lose 1 %CHARGE% and jam that object, ignoring range restrictions."""

        "Vectored Cannons (RZ-1)":
           text: """Gain a %SINGLETURRETARC% indicator. Treat the arc requirement of your %FRONTARC% primary attack as %SINGLETURRETARC%. %LINEBREAK% Replace your <strong>Vectored Thrusters</strong> ship ability with the following: %LINEBREAK%<strong>Vectored Cannons:</strong> During the System Phase, you may perform a red %BOOST% or red %ROTATEARC% action. You can rotate your %SINGLETURRETARC% indicator only to your %FRONTARC% or %REARARC%."""
        "B6 Blade Wing Prototype (Epic)":
           text: """Attack (%LOCK%): Gain 1 ion token to perform this attack. If this attack hits, the defender suffers 1 additional %HIT%/%CRIT% damage for each matching uncanceled result after the first."""
        "TIE Defender Elite":
           text: """Decrease the difficulty of your turn (%TURNLEFT% or %TURNRIGHT%) maneuvers. Increase the difficulty of your Koiogran Turn (%KTURN%) maneuvers. Replace your <strong>Full Throttle</strong> ship ability with the following: %LINEBREAK% <strong>Advanced Fire Control:</strong> After you perform a %CANNON% or %MISSILE% attack, if you have a lock on the defender, you may perform a bonus primary attack against the defender."""
        "Sensitive Controls":
           text: """Replace your <strong>Autothrusters</strong> ship ability with the following: %LINEBREAK% <strong>Sensitive Controls</strong>: During the System Phase, you may perform a red %BARRELROLL% or red %BOOST% action."""
        "Cutthroat":
           text: """After another friendly ship at range 0-3 is destroyed, if that ship is limited or has the <strong>Cutthroat</strong> upgrade, you may remove 1 of your orange or red tokens, or recover 1 non-recurring %CHARGE% on your ship card or one of your equipped upgrade cards."""
        "Tierfon Belly Run":
           text: """You can perform special attacks even while at range 0 of asteroids. %LINEBREAK% While you defend, if you are at range 0 of an obstacle, attack dice cannot be rerolled."""
        "B6 Blade Wing Prototype":
           text: """ """
        "Phoenix Squadron":
           text: """<strong>Setup Side:</strong>%LINEBREAK%Setup: Equip this side faceup. %LINEBREAK% You are a <b>wing leader</b>. Your wingmates must be 2-5 of the following: %LINEBREAK% - 0-1 Attack Shuttle %LINEBREAK% - 0-1 Sheathipede-class Shuttle %LINEBREAK% - 0-5 RZ-1 A-wings %LINEBREAK% After you are placed, flip this card. %LINEBREAK% <strong>Play Side:</strong>%LINEBREAK% At the start of the Planning Phase, 1 of your wingmates that is docked with you may join your wing without gaining a stress token. %LINEBREAK% While you or your Attack Shuttle wingmate or Sheathipede-class wingmate defends, up to 2 of your RZ-1 A-Wing wingmates in the attack arc may each suffer 1 %HIT%/%CRIT% damage to cancel 1 matching result."""
        "Hopeful":
           text: """After another friendly ship at range 0-3 is destroyed, if that ship is limited or has the <strong>Hopeful</strong> upgrade, you may perform a %FOCUS% or %BOOST% action."""
        "Sabine Wren (Gunner)":
           display_name: """Sabine Wren"""
           text: """After you perform a special attack, you may choose a number of friendly ships at range 0-3 of the defender up to the number of damage cards dealt to the defender during that attack. Each chosen ship may remove 1 strain or stress token."""
        "Disciplined":
           text: """After another friendly ship at range 0-3 is destroyed, if that ship is limited or has the <strong>Disciplined</strong> upgrade, you may perform a %LOCK% or %BARRELROLL% action."""
        "Shadow Wing":
           text: """<strong>Setup Side:</strong>%LINEBREAK%Setup: Equip this side faceup. %LINEBREAK% You are a <b>wing leader</b>. Your wingmates must be 2-5 other ships of your type. %LINEBREAK% After you are placed, flip this card. %LINEBREAK% <strong>Play Side:</strong>%LINEBREAK% Your wingmates can perform %BARRELROLL% or %BOOST% actions. If they do, they voluntarily split from the wing. %LINEBREAK% While you defend, up to 2 of your wingmates in the attack arc may each suffer 1 %HIT%/%CRIT% damage to cancel 1 matching result."""
        "Skystrike Academy Class":
           text: """<strong>Setup Side:</strong>%LINEBREAK%Setup: Equip this side faceup. %LINEBREAK% You are a <b>wing leader</b>. Your wingmates must be 2-5 TIE/ln FIghters with initiative lower than yours. %LINEBREAK% After you are placed, flip this card. %LINEBREAK% <strong>Play Side:</strong>%LINEBREAK% After you barrel roll or boost, each of your wingmates is forced to split from the wing %LINEBREAK% While you defend, up to 5 of your wingmates in the attack arc may each suffer 1 %HIT%/%CRIT% damage to cancel 1 matching result."""
        "In It For The Money":
           text: """<strong>In It For The Money:</strong>%LINEBREAK%Setup: Equip this side faceup. %LINEBREAK% You can be included in Republic, Rebel, and Resistance squads. %LINEBREAK% After an allied limited ship in your squad is destroyed, gain 1 focus token and flip this card. %LINEBREAK% <strong>In It For Your Rebellion:</strong>%LINEBREAK% Non-Scum ships in your squad are treated as friendly instead of allied."""
        "Bounty":
           text: """<strong>Hired:</strong>%LINEBREAK%Setup: Equip this side faceup. %LINEBREAK% You can be included in Separatist, Imperial , and First Order squads. %LINEBREAK% After you perform an attack, if the defender was a limited ship and was destroyed, you may recover 1 %CHARGE% on your ship card and each of your upgrade cards. Then flip this card. %LINEBREAK% <strong>Paid:</strong>%LINEBREAK% """
        "Gamut Key":
           text: """At the start of the End Phase, you may spend 2 %CHARGE% to choose a ship at range 0-1 with 1 or more circular tokens. During the End Phase, circular tokens are not removed from that ship."""
        "Interloper Turn":
           text: """Before you execute a speed 1-2 turn (%TURNLEFT% or %TURNRIGHT%) or speed 1-2 Koiogran Turn (%KTURN%), if you are at range 0-1 of an asteroid, structure, or huge ship, you may gain 1 tractor token."""
        "Protectorate Gleb":
           text: """After you coordinate a friendly ship, you may transfer 1 orange or red token to the ship you coordinated. %LINEBREAK% <i>Errata (RR: 1.2.0 [06/14/2021]): Added restriction stipulating friendly ship</i>"""
        "R4-B11":
           text: """While you perform an attack, you may remove 1 orange or red token from the defender to reroll any number of defense dice."""
        "Wartime Loadout":
           text: """Gain 1 %TORPEDO% slot and 1 %MISSILE% slot. Replace your ship ability with the following: %LINEBREAK%<strong>Devastating Barrage:</strong> While you perform a %TORPEDO% or %MISSILE% attack, if the defender is in your %BULLSEYEARC%, your %CRIT% results cannot be cancelled by %EVADE% results."""
        "Watchful Astromech":
           text: """After you perform a %RELOAD% or %ROTATEARC% action, if you are in an enemy ship's firing arc, you may perform a red %CALCULATE% action."""
        "L4E-R5":
           text: """At the start of the Engagement Phase, you may transfer 1 calculate token to a friendly ship in your firing arc."""
        "Overtuned Modulators":
           text: """During the System Phase, if you are not stressed, you may spend 1 %CHARGE% to gain 3 calculate tokens. %LINEBREAK% During the End Phase, if your %CHARGE% is inactive, for each green token you remove, gain 1 strain token."""
        "Sensor Scramblers":
           text: """<strong>Setup:</strong> Gain 1 Cloak token. %LINEBREAK% While you are cloaked, other ships cannot acquire locks on you. %LINEBREAK% During the End Phase, if you are cloaked and there is an enemy ship at range 0-3, you must decloak. If you do and that decloak fails, lose 1 cloak token."""
        "Enhanced Jamming Suite":
           text: """While you jam, you can choose yourself or another friendly ship. %LINEBREAK% While you defend, if the attacker has no green tokens or there is a jammed ship in the attack arc, you may roll 1 additional defense die."""
        "Compassion":
           text: """Before another friendly ship at range 0-2 would be dealt a faceup <b>Pilot</b> or <b>Crew</b> damage card, you may spend 1 %FORCE%. If you do, that damage card is discarded instead, and you are dealt 1 facedown damage card. Then, if  you have 2 or more damage cards, recover 2 %FORCE%."""
        "Malice":
           text: """While you perform an attack, you may spend 1 %FORCE% to change 1 %FOCUS% or %HIT% result to a %CRIT% result. If you do, after you perform that attack, if the defender was dealt 1 or more faceup <b>Pilot</b> or <b>Crew</b> damage cards, recover 2 %FORCE%."""
        "Shattering Shot":
           text: """While you perform an attack, if the attack is obstructed by an obstacle or the defender is at range 0 of an obstacle, you may spend 1 %FORCE% to add 1 %FOCUS% result."""
        "DT-798":
           text: """At the start of the Engagement Phase, you may choose a friendly ship in your firing arc. If you do, that ship gains 1 strain token. %LINEBREAK% While you perform an attack, you may reroll up to 1 die for each ship in the attack arc with 1 or more non-lock red or orange tokens."""
        "Feedback Ping":
           text: """After an enemy ship executes a maneuver, if it is at range 0-1 of a friendly device, you may acquire a lock on that ship, ignoring range restrictions."""
        "Electro-Chaff Missiles":
           text: """During the System Phase, you may spend 1 %CHARGE% from this card to launch 1 electro-chaff cloud using the [3 %BANKLEFT%], [3 %BANKRIGHT%], or [4 %STRAIGHT%] template. Then place 1 fuse marker on it. %LINEBREAK% This card's %CHARGE% cannot be recovered.."""
        "Babu Frik":
           text: """Before you would gain a non-lock red or orange token, you may spend 1 %CHARGE% to place it on this card instead. During the System Phase, if there are 1 or more tokens on this card, you <b>must</b> spend 1 %CHARGE%. If you cannot, remove those tokens and gain matching tokens."""
        "Ahsoka Tano (Crew)":
           display_name: """Ahsoka Tano"""
           text: """After you fully execute a maneuver, you may spend 1 %FORCE% to choose 1 friendly ship in your %FULLREARARC% at range 1-2. If you do, that ship may perform a red %FOCUS% action, even while stressed."""
        "Bo-Katan Kryze (Republic/Separatist)":
           display_name: """Bo-Katan Kryze"""
           text: """While you perform an attack, if you are at range 0-1 of the defender, you may reroll 1 attack die."""
        "Bo-Katan Kryze (Rebel/Scum)":
           display_name: """Bo-Katan Kryze"""
           text: """After you perform an attack, if the defender was destroyed, each friendly ship at range 0-2 may remove 1 red or orange token."""
        "Fenn Rau":
           display_name: """Fenn Rau"""
           text: """Before a friendly ship at range 0-2 engages, if its revealed maneuver is 1 speed or higher and there is an enemy ship in its %FRONTARC% at range 1, that friendly ship may remove 1 non-lock red token."""
        "Captain Hark":
           display_name: """Captain Hark"""
           text: """After you fully execute a red maneuver, if you are not focused, you may spend 1 %CHARGE% to gain 1 focus token."""
        "Gar Saxon":
           display_name: """Gar Saxon"""
           text: """While a friendly unit at range 1-3 with an initiative of 4 or lower performs an attack against a defender you have locked, the attacker may change 1 %FOCUS% result to a %HIT% result."""
        "Gar Saxon (Gunner)":
           display_name: """Gar Saxon"""
           text: """While you perform the %LOCK% action, you can only choose an object in your %FRONTARC% or %REARARC%. %LINEBREAK% While you perform a primary attack, if the defender is in your %FRONTARC% or %REARARC%, you may remove 1 orange or red token from the defender to roll 1 additional die, to a maximum of 4."""
        "Korkie Kryze":
           display_name: """Korkie Kryze"""
           text: """After a friendly ship in your %FULLFRONTARC% at range 1-2 becomes the defender, you may transfer 1 green token to it. %LINEBREAK% While a friendly ship in your %FULLFRONTARC% at range 1-2 defends, if you obstruct the attack, the defender rolls 1 additional defense die."""
        "Obi-Wan Kenobi":
           display_name: """Obi-Wan Kenobi"""
           text: """After a friendly ship at range 0-2 spends a focus or evade token, you may spend 1 %FORCE%. If you do, that ship gains 1 focus token."""
        "Pre Vizsla":
           display_name: """Pre Vizsla"""
           text: """While you perform a %COORDINATE% action, you can choose a friendly %CREW% remote instead of another friendly ship. Instead of performing an action, that remote relocations forward using a [1 %TURNLEFT%], [1 %TURNRIGHT%], or [2 %STRAIGHT%] template."""
        "Obi-Wan Kenobi":
           display_name: """Obi-Wan Kenobi"""
           text: """After a friendly ship at range 0-2 spends a focus or evade token, you may spend 1 %FORCE%. If you do, that ship gains 1 focus token."""
        "Rook Kast":
           display_name: """Rook Kast"""
           text: """After you perform a red action, you may gain 1 strain token. %LINEBREAK% While you perform an attack, if you are strained, you may change 1 of your blank or %FOCUS% results to a %HIT% result."""
        "Satine Kryze":
           display_name: """Satine Kryze"""
           text: """At the start of the Engagement Phase, you may spend 2 %CHARGE%. If you do, each friendly ship may choose to gain 1 deplete token and 1 focus token or to gain 1 disarm token and 1 evade token."""
        "Savage Opress":
           display_name: """Savage Opress"""
           text: """After a friendly ship in your %FRONTARC% at range 1-2 gains a stress or strain token, you may spend 1 %FORCE%. If you do, that ship gains 1 focus token."""
        "Tal Merrik":
           display_name: """Tal Merrik"""
           text: """<strong>Setup:</strong> Before placing forcse, choose 1 enemy ship and assign the <b>False Friend</b> condition to it. %LINEBREAK% <strong>Action:</strong> If the <b>False Friend</b> condition is not assigned to an enemy ship, assign it to an enemy ship in your %FRONTARC% at range 0-2."""
        "Tiber Saxon":
           display_name: """Tiber Saxon"""
           text: """After you perform an attack at attack range 1-2 that hits, if the defender has no faceup damage cards, you may spend 1 or more %CHARGE%. For each %CHARGE% you spend, the defender gains 1 strain token."""
        "Tristan Wren":
           display_name: """Tristan Wren"""
           text: """While a friendy unit at range 0-3 performs a %RANGEBONUS% attack, you may spend 1 %CHARGE%. If you do, the attacker may change 1 %HIT% result to a %CRIT% result."""
        "Ursa Wren":
           display_name: """Ursa Wren"""
           text: """ You can maintain up to 2 locks. Each lock must be on a different object. After a friendly ship at range 0-3 is locked by an enemy ship, you may perform a %LOCK% action. %LINEBREAK% <i>Errata (since rules reference 1.4.2): Updated text to work as intended</i>"""
        "Ursa Wren (Gunner)":
           display_name: """Ursa Wren"""
           text: """After you acquire a lock on an enemy unit beyond range 2, if there are no friendly units at range 0-1 of the locked unit, gain 1 calculate token."""
        "Sabine Wren (Command)":
           display_name: """Sabine Wren"""
           text: """<strong>Setup:</strong> Before placing forces, assign the <b>Trials of the Darksaber</b> condition to yourself. %LINEBREAK% While you perform a %COORDINATE% action, you may coordinate 1 additional friendly ship."""
        "Prime Minister Almec":
           display_name: """Prime Minister Almec"""
           text: """<strong>Setup:</strong> Equip this side faceup. %LINEBREAK% After a friendly ship at range 0-2 reveals a white maneuver, if it has no green tokens, it may gain 1 stress token to gain 1 calculate token. %LINEBREAK% During the End Phase, if you have 2 or more stress tokens, flip this card. %LINEBREAK% <strong>Almec, Maul's Puppet</strong> %LINEBREAK% After a friendly ship at range 0-2 fully executes a red maneuver, that ship may perform a %CALCULATE% or %FOCUS% action on its action bar, even while stressed."""
        "Beskar Reinforced Plating":
           text: """While you defend, if the attacker is in your %FRONTARC%, before you would be dealt a faceup damage card, you may spend 1 %CHARGE% to be dealt that card facedown instead, or spend 2 %CHARGE% to discard it instead."""
        "Blazer Bomb":
           text: """<strong>Bomb</strong>%LINEBREAK% During the System Phase, you may spend 1 %CHARGE% to drop a Blazer Bomb using the [1 %STRAIGHT%] template."""
        "Mandalorian Optics":
           text: """During the System Phase, you may spend 1 %CHARGE% to acquire a lock on an object in your %FRONTARC%. %LINEBREAK% While you perform a primary attack, if you have a lock on the defender, ignore obstacles beyond range 0 obstructing the attack."""
        "Clan Training":
           text: """Before you engage, if you are not focused and there is an enemy ship in your %FRONTARC% at range 1, you may spend 1 %CHARGE% to perform a red %FOCUS% action. %LINEBREAK% After you perform an attack, if the defender is destroyed, recover 1 %CHARGE%."""
        "Gauntlet":
           text: """During the System Phase, you may spend 1 %CHARGE% to repair 1 faceup <b>Ship</b> damage card."""
        "Nightbrother":
           text: """After you reveal a non-blue maneuver, if you are stressed, you may spend 2 %CHARGE% to gain 1 focus or evade token."""
        "Swivel Wing":
           text: """<strong>Swivel Wing (Down)</strong> %LINEBREAK% After you execute a [0 %STOP%] maneuver, you may rotate your ship 90º or 180º. If you do, you <b>must</b> flip this card. %LINEBREAK% <strong>Swivel Wing (Up)</strong> %LINEBREAK% While you defend, roll 1 fewer defense die. %LINEBREAK% After you fully execute a non-stationary [%STOP%] maneuver, you may flip this card."""
        "Clan Wren Commandos":
           text: """During the System Phase, you may spend 1 %CHARGE% to drop a Commando Team remote using the [1 %STRAIGHT%] template. You can place that device using the front or rear guides. %LINEBREAK% This card's %CHARGE% cannot be recovered."""
        "Death Watch Commandos":
           text: """During the System Phase, you may spend 1 %CHARGE% to drop a Commando Team remote using the [1 %STRAIGHT%] template. You can place that device using the front or rear guides. %LINEBREAK% This card's %CHARGE% cannot be recovered."""
        "Nite Owl Commandos":
           text: """During the System Phase, you may spend 1 %CHARGE% to drop a Commando Team remote using the [1 %STRAIGHT%] template. You can place that device using the front or rear guides. %LINEBREAK% This card's %CHARGE% cannot be recovered."""
        "Imperial Super Commandos":
           text: """During the System Phase, you may spend 1 %CHARGE% to drop a Commando Team remote using the [1 %STRAIGHT%] template. You can place that device using the front or rear guides. %LINEBREAK% This card's %CHARGE% cannot be recovered."""
        "Mandalorian Super Commandos":
           text: """During the System Phase, you may spend 1 %CHARGE% to drop a Commando Team remote using the [1 %STRAIGHT%] template. You can place that device using the front or rear guides. %LINEBREAK% This card's %CHARGE% cannot be recovered."""
        "Razor Crest":
           text: """<strong>Setup:</strong> Place 1 non-limited %ILLICIT% upgrade facedown under this card. %LINEBREAK% During the System Phase, you may reveal that %ILLICIT% upgrade and equip it as if it were equipped at Setup (without paying its points cost)."""
        "The Mandalorian":
           text: """During the End Phase, if you did not defend this round, recover 1 non-recurring %FORCE%, if able."""
        "The Child":
           text: """<strong>Setup:</strong> After placing forces, choose an opponent; they assign the <b>Merciless Pursuit</b> condition to two of their ships. %LINEBREAK% Your %FORCE% lose the recurring icon. After you defend, if you suffered damage during that attack, recover 1 %FORCE%."""
        "Tracking Fob":
           text: """<strong>Setup:</strong> After placing forces, choose an opponent; they assign the <b>Marked for Elimination</b> condition to 1 of their ships. They must assign it to a limited ship, if able. %LINEBREAK% You ignore range restrictions while acquiring locks on the ship with the <b>Marked for Elimination</b> condition."""
        "Notorious":
           text: """After you defend, if the attacker is in your firing arc, you may spend 1 %CHARGE%. If you do, the attacker gains 1 strain token. %LINEBREAK% While you perform an attack, if the defender is strained, you may reroll 1 blank result."""
        "Enduring":
           text: """While you defend, if you are not in the attacker's %BULLSEYEARC%, %CRIT% results are neutralized before %HIT% results. %LINEBREAK% After you suffer %CRIT% damage, you may perform a %CALCULATE% or %FOCUS% action on your action bar, even while stressed, treating that action as red."""
        "IG-11":
           text: """<strong>Setup:</strong> Equip this side faceup. %LINEBREAK% Before you would be dealt a faceup damage card, you <b>must</b> place 1 fuse marker on this card and gain 1 calculate token instead. Then if there are 2 fuse markers on this card, flip it. %LINEBREAK% <strong>IG-11 (Anti-Capture Protocol)</strong> %LINEBREAK% During the End Phase, remove 1 fuse marker from this card. Then, if this card has no fuse markers on it, you are destroyed and each other ship at range 0-1 suffers 1 %CRIT% damage. %LINEBREAK% <strong>Action:</strong> Place 1 fuse marker on this card."""
        "Greef Karga":
           text: """You can coordinate allied ships as if they were friendly ships. %LINEBREAK% After you coordinate a ship, it may acquire a lock on an object you have locked."""
        "Kuiil":
           text: """<strong>Action:</strong> Roll 1 attack die for each damage card you have. For each %HIT% result, repair 1 faceup <b>Ship</b> damage card, then for each %CRIT% result, repair 1 facedown damage card. For each blank result, remove 1 orange token, then for each %FOCUS% result, gain 1 focus token."""
        "Peli Motto":
           text: """During the System Phase, you may perform an action on 1 of your damage cards, even while stressed. %LINEBREAK% After you repair a faceup <b>Ship</b> damage card, you may roll 1 attack die. On a %HIT% result, repair another faceup <b>Ship</b> damage card. On a %CRIT% result, expose 1 damage card."""
        "Migs Mayfeld":
           text: """After you perform a %FRONTARC% attack, you may perform a %REARARC% or %SINGLETURRETARC% attack as a bonus attack against a different target with 1 or more red or orange tokens."""
        "Burnout Thrusters":
           text: """After you perform a %SLAM% action, lose 1 %CHARGE%. Then you may gain 1 deplete token to remove 1 disarm token. %LINEBREAK% If your %CHARGE% is inactive, you cannot perform the %SLAM% action."""
        "Hotshot Tail Blaster":
           text: """This attack can be performed at range 0. %LINEBREAK% <strong>Attack:</strong> Spend 1 %CHARGE%."""
        "Drop-Seat Bay":
           text: """If you would drop a %CREW% remote using a [%STRAIGHT%] template, you may use a bank [%BANKLEFT% or %BANKRIGHT%] tempalte of the same speed instead and can align that template's middle line with the hashmark on your ship's left or right side instead of your rear guides."""
        "Combat Boarding Tube":
           text: """During the System Phase, if you would drop a %CREW% remote and there is an enemy medium, large, or huge ship at range 0-1 in your %REARARC%, you may place that device in the play area in your %REARARC% at range 0-1 so that it is at range 0 of that enemy ship instead. Then, that enemy ship gains 1 deplete, strain, or stress token of your choice."""
        "Proton Cannons":
           text: """<strong>Attack:</strong> Spend 2 %CHARGE%. Change 1 %FOCUS% or %HIT% result to a %CRIT% result."""
        "Homing Torpedoes":
           text: """<strong>Attack (%LOCK%):</strong> Spend 1 %CHARGE%. After you declare the defender, the defender may choose to suffer 1 %CRIT% damage. If it does, skip the Attack and Defense Dice steps and the attack is treated as hitting."""
        "Xanadu Blood":
           text: """Add %CREW% and %DEVICE% slots."""

        # Standardized upgrades
        "Fanatic (BoY)":
           display_name: """Fanatic"""
           text: """While you perform a primary attack, if you are damaged, you may change 1 %FOCUS% result to a %HIT% result."""
        "Vengeful (BoY)":
           display_name: """Vengeful"""
           text: """After a friendly ship at range 0-3 is destroyed, if that ship is limited, you may remove 1 of your red tokens or recover 1 recurring charge on your ship card."""
        "Chewbacca (BoY)":
           display_name: """Chewbacca"""
           text: """After you perform an %EVADE% action, you may gain 1 focus token."""
        "L3-37's Programming (BoY)":
           display_name: """L3-37's Programming"""
           text: """If you are not shielded, decrease the difficulty of your bank (%BANKLEFT% and %BANKRIGHT%) maneuvers."""
        "Unstable Sublight Engines (BoY)":
           display_name: """Unstable Sublight Engines"""
           text: """After you are destroyed, you <b>must</b> execute a [1 %STRAIGHT%] maneuver, then each other ship at range 0-1 suffers 1 %HIT% damage."""
        "Attack Speed (BoY)":
           display_name: """Attack Speed"""
           text: """After you fully execute a [3 %STRAIGHT%] or [4 %STRAIGHT%] maneuver, you may perform a boost using the [1 %STRAIGHT%] template. (This is not an action)."""
        "R2-D2 (BoY)":
           display_name: """R2-D2"""
           text: """After you reveal your dial, you may spend 1 %CHARGE% and gain 1 disarm token to recover 1 shield."""
        "R2-F2 (BoY)":
           display_name: """R2-F2"""
           text: """After you reveal your dial, you may spend 1 %CHARGE% and gain 1 disarm token to recover 1 shield."""
        "R2-A3 (BoY)":
           display_name: """R2-A3"""
           text: """After you reveal your dial, you may spend 1 %CHARGE% and gain 1 disarm token to recover 1 shield."""
        "R5-D8 (BoY)":
           display_name: """R5-D8"""
           text: """<strong>Action:</strong> Spend 1 %CHARGE% to repair 1 facedown damage card. %LINEBREAK% <strong>Action:</strong> Repair 1 faceup <strong>Ship</strong> damage card."""
        "R5-K6 (BoY)":
           display_name: """R5-K6"""
           text: """<strong>Action:</strong> Spend 1 %CHARGE% to repair 1 facedown damage card. %LINEBREAK% <strong>Action:</strong> Repair 1 faceup <strong>Ship</strong> damage card."""
        "Precise Astromech (BoY)":
           display_name: """Precise Astromech"""
           text: """After you perform an action, you may spend 1 %CHARGE% to perform a red %LOCK% action."""
        "Targeting Astromech (BoY)":
           display_name: """Targeting Astromech"""
           text: """After you perform a %LOCK% action, you may perform a red %ROTATEARC% action."""
        "Dorsal Turret (BoY)":
           display_name: """Dorsal Turret"""
           text: """<strong>Attack</strong>"""
        "Sensor Jammer (BoY)":
           display_name: """Sensor Jammer"""
           text: """While defending, if there is a friendly lock on the attacker, you may change 1 of the attacker's %HIT% results to a %FOCUS% result."""
        "Ancillary Ion Weapons (SoC)":
           display_name: """Ancillary Ion Weapons"""
           text: """While you perform a primary %FRONTARC% attack, before rolling attack dice, you may spend 2 %CHARGE%. If you do, your %CRIT% results deal ion tokens instead of damage."""
        "Roiling Anger (SoC)":
           display_name: """Roiling Anger"""
           text: """At the start of the Engagement Phase, if you are in an enemy ship's %FRONTARC%, you may gain 1 strain to recover 1 %FORCE%."""
        "Contingency Protocol (SoC)":
           display_name: """Contingency Protocol"""
           text: """After this ship is destroyed another friendly ship at range 0-3 with <b>Contingency Protocol</b> may perform an action, even while stressed."""
        "Evasion Sequence 7 (SoC)":
           display_name: """Evasion Sequence 7"""
           text: """While you perform a red %EVADE% action, if there is an obstacle or scenario feature at range 1, treat the action as white, instead."""
        "Strut-Lock Override (SoC)":
           display_name: """Strut-Lock Override"""
           text: """At the start of your activation, you may spend 1 %CHARGE%. If you do, ignore obstacles while you move through them this round."""
        "R4-P17 (SoC)":
           display_name: """R4-P17"""
           text: """When you would be dealt a damage card, if you are not defending, you may spend 1 %CHARGE% and gain 1 strain to discard it instead."""
        "Wolfpack (SoC)":
           display_name: """Wolfpack"""
           text: """While you perform an attack, you may spend a lock belonging to a friendly <b>Plo Koon</b> ship or ship with the <b>Born for This</b> ability that is on the defender to reroll any number of attack dice."""


        # Epic upgrades
        "Admiral Ozzel":
           display_name: """Admiral Ozzel"""
           text: """While a friendly large or huge ship at range 0-3 executes a maneuver, it may suffer 1 %HIT% damage to execute a maneuver of the same bearing and difficulty of a speed 1 higher or lower instead."""
        "Azmorigan":
           display_name: """Azmorigan"""
           text: """During the End Phase, you may choose up to 2 friendly ships at range 0-1. If you do, each of these ships does not remove 1 calculate or evade token."""
        "Captain Needa":
           display_name: """Captain Needa"""
           text: """After a friendly ship at range 0-4 reveals its dial, you may spend 1 %CHARGE%. If you do, it sets its dial to another maneuver of the same difficulty and speed."""
        "Strategic Commander":
           display_name: """Strategic Commander"""
           text: """After a friendly ship at range 0-4 reveals its dial, you may spend 1 %CHARGE%. If you do, it sets its dial to another maneuver of the same difficulty and speed."""
        "Carlist Rieekan":
           display_name: """Carlist Rieekan"""
           text: """After a friendly ship at range 0-2 is destroyed, you may choose a friendly ship at range 0-2. If you do, it may perform a red %EVADE% action."""
        "Jan Dodonna":
           display_name: """Jan Dodonna"""
           text: """Friendly ships at range 0-3 can spend your focus and evade tokens."""
        "Raymus Antilles":
           display_name: """Raymus Antilles"""
           text: """After you are destroyed, each friendly ship at range 0-1 gains 1 focus token. After you are destroyed, you are not removed until the end of the End Phase."""
        "Stalwart Captain":
           display_name: """Stalwart Captain"""
           text: """After you are destroyed, you are not removed until the end of the End Phase."""
        "Agent of the Empire":
           display_name: """Agent of the Empire"""
           text: """You are a <strong>wing leader</strong>. Your wingmates must be 2, 3, 4, or 5 TIE/ln fighters. %LINEBREAK% While you defend, up to 2 of your wingmates in the attack arc may suffer 1 %HIT% or %CRIT% damage to cancel a matching result."""
        "First Order Elite":
           display_name: """First Order Elite"""
           text: """You are a <strong>wing leader</strong>. Your wingmates must be 2 or 3 TIE/fo fighters or TIE/sf fighters. %LINEBREAK% While you defend, up to 2 of your wingmates in the attack arc may suffer 1 %HIT% or %CRIT% damage to cancel a matching result."""
        "Veteran Wing Leader":
           display_name: """Veteran Wing Leader"""
           text: """You are a <strong>wing leader</strong>. Your wingmates must be 2, 3, 4, or 5 other ships of your ship type. %LINEBREAK% While you defend, up to 2 of your wingmates in the attack arc may suffer 1 %HIT% or %CRIT% damage to cancel a matching result."""
        "Dreadnought Hunter":
           display_name: """Dreadnought Hunter"""
           text: """While you perform an attack against a huge ship, if the attack deals a faceup damage card to the defender and the defender is in your %BULLSEYEARC%, you may apply the <strong>Precision Shot</strong> effect even if you are not in the specified arc."""
        "Ion Cannon Battery":
           display_name: """Ion Cannon Battery"""
           text: """<strong>Online: </strong> Setup: Equip this side faceup.%LINEBREAK% Bonus Attack: Spend 1 %ENERGY%. If this attack hits, the defender suffers 1 %CRIT% damage, and all %HIT%/%CRIT% results inflict ion tokens instead of damage. %LINEBREAK%<strong>Offline: </strong> %LINEBREAK% After you engage, you may spend 2 %ENERGY% to flip this card."""
        "Targeting Battery":
           display_name: """Targeting Battery"""
           text: """<strong>Online: </strong> Setup: Equip this side faceup.%LINEBREAK% Bonus Attack: Spend 1 %ENERGY%. After you perform this attack, you may acquire a lock on the defender. %LINEBREAK%<strong>Offline: </strong> %LINEBREAK% After you engage, you may spend 2 %ENERGY% to flip this card."""
        "Ordnance Tubes":
           display_name: """Ordnance Tubes"""
           text: """<strong>Online: </strong> Setup: Equip this side faceup. %LINEBREAK% You can perform %TORPEDO% and %MISSILE% attacks only as bonus attacks. You <strong>must</strong> treat the %FRONTARC% requirement of your equipped %TORPEDO% and %MISSILE% upgrades as %FULLFRONTARC%. %LINEBREAK% Bonus Attack: Perform a %TORPEDO% attack. %LINEBREAK% Bonus Attack: Perform a %MISSILE% attack. %LINEBREAK%<strong>Offline: </strong> %LINEBREAK% You must treat the %FRONTARC% requirement of your equipped %TORPEDO% and %MISSILE% upgrades as %BULLSEYEARC%. %LINEBREAK% Action: Spend 2 %ENERGY% to flip this card."""
        "Point-Defense Battery":
           display_name: """Point-Defense Battery"""
           text: """<strong>Online: </strong> Setup: Equip this side faceup. %LINEBREAK% Bonus Attack: Spend 1 %ENERGY%. %LINEBREAK% Bonus Attack: Spend 1 %ENERGY%. %LINEBREAK% Bonus Attack: Spend 1 %ENERGY%. %LINEBREAK% Bonus Attack: Spend 1 %ENERGY%. %LINEBREAK%<strong>Offline: </strong> %LINEBREAK% After you engage, you may spend 2 %ENERGY% to flip this card."""
        "Turbolaser Battery":
           display_name: """Turbolaser Battery"""
           text: """<strong>Online: </strong> Setup: Equip this side faceup.%LINEBREAK% Bonus Attack (%LOCK%): Spend 3 %ENERGY%. If this attack hits, add 3 %HIT% results. %LINEBREAK% <strong>Offline: </strong> %LINEBREAK% After you engage, you may spend 2 %ENERGY% to flip this card."""
        "Bombardment Specialists":
           display_name: """Bombardment Specialists"""
           text: """While you perform an attack, you may spend 1 calculate token to increase or decrease the range requirement by 1, to a limit of 0-5."""
        "Comms Team":
           display_name: """Comms Team"""
           text: """After you perform a %COORDINATE% action, you may spend up to 2 %ENERGY% to coordinate that many additional ships at range 0-1 of the ship you coordinated."""
        "IG-RM Droids":
           display_name: """IG-RM Droids"""
           text: """While you perform an attack, if you are calculating, you may change 1 %HIT% result to a %CRIT% result."""
        "Gunnery Specialists":
           display_name: """Gunnery Specialists"""
           text: """While you perform a primary or %HARDPOINT% attack, you may spend 1 or more %ENERGY% to reroll that many attack dice."""
        "Damage Control Team":
           display_name: """Damage Control Team"""
           text: """Before you engage, you may spend 1 or more %ENERGY% to flip that many of your <strong>Offline</strong> upgrade cards.%LINEBREAK% Action: Spend 1 or more %ENERGY% to repair that many of your faceup <strong>Ship</strong> damage cards."""
        "Ordnance Team":
           display_name: """Ordnance Team"""
           text: """While you perform a %RELOAD% action, you may spend up to 3 %ENERGY% to reload that many additional %CHARGE% on your equipped %MISSILE%/%TORPEDO% upgrades. %LINEBREAK% After you perform a %RELOAD% action, you may spend 1 %ENERGY% to remove 1 disarm token."""
        "Sensor Experts":
           display_name: """Sensor Experts"""
           text: """You can maintain up to 3 locks on different objects. %LINEBREAK% After you perform a %LOCK% action, you may spend up to 2 %ENERGY% to acquire a lock on that many other objects at range 0-1 of the object you locked, ignoring range restrictions."""
        "Quick-Release Locks":
           display_name: """Quick-Release Locks"""
           text: """During the System Phase, you may spend 1 %CHARGE% to place 1 cargo crate drift in your %REARARC% at range 0. It cannot overlap a ship this way.%LINEBREAK% This card's %CHARGE% cannot be recovered."""
        "Saboteur's Map":
           display_name: """Saboteur's Map"""
           text: """At the end of Setup, you may spend up to 1 %CHARGE% from each of your equipped <strong>Mine</strong> upgrades to place the corresponding device in the play area beyond range 2 of any enemy ship, strategic marker, or other device."""
        "Scanner Baffler":
           display_name: """Scanner Baffler"""
           text: """At the end of Setup, you may choose any number of other friendly, non-huge ships in your deployment area at range 0-1. If you do, place those ships anywhere in the same deployment area."""
        "Adaptive Shields":
           display_name: """Adaptive Shields"""
           text: """While another friendly ship at range 0-1 defends, if it is a smaller size than you, you may spend 1 shield or 2 %ENERGY% to cancel 1 %HIT% or %CRIT% result."""
        "Boosted Scanners":
           display_name: """Boosted Scanners"""
           text: """While you lock, coordinate, or jam, you may spend up to 3 %ENERGY% to increase the range at which you can choose an object by 1 per %ENERGY% spent this way, to a maximum of range 5."""
        "Optimized Power Core":
           display_name: """Optimized Power Core"""
           text: """After you execute a blue maneuver, recover 1 %ENERGY%."""
        "Tibanna Reserves":
           display_name: """Tibanna Reserves"""
           text: """Action: Spend 1 %CHARGE% to recover 2 %ENERGY%."""
        "Toryn Farr":
           display_name: """Toryn Farr"""
           text: """After you coordinate a friendly ship, it may acquire a lock on a ship you are locking, ignoring range restrictions."""
        "Dodonna's Pride":
           display_name: """Dodonna's Pride"""
           text: """ """
        "Jaina's Light":
           display_name: """Jaina's Light"""
           text: """While a friendly ship at range 0-2 defends, if the attack is obstructed by an obstacle, you may spend 1 %ENERGY%. If you do, the defender rolls 1 additional defense die."""
        "Liberator":
           display_name: """Liberator"""
           text: """You can dock up to 2 small ships. %LINEBREAK% After a ship deploys from you, it may perform a %FOCUS% or %BARRELROLL% action."""
        "Tantive IV":
           display_name: """Tantive IV"""
           text: """While you defend, if the attacker is in your %REARARC%, you may roll 1 additional defense die."""
        "Thunderstrike":
           display_name: """Thunderstrike"""
           text: """While you perform a bonus attack, if you have not attacked the defender this round, you may reroll 1 attack die."""
        "Bright Hope":
           display_name: """Bright Hope"""
           text: """You can reinforce only your %FULLFRONTARC%. %LINEBREAK% While you defend, if you are reinforced and the attacker is in your %FULLFRONTARC%, you may roll 1 additional defense die."""
        "Luminous":
           display_name: """Luminous"""
           text: """Setup: You are placed in reserve. %LINEBREAK% At the end of setup, you are placed in the play area at range 0-2 of a friendly ship."""
        "Quantum Storm":
           display_name: """Quantum Storm"""
           text: """After you fully execute a white maneuver, recover 1 %ENERGY%."""
        "Assailer":
           display_name: """Assailer"""
           text: """While you defend, if the attack range is 1, you may roll 1 additional defense die."""
        "Corvus":
           display_name: """Corvus"""
           text: """You can dock up to 2 small ships. %LINEBREAK% After you perform a %CALCULATE% action, gain 1 calculate token."""
        "Impetuous":
           display_name: """Impetuous"""
           text: """After you perform an attack, if the defender was destroyed, you may perform a %FOCUS% or %LOCK% action."""
        "Instigator":
           display_name: """Instigator"""
           text: """While you perform an attack, if the defender has an orange or red token, you may reroll up to 2 attack dice."""
        "Blood Crow":
           display_name: """Blood Crow"""
           text: """While you perform an attack at attack range 1-2, you may add 1 %FOCUS% result."""
        "Requiem":
           display_name: """Requiem"""
           text: """After a ship deploys from you, it may acquire a lock on one ship you are locking, ignoring range restrictions."""
        "Suppressor":
           display_name: """Suppressor"""
           text: """After you coordinate a friendly ship, you may spend 1 %ENERGY% to jam an enemy ship at range 0-2 of that ship, ignoring range restrictions."""
        "Vector":
           display_name: """Vector"""
           text: """After a ship deploys from you, it may perform a %EVADE% or %BOOST% action."""
        "Broken Horn":
           display_name: """Broken Horn"""
           text: """If you are damaged, reduce the difficulty of your speed 3-5 maneuvers."""
        "Merchant One":
           display_name: """Merchant One"""
           text: """Bonus Attack: Perform a %TURRET% attack."""
        "Insatiable Worrt":
           display_name: """Insatiable Worrt"""
           text: """During the End Phase, you may recover 1 additional shield or 1 additional %ENERGY%."""
        "Corsair Refit":
           display_name: """Corsair Refit"""
           text: """Bonus Attack: Spend 1 %ENERGY% to perform a %CANNON%, %TURRET%, or %MISSILE% attack."""
        "Enhanced Propulsion":
           display_name: """Enhanced Propulsion"""
           text: """<strong>Setup:</strong> Equip this side faceup.%LINEBREAK% At the start of the End Phase, you may spend 2 %ENERGY% to execute a white [2 %STRAIGHT%], [1 %BANKLEFT%], or [1 %BANKRIGHT%] maneuver. %LINEBREAK% """
        "Drill Beak":
           display_name: """Drill Beak"""
           text: """<strong>Setup:</strong> Equip this side faceup.%LINEBREAK% You can preform this attack at range 0.
           %LINEBREAK% <strong>Bonus Attack:</strong> Spend 1 %ENERGY%. If the attack range is 0, change all %HIT% results to %CRIT% results."""
        "Tractor Tentacles":
           display_name: """Tractor Tentacles"""
           text: """<strong>Setup:</strong> Equip this side faceup.
           %LINEBREAK% <strong>Bonus Attack</strong> %LINEBREAK% <strong>Bonus Attack:</strong> Spend 1 %ENERGY%. %LINEBREAK% <strong>Bonus Attack:</strong> Spend 1 %ENERGY%. %LINEBREAK% <strong>Bonus Attack:</strong> Spend 1 %ENERGY%."""
        "Tracking Torpedoes":
           display_name: """Tracking Torpedoes"""
           text: """During the System Phase, you may spend up to 3 %CHARGE% to launch that many tracking torpedoes using the [%BANKLEFT% 3], [%STRAIGHT% 4], and [%BANKRIGHT% 3] templates. Each device must use a seperate tempalte. Then each device may acquire a lock on an object you have locked, ignoring range restrictions.%LINEBREAK% This card's %CHARGE% cannot be recovered."""
        "Proton Cannon Battery":
           display_name: """Proton Cannon Battery"""
           text: """<strong>Setup:</strong> Equip this side faceup.
           %LINEBREAK% <strong>Bonus Attack:</strong> Change 1 %HIT% result to a %CRIT% result. %LINEBREAK% <strong>Bonus Attack:</strong> Spend 1 %ENERGY%. Change 1 %HIT% result to a %CRIT% result."""
        "Tractor Technicians":
           display_name: """Tractor Technicians"""
           text: """During the End Phase, each other ship at range 0-1 cannot remove its tractor tokens. %LINEBREAK% Before a tractored enemy ship at range 0-1 reveals its dial, you may spend 1 %ENERGY%. If you do, while that ship executes its maneuver this activation, it reduces the speed of that maneuver by 1, to a minimum of 1."""
        "Asajj Ventress (Command)":
           display_name: """Asajj Ventress"""
           text: """During the System Phase, you may spend 1 %FORCE%. IF you do, each enemy ship in your %FRONTARC% at range 0-1 gains 1 strain token unless it chooses to gain 1 jam token."""
        "Hondo Ohnaka (Command)":
           display_name: """Hondo Ohnaka"""
           text: """During the System Phase, you may spend 1 %CHARGE% and choose 1 friendly shiop at range 0-1. Move 1 Victory Token or Objective Token from its ship card to your ship card, or from your ship card to its ship card."""
        "Zealous Captain":
           display_name: """Zealous Captain"""
           text: """During the Engagement Phase, at initiative 4, you may spend 1 %ENERGY% to perform a bonus %HARDPOINT% attack."""
        "General Grievous (Command)":
           display_name: """General Grievous"""
           text: """During the Engagement Phase, at initiative 4, you may spend 1 %ENERGY% to perform a bonus %HARDPOINT% attack. %LINEBREAK% You can perform attacks against friendly ships. %LINEBREAK% After you perform an attack, if the defender was destroyed, each friendly ship at range 0-2 of it may perform a %CALCULATE% action."""
        "Mar Tuuk":
           display_name: """Mar Tuuk"""
           text: """<strong>Setup:</strong> After placing forces, choose 1 friendly wing of ships with %CALCULATE% on their action bars and place that wing in reserve. %LINEBREAK% During the End Phase, you may place that wing within your deployment area or beyond range 2 of any enemy shp. Then you may choose 1 enemy ship at range 0-1 of you; each ship in that wing acquires a lock on it."""
        "Riff Tamson":
           display_name: """Riff Tamson"""
           text: """During the Engagement Phase, at initiative 5, you may spend 1 %ENERGY% to perform a bonus %HARDPOINT% attack. %LINEBREAK% After you perform an attack, if the defender was dealt 1 or more faceup damage cards, it gains 2 strain tokens."""
        "Corsair Crew":
           display_name: """Corsair Crew"""
           text: """While you perform an attack against a standard ship, you may spend 1 %HIT% result. If you do, the defender gains 1 deplete token."""
        "Grappler":
           display_name: """Grappler"""
           text: """While you perform a <b>Drill Beak</b> attack, at range 1, if the defender is tractored, treat it as being range 0 instead."""
        "Nautolan's Revenge":
           display_name: """Nautolan's Revenge"""
           text: """Before you engage, you may spend up to 2 calculate tokens. If you do, recover that many %ENERGY%."""
        "Droid Crew":
           display_name: """Droid Crew"""
           text: """While you perform a white %FOCUS% action, treat it as red instead. %LINEBREAK% At the start of the End Phase, repair all of your faceup <b>Crew</b> damage cards."""
        "Trident":
           display_name: """Trident"""
           text: """After you overlap a ship or a ship overlaps you, if it is not tractored, you may spend 1 %ENERGY%. If you do, it gains 3 tractor tokens."""
        "Neimoidian Grasp":
           display_name: """Neimoidian Grasp"""
           text: """After you perform an attack, you may perform a red  %EVADE% action. While you defend, if you are evading, you may roll 1 addtional defense die."""

    condition_translations =
        'Suppressive Fire':
           text: '''While you perform an attack against a ship other than <strong>Captain Rex</strong>, roll 1 fewer attack die. %LINEBREAK% After <strong>Captain Rex</strong> defends, remove this card.  %LINEBREAK% At the end of the Combat Phase, if <strong>Captain Rex</strong> did not perform an attack this phase, remove this card. %LINEBREAK% After <strong>Captain Rex</strong> is destroyed, remove this card.'''
        'Hunted':
           text: '''After you are destroyed, you must choose another friendly ship and assign this condition to it, if able.'''
        'Listening Device':
           text: '''During the System Phase, if an enemy ship with the <strong>Informant</strong> upgrade is at range 0-2, flip your dial faceup.'''
        'Rattled':
           text: '''After a bomb or mine at range 0-1 detonates, suffer 1 %CRIT%. Then, remove this card. %LINEBREAK% Action: If there are no bombs or mines at range 0-1, remove this card.'''
        'Optimized Prototype':
           text: '''While you perform a %FRONTARC% primary attack against a ship locked by a friendly ship with the <strong>Director Krennic</strong> upgrade, you may spend 1 %HIT%/%CRIT%/%FOCUS% result. If you do, choose one: the defender loses 1 shield or the defender flips 1 of its facedown damage cards.'''
        '''I'll Show You the Dark Side''':
           text: ''' When this card is assigned, if there is no faceup damage card on it, the player who assigned it searches the damage deck for 1 Pilot damage card and places it faceup on this card. Then shuffle the damage deck. When you would suffer 1 %CRIT% damage, you are instead dealt the faceup damage card on this card. Then, remove this card. '''
        'Proton Bomb':
           text: '''<strong>Types:</strong> Device, Bomb %LINEBREAK% At the end of the Activation Phase, this device detonates. When this device detonates, each ship and remote at range 0-1 suffers 1 %CRIT% damage.%LINEBREAK%<i>Errata (Official Rulings Thread 03/2019): Added: "and remote"</i>'''
        'Seismic Charge':
           text: '''<strong>Types:</strong> Device, Bomb %LINEBREAK% At the end of the Activation Phase this device detonates. When this device detonates, choose 1 obstacle at range 0-1. Each ship and remote at range 0-1 of the obstacle suffers 1 %HIT% damage. Then remove that obstacle.%LINEBREAK%<i>Errata (Official Rulings Thread 03/2019): Added: "and remote"</i> '''
        'Bomblet':
           text: '''<strong>Types:</strong> Device, Bomb %LINEBREAK% At the end of the Activation Phase this device detonates. When this device detonates, each ship and remote at range 0-1 rolls 2 attack dice. Each ship and remote suffers 1 %HIT% damage for each %HIT%/%CRIT% result.%LINEBREAK%<i>Errata (Official Rulings Thread 03/2019): Added: "and remote"</i>'''
        'Loose Cargo':
           text: '''<strong>Types:</strong> Obstacle, Placed %LINEBREAK% '''
        'Spare Parts':
           text: '''<strong>Types:</strong> Obstacle, Placed %LINEBREAK% When this object is dropped, fit the tab between the ship's rear guides.'''
        'Conner Net':
           text: '''<strong>Types:</strong> Device, Mine %LINEBREAK% After a ship overlaps or moves through this device, it detonates. When this device detonates, the ship suffers 1 %HIT% damage and gains 3 ion tokens.'''
        'Proximity Mine':
           text: '''<strong>Types:</strong> Device, Mine %LINEBREAK% After a ship overlaps or moves through this device, it detonates. When this device detonates, that ship rolls 2 attack dice. That ship then suffers 1 %HIT% plus 1 %HIT%/%CRIT% damage for each matching result.%LINEBREAK%<i>Errata (since rules reference 1.0.2): Added: "1 %HIT% plus"</i>'''
        'DRK-1 Probe Droid':
           text: '''INIT: 0 <br>AGILITY: 3 <br>HULL: 1 %LINEBREAK% <strong>Types:</strong> Device, Remote %LINEBREAK%  <strong>System Phase:</strong> The DRK-1 probe droid's controlling player may choose a [2 %BANKLEFT%], [2 %STRAIGHT%] or [2 %BANKRIGHT%] template and any set of the DRK-1's guides. The player then relocates the remote, placing the DRK-1 at the other end of the template. It can be placed overlapping an object this way. %LINEBREAK%If the DRK-1 overlaps a ship, use the position marker to denote the ship's position, then place the ship on top of the remote. %LINEBREAK%<strong>Activation, Engagement, and End Phase:</strong> No effect. %LINEBREAK%<strong>Other Rules:</strong> While a ship locks an object or jams an enemy ship, it may measure range from a friendly DRK-1 probe droid. After an enemy ship executes a maneuver that causes it to overlap a DRK-1 probe droid, the ship's controller rolls 1 attack die. On a %FOCUS% result, the DRK-1 probe droid suffers 1 %HIT% damage.'''
        'Buzz Droid Swarm':
           text: '''INIT: 0 <br>AGILITY: 1 <br>HULL: 1 %LINEBREAK% <strong>Types:</strong> Device, Remote %LINEBREAK% <strong>System, Activation, and End Phase:</strong> No effect. %LINEBREAK%<strong>Engagement Phase:</strong> When you engage, each enemy ship at range 0 of the buzz droid swarm suffers 1 %CRIT% damage. %LINEBREAK%<strong>Other Rules:</strong> After an enemy ship overlaps or moves through a buzz droid swarm, the swarm's controlling player relocates it by aligning the tab to that ship's front or rear guides (this ship is at range 0 of the swarm). The swarm cannot be aligned to a set of the ship's guides if doing so would cause it to overlap an object. If the swarm cannot be placed at a chosen set of guides, its controlling player must align it to the other set of the ship's guides. If it cannot be aligned to the other set, the swarm and the enemy ship that overlapped or moved through it each suffer 1 %HIT% damage. %LINEBREAK%<i>Errata (since rules reference 1.4): Agility adjusted for balance.</i>'''
        '''It's the Resistance''':
           text: '''<strong>Setup:</strong> Start in reserve. %LINEBREAK% When you deploy, you are placed within range 1 of any table edge and beyond range 3 of any enemy ship. %LINEBREAK% At the start of the round, if all of the friendly <strong>GA-97</strong>'s %CHARGE% are active, you <strong>must</strong> deploy. Then remove this card. After the friendly <strong>GA-97</strong> is destroyed, you <strong>must</strong> deploy. Then gain 1 disarm token and remove this card.'''
        'Electro-Proton Bomb':
           text: '''<strong>Types:</strong> Device, Bomb %LINEBREAK%  At the end of the Activation Phase this device detonates. When this device detonates, each ship and remote at range 0-2 rolls 4 attack dice. Each ship loses 1 shield for each blank result, gains 1 ion token for each %FOCUS%/%HIT% result, and gains 1 disarm token for each %CRIT% result. Each remote at range 0-1 loses 1 shield for each blank result and suffers 1 damage for each %FOCUS%/%HIT% result.'''
        'Decoyed':
           text: '''While you defend, each friendly <strong>Naboo Handmaiden</strong> in the attack arc may spend 1 evade token to change one of your results to an %EVADE% result. %LINEBREAK% If you are a Naboo Royal N-1 Starfighter, each friendly <strong>Naboo Handmaiden</strong> in the attack arc may spend 1 evade token to add 1 %EVADE% result instead.'''
        'Compromising Intel':
           text: '''During the System Phase, if the enemy <strong>Vi Moradi</strong> is at range 0-3, flip your dial faceup. %LINEBREAK% While you defend or perform an attack against the enemy <strong>Vi Moradi</strong>, you cannot spend focus tokens.'''
        'Cluster Mine':
           text: '''<strong>Types:</strong> Device, Mine %LINEBREAK%   A Cluster Mine Set consists of 3 individual Cluster Mine devices. %LINEBREAK% When a Cluster Mines set is placed, the center Cluster Mine is placed as normal, then two additional Cluster Mines are placed in the recesses as shown. %LINEBREAK% After a ship overlaps or moves through any individual Cluster Mine, it detonates. Other Cluster Mines in the set that were not overlapped or moved through do not detonate. %LINEBREAK% When each of these devices detonates, that ship rolls 2 attack dice. That ship then suffers 1 %HIT%/%CRIT% damage for each matching result.'''
        'Ion Bomb':
           text: '''<strong>Types:</strong> Device, Bomb %LINEBREAK% At the end of the Activation Phase, this device detonates. When this device detonates, each ship at range 0-1 gains 3 ion tokens, and each remote at range 0-1 suffers 1 %HIT% damage.'''
        'Concussion Bomb':
           text: '''<strong>Types:</strong> Device, Bomb %LINEBREAK% At the end of the Activation Phase, this device detonates. When this device detonates, each ship and remote at range 0-1 is dealt 1 facedown damage card. Then, each ship at range 0-1 must expose 1 damage card unless it chooses to gain 1 strain token.'''
        'Thermal Detonator':
           text: '''<strong>Types:</strong> Device, Bomb %LINEBREAK% At the end of the Activation Phase, this device detonates. When this device detonates, each ship and remote at range 0-1 rolls 1 attack die. Each ship gains 1 strain token for each %FOCUS% result, and each ship and remote suffers 1 %HIT%/%CRIT% damage for each matching result.'''
        'Sensor Buoy':
           text: '''INIT: 0 <br>AGILITY: 3 <br>HULL: 2 %LINEBREAK% <strong>Types:</strong> Device, Remote %LINEBREAK% Sensor buoys are remotes that come in pairs (one red, and one blue, each with its own remote card), and are placed by the <strong>Sensor Buoy Suite</strong> upgrade card. Beyond being remotes and interacting with that card, they have no additional rules.'''
        'Electro-Chaff Cloud':
           text: '''An electro-chaff cloud is a device and an obstacle. %LINEBREAK% During the End Phase, remove each electro-chaff cloud with no fuse markers, then remove one fuse marker from each electro-chaff cloud. An electro-chaff cloud can never have more than one fuse token.'''
        'Tracking Torpedoes':
           text: '''INIT: 0 <br>AGILITY: 3 <br>HULL: 3 %LINEBREAK% <strong>Types:</strong> Device, Remote %LINEBREAK%<strong>System Phase:</strong> At this remote's initiative, its controlling player relocates this remote forward using the [3 %BANKLEFT%], [3 %BANKRIGHT%], or [4 %STRAIGHT%] template. %LINEBREAK% <strong>Activation Phase:</strong> No effect. %LINEBREAK% <strong>Engagement Phase:</strong> At this remote's initiative, if an object on which it has a lock is in its %FRONTARC% at range 0-1, this remote detonates. End Phase: During the End Phase, if this remote does not have a lock on any object, this remote must acquire a lock on an object in its %FRONTARC% at range 1-3, if able. %LINEBREAK% <strong>Other Rules:</strong> After this remote is destroyed, roll 1 attack die. On a %HIT% or %CRIT% result, this remote detonates. %LINEBREAK% When this remote detonates, each ship, remote, and structure at range 0 or in its %FRONTARC% at range 1 rolls 4 attack dice and suffers 1 damage for each matching %HIT% or %CRIT% result.'''
        'Fearful Prey':
           text: '''After you defend against an enemy <strong>Fearsome Predator</strong>, if you did not spend at least 1 green token during the attack, gain 1 strain token.'''
        'You Should Thank Me':
           text: '''This condition is assigned facedown. Reveal it after you defend. %LINEBREAK% After you defend, <strong>Zam Wesell</strong> recovers 1 %CHARGE%. Then, you may acquire a lock on the attacker. %LINEBREAK% At the end of the Engagement Phase, if this card is facedown and you are in an enemy ship's firing arc, you may reveal this card and spend 2 %CHARGE% from <strong>Zam Wesell</strong>. If you do, you may perform a bonus attack. %LINEBREAK% At the start of the System Phase, remove this condition.'''
        '''You'd Better Mean Business''':
           text: '''This condition is assigned facedown. Reveal it after you defend. %LINEBREAK% After you defend, you may spend 2 %CHARGE% from <strong>Zam Wesell</strong>. If you do, perform a bonus attack against the attacker. %LINEBREAK% At the end of the Engagement Phase, if this card is facedown and you are in an enemy ship's firing arc, you may reveal this card. If you do, <strong>Zam Wesell</strong> recovers 2 %CHARGE%. %LINEBREAK% At the start of the System Phase, remove this condition.'''
        '''Merciless Pursuit''':
           text: '''After you perform an attack, if the defender is equipped with <b>The Child</b>, you may acquire a lock on the defender.'''
        '''Marked for Elimination''':
           text: '''While you defend, if the attacker is equipped with <b>Tracking Fob</b> and has a lock on you, you cannot spend green tokens.'''
        '''False Friend''':
           text: '''During the System Phase, if an enemy ship with the <b>Tal Merrik</b> upgrade is at range 0-2 or an enemy remote is at range 0-2, flip your dial faceup. %LINEBREAK% <strong>Action:</strong> Gain 1 deplete token and stress token to discard this condition.'''
        '''Trials of the Darksaber''':
           text: '''While you perform an attack at attack range 0-2, you may spend 1 %CRIT% result. If you do, if the defending ship's player has scored more %POINT% than you, they lose 1 scored %POINT%. Place thatt %POINT% on this card. %LINEBREAK% After you defend, if you are destroyed by an enemy ship at attack range 0-2, assign the <b>Trials of the Darksaber</b> condition to the attacker (all %POINT% remain on this card). %LINEBREAK%. At the end of the game, this ship scores all %POINT% on this card.'''
        '''Blazer Bomb''':
           text: '''<strong>Types:</strong> Device, Bomb %LINEBREAK% At the end of the Activation Phase, this device detonates. %LINEBREAK% When this device detonates, each ship and remote at range 0-1 rolls 1 attack die. Each ship or remote suffers 1 %HIT% damage for each %HIT%/%CRIT% result. %LINEBREAK% After this devices detonates, place a Blaze by aligning the Blaze's guides to the device's tab. %LINEBREAK% A Blaze is an obstacle. After this obstacle is placed, place a fues marker on it. %LINEBREAK% During the End Phase, remove each Blaze with no fuse markers, then remove 1 fuse marker from each Blaze.'''
        '''Clan Wren Commandos''':
           text: '''INIT: 2 <br> %FRONTARC%: 2 %RANGEBONUS%, RANGE: 1-2 <br>%AGILITY%: 2, %HULL%: 2, %CHARGE%: 2 %LINEBREAK% <strong>Types:</strong> Device, Remote %LINEBREAK% After an enemy ship overlaps you, it gains 1 strain token. %LINEBREAK% <strong>Activation Phase:</strong> At the start of this phase, you may relocate forward using a [1 %TURNLEFT%], [2 %STRAIGHT%], or [1 %TURNRIGHT%] template.%LINEBREAK% <strong>Engagement Phase:</strong> You cannot attack if there are enemy ships at range 0. To perform an attack, you must spend 1 %CHARGE%. While you perform an attack, you may change 1 %FOCUS% result to a %HIT% result.'''
        '''Death Watch Commandos''':
           text: '''INIT: 2 <br> %FRONTARC%: 2 %RANGEBONUS%, RANGE: 1-2 <br>%AGILITY%: 2, %HULL%: 2, %CHARGE%: 2 %LINEBREAK% <strong>Types:</strong> Device, Remote %LINEBREAK% After an enemy ship overlaps you, it gains 1 strain token.%LINEBREAK% <strong>Activation Phase:</strong> At the start of this phase, you may relocate forward using a [1 %TURNLEFT%], [2 %STRAIGHT%], or [1 %TURNRIGHT%] template.%LINEBREAK% <strong>Engagement Phase:</strong> You cannot attack if there are enemy ships at range 0. To perform an attack, you must spend 1 %CHARGE%. While you perform an attack, you may change 1 %FOCUS% result to a %HIT% result.'''
        '''Nite Owl Commandos''':
           text: '''INIT: 2 <br> %FRONTARC%: 2 %RANGEBONUS%, RANGE: 1-2 <br>%AGILITY%: 2, %HULL%: 2, %CHARGE%: 2 %LINEBREAK% <strong>Types:</strong> Device, Remote %LINEBREAK% After an enemy ship overlaps you, it gains 1 strain token.%LINEBREAK% <strong>Activation Phase:</strong> At the start of this phase, you may relocate forward using a [1 %TURNLEFT%], [2 %STRAIGHT%], or [1 %TURNRIGHT%] template.%LINEBREAK% <strong>Engagement Phase:</strong> You cannot attack if there are enemy ships at range 0. To perform an attack, you must spend 1 %CHARGE%. While you perform an attack, you may change 1 %FOCUS% result to a %HIT% result.'''
        '''Imperial Super Commandos''':
           text: '''INIT: 2 <br> %FRONTARC%: 2 %RANGEBONUS%, RANGE: 1-2 <br>%AGILITY%: 2, %HULL%: 2, %CHARGE%: 2 %LINEBREAK% <strong>Types:</strong> Device, Remote %LINEBREAK% After an enemy ship overlaps you, it gains 1 strain token.%LINEBREAK% <strong>Activation Phase:</strong> At the start of this phase, you may relocate forward using a [1 %TURNLEFT%], [2 %STRAIGHT%], or [1 %TURNRIGHT%] template.%LINEBREAK% <strong>Engagement Phase:</strong> You cannot attack if there are enemy ships at range 0. To perform an attack, you must spend 1 %CHARGE%. While you perform an attack, you may change 1 %FOCUS% result to a %HIT% result.'''
        '''Mandalorian Super Commandos''':
           text: '''INIT: 2 <br> %FRONTARC%: 2 %RANGEBONUS%, RANGE: 1-2 <br>%AGILITY%: 2, %HULL%: 2, %CHARGE%: 2 %LINEBREAK% <strong>Types:</strong> Device, Remote %LINEBREAK% After an enemy ship overlaps you, it gains 1 strain token.%LINEBREAK% <strong>Activation Phase:</strong> At the start of this phase, you may relocate forward using a [1 %TURNLEFT%], [2 %STRAIGHT%], or [1 %TURNRIGHT%] template.%LINEBREAK% <strong>Engagement Phase:</strong> You cannot attack if there are enemy ships at range 0. To perform an attack, you must spend 1 %CHARGE%. While you perform an attack, you may change 1 %FOCUS% result to a %HIT% result.'''
        '''Guarded''':
           text: '''While you defend, if you are not in the attacker's %BULLSEYEARC%, roll 1 additional defense die for each friendly calculating or evading <b>MagnaGuard Protector</b> in the attack arc.'''
        '''Sickening Maneuver''':
           text: '''You can execute red maneuvers even while stressed. %LINEBREAK% After you reveal a bank [%BANKLEFT% or %BANKRIGHT%] or turn [%TURNLEFT% or %TURNRIGHT%] maneuver, you <b>must</b> gain 1 strain and execute the maneuver as a slideslip.%LINEBREAK% After you reveal a straight [%STRAIGHT%] maneuver, you must execute that maneuver as a red koiogran turn [%KTURN%]. %LINEBREAK% After you execute a maneuver, remove this condition.'''
        '''Primed For Speed''':
           text: '''Add a white %SLAM% action to your action bar. %LINEBREAK% After you perform a %SLAM%, you must suffer 1 %HIT% damage to remove 1 disarm token.'''
        '''Broken Trust''':
           text: '''Treat friendly ships as allied.%LINEBREAK% Non-enemy ships treat you as allied.%LINEBREAK% While performing an attack, before declaring the defender, each allied ship in the attack arc that is not stressed gains 1 stress token. After you defend or perform an attack, if the defender was dealt at least 1 faceup damage card, or was destroyed, remove this condition.'''

    chassis_translations =
        "Vectored Thrusters":
           display_name: "Vectored Thrusters"
           text: """After you perform an action, you may perform a red %BOOST% action."""
        "Advanced Targeting Computer":
           display_name: "Advanced Targeting Computer"
           text: """While you perform a primary attack against a defender you have locked, roll 1 additional attack die and change 1 %HIT% result to a %CRIT% result."""
        "Autothrusters":
           display_name: "Autothrusters"
           text: """After you perform an action, you may perform a red %BARRELROLL% or red %BOOST% action."""
        "Nimble Bomber":
           display_name: "Nimble Bomber"
           text: """If you would drop a device using a %STRAIGHT% template, you may use a %BANKLEFT% or %BANKRIGHT% template of the same speed instead."""
        "Full Throttle":
           display_name: "Full Throttle"
           text: """After you fully execute a speed 3-5 maneuver, you may perform an %EVADE% action."""
        "Experimental Scanners":
           display_name: "Experimental Scanners"
           text: """You can acquire locks beyond range 3. You cannot acquire locks at range 1."""
        "Stygium Array":
           display_name: "Stygium Array"
           text: """After you decloak, you may perform an %EVADE% action. At the start of the End Phase, you may spend 1 evade token to gain 1 cloak token."""
        "Sensor Blindspot":
           display_name: "Sensor Blindspot"
           text: """While you perform a primary attack at attack range 0-1, do not apply the range 0-1 bonus and roll 1 fewer attack die."""
        "Microthrusters":
           display_name: "Microthrusters"
           text: """While you perform a barrel roll, you <b>must</b> use the %BANKLEFT% or %BANKRIGHT% template instead of the %STRAIGHT% template."""
        "Weapon Hardpoint":
           display_name: "Weapon Hardpoint"
           text: """You can equip 1 %CANNON%, %TORPEDO%, or %MISSILE% upgrade."""
        "Advanced Droid Brain":
           display_name: "Advanced Droid Brain"
           text: """After you perform a %CALCULATE% action, gain 1 calculate token."""
        "Tail Gun":
           display_name: "Tail Gun"
           text: """While you have a docked ship, you have a primary %REARARC% weapon with an attack value equal to your docked ship's primary %FRONTARC% attack value."""
        "Locked and Loaded":
           display_name: "Locked and Loaded"
           text: """While you are docked, after your carrier ship performs a primary %FRONTARC% or %TURRET% attack, it may perform a bonus primary %REARARC% attack."""
        "Concordia Faceoff":
           display_name: "Concordia Faceoff"
           text: """While you defend, if the attack range is 1 and you are in the attacker's %FRONTARC%, change 1 result to an %EVADE% result."""
        "Spacetug Tractor Array":
           display_name: "Spacetug Tractor Array"
           text: """ <strong>Action:</strong> Choose a ship in your %FRONTARC% at range 1. That ship gains 1 tractor token, or 2 tractor tokens if it is in your %BULLSEYEARC% at range 1."""
        "Hope":
           display_name: "Hope"
           text: """After another friendly ship at range 0-3 is destroyed, you may perform a %FOCUS% or %BOOST% action."""
        "Solo":
           display_name: "Solo"
           text: """While you defend or perform an attack, if there are no other friendly ships at range 0-1, you may spend 1 %CHARGE% to reroll one of your dice."""
        "Sensitive Controls":
           display_name: "Sensitive Controls"
           text: """During the System Phase, you may perform a red %BARRELROLL% or red %BOOST% action."""
        "Vectored Cannons":
           display_name: "Vectored Cannons"
           text: """During the System Phase, you may perform a red %BOOST% or red %ROTATEARC% action. You can rotate your %SINGLETURRETARC% indicator only to your %FRONTARC% or %REARARC%."""
        "Advanced Fire Control":
           display_name: "Advanced Fire Control"
           text: """After you perform a %CANNON% or %MISSILE% attack, if you have a lock on the defender, you may perform a bonus primary attack against the defender."""
        "Networked Calculations":
           display_name: "Networked Calculations"
           text: """While you defend or perform an attack, you may spend 1 calculate token from a friendly ship at range 0-1 to change 1 %FOCUS% result to an %EVADE% or %HIT% result."""
        "Independent Calculations":
           display_name: "Independent Calculations"
           text: """While you perform a white %CALCULATE% action, you may treat it as red to gain 1 additional calculate token. Other ships cannot spend your calculate tokens using the <strong>Networked Calculations</strong> ship ability."""
        "Adaptive Ailerons":
           display_name: "Adaptive Ailerons"
           text: """Before you reveal your dial, if you are not stressed, you <b>must</b> boost.  %LINEBREAK% <i>Errata (since rules reference 1.4.2): Changed ship ability</i>"""
        "Pursuit Craft":
           display_name: "Pursuit Craft"
           text: """After you deploy, you may acquire a lock on a ship the friendly <strong>Hound's Tooth</strong> has locked."""
        "Dead to Rights":
           display_name: "Dead to Rights"
           text: """While you perform an attack, if the defender is in your %BULLSEYEARC%, defense dice cannot be modified using green tokens."""
        "Comms Shuttle":
           display_name: "Comms Shuttle"
           text: """While you are docked, your carrier ship gains %COORDINATE%. Before your carrier ship activates, it may perform a %COORDINATE% action."""
        "Controlled Ailerons":
           display_name: "Controlled Ailerons"
           text: """Before you reveal your dial, if you are not stressed, you may boost. %LINEBREAK% <i>Errata (since rules reference 1.4.2): Changed ship ability</i>"""
        "Co-Pilot":
           display_name: "Co-Pilot"
           text: """While you are docked, your carrier ship has your pilot ability in addition to its own."""
        "Rigged Energy Cells":
           display_name: "Rigged Energy Cells"
           text: """During the System Phase, if you are not docked, lose 1 %CHARGE%. At the end of the Activation Phase, if you have 0 %CHARGE%, you are destroyed. Before you are removed, each ship at range 0-1 suffers 1 %CRIT% damage."""
        "Refined Gyrostabilizers":
           display_name: "Refined Gyrostabilizers"
           text: """You can rotate your %SINGLETURRETARC% indicator only to your %FRONTARC% or %REARARC%. After you perform an action, you may perform a red %BOOST% or red %ROTATEARC% action."""
        "Heavy Weapon Turret":
           display_name: "Heavy Weapon Turret"
           text: """You can rotate your %SINGLETURRETARC% indicator only to your %FRONTARC% or %REARARC%. You <b>must</b> treat the %FRONTARC% requirement of your equipped %MISSILE% upgrades as %SINGLETURRETARC%."""
        "Linked Battery":
           display_name: "Linked Battery"
           text: """While you perform a %CANNON% attack, roll 1 additional die."""
        "Notched Stabilizers":
           display_name: "Notched Stabilizers"
           text: """While you move, you ignore asteroids."""
        "Fine-Tuned Controls":
           display_name: "Fine-Tuned Controls"
           text: """After you fully execute a maneuver, you may spend 1 %FORCE% to perform a %BOOST% or %BARRELROLL% action."""
        "Pinpoint Tractor Array":
           display_name: "Pinpoint Tractor Array"
           text: """You cannot rotate your %SINGLETURRETARC% to your %REARARC%. After you fully execute a maneuver, you may gain 1 tractor token to perform a %ROTATEARC% action. %LINEBREAK%<i>Errata (since rules reference 1.4): added "fully"</i>"""
        "Plated Hull":
           display_name: "Plated Hull"
           text: """While you defend, if you are not critically damaged, change 1 %CRIT% to a %HIT% result."""
        "Explosion with Wings":
           display_name: "Explosion with Wings"
           text: """You are dealt 1 facedown damage card. After you perform a %SLAM% action, you may expose 1 damage card to remove 1 disarm token."""
        "Fine-Tuned Thrusters":
           display_name: "Fine-Tuned Thrusters"
           text: """After you fully execute a maneuver, if you are not depleted or strained, you may gain 1 deplete or strain token to perform a %LOCK% or %BARRELROLL% action."""
        "Networked Aim":
           display_name: "Networked Aim"
           text: """You cannot spend your locks to reroll attack dice. While you perform an attack, you may reroll a number of attack dice up to the number of friendly locks on the defender."""
        "Fire Convergence":
           display_name: "Fire Convergence"
           text: """While a friendly ship performs a non-%SINGLETURRETARC% attack, if the defender is in your turret arc you may spend 1 charge token, if you do the attacker may reroll up to 2 results."""
        "Rotating Cannons":
           display_name: "Rotating Cannons"
           text: """You can rotate your %SINGLETURRETARC% indicator only to your %FRONTARC% or %REARARC%. You must treat the %FRONTARC% requirement of your equipped %CANNON% upgrades as %SINGLETURRETARC%."""
        "Twin Ion Engines":
           display_name: "Twin Ion Engines"
           text: """Ignore the "TIE" ship restriction on upgrade cards."""
        "Intuitive Controls":
           display_name: "Intuitive Controls"
           text: """During the System Phase, you may perform a purple %BARRELROLL% or purple %BOOST% action."""
        "Intuitive Interface":
           display_name: "Intuitive Interface"
           text: """After you perform an action added to your action bar by a %TALENT%, %ILLICIT%, or %MODIFICATION% upgrade, you may perform a %CALCULATE% action."""
        "Devastating Barrage":
           display_name: "Devastating Barrage"
           text: """While you perform a %TORPEDO% or %MISSILE% attack, if the defender is in your %BULLSEYEARC%, your %CRIT% results cannot be cancelled by %EVADE% results."""
        "Pursuit Thrusters":
           display_name: "Pursuit Thrusters"
           text: """During the System Phase, you may perform a %BOOST% action."""
        "Versatile Frame":
           display_name: "Versatile Frame"
           text: """You can equip 1 %TORPEDO% or %MISSILE% upgrade. While your revealed maneuver is blue, add white %BOOST% to your action bar."""
        "Born for This":
           display_name: "Born for This"
           text: """While another friendly ship at range 0-2 defends, if you are not strained, it may spend your focus and evade tokens as if that ship has them. If it does, you gain 1 strain token."""
        "Modified for Organics":
           display_name: "Modified for Organics"
           text: """This ship is not affected by the <strong>Standardized</strong> restriction. Reduce the difficulty of your speed 2 and 3 bank [%BANKLEFT% or %BANKRIGHT%] maneuvers. Increase the difficulty of your speed 3 turn [%TURNLEFT% or %TURNRIGHT%] maneuvers."""

    # in this file the display_name is often omitted, if it is identical to the name. I am too lazy to add those manually (though running the translation script would automatically do so). As this will pop up with every new card, I add those tags here
    for name, data of pilot_translations
        data['display_name'] = name unless data.display_name?
    for name, data of upgrade_translations
        data['display_name'] = name unless data.display_name?
    for name, data of condition_translations
        data['display_name'] = name unless data.display_name?
    for name, data of chassis_translations
        data['display_name'] = name unless data.display_name?

    exportObj.setupTranslationCardData pilot_translations, upgrade_translations, condition_translations, chassis_translations

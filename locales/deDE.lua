-- deDE localization

local function GWUseThisLocalization()
	-- Create a global variable for the language strings
	GwLocalization = {}
	
	--Fonts
	GwLocalization["FONT_NORMAL"] = "Interface\\AddOns\\GW2_UI\\fonts\\menomonia.ttf"
	GwLocalization["FONT_BOLD"] = "Interface\\AddOns\\GW2_UI\\fonts\\headlines.ttf"
	GwLocalization["FONT_NARROW"] = "Interface\\AddOns\\GW2_UI\\fonts\\menomonia.ttf"
	GwLocalization["FONT_NARROW_BOLD"] = "Interface\\AddOns\\GW2_UI\\fonts\\menomonia.ttf"
	GwLocalization["FONT_LIGHT"] = "Interface\\AddOns\\GW2_UI\\fonts\\menomonia-italic.ttf"
	GwLocalization["FONT_DAMAGE"] = "Interface\\AddOns\\GW2_UI\\fonts\\headlines.ttf"
	
	--Strings
	GwLocalization['WEAPON_SKILLS_HEADER'] = 'Waffenfertigkeiten' -- Do not touch
	GwLocalization["QUEST_REQUIRED_ITEMS"] = "Erforderliches Item:"
	GwLocalization["ACTION_BAR_FADE"] = "Aktionsleisten ausblenden"
	GwLocalization["ACTION_BAR_FADE_DESC"] = "Blendet die zusätzlichen Aktionsleisten außerhalb des Kampfes aus."
	GwLocalization["ACTION_BARS_DESC"] = "Benutze die verbesserten GW2 UI Aktionsleisten."
	GwLocalization["ADV_CAST_BAR"] = "Erweiterte Zauberbar"
	GwLocalization["ADV_CAST_BAR_DESC"] = "Aktiviere oder deaktiviere die erweiterte Zauberbar."
	GwLocalization["AMOUNT_LOAD_ERROR"] = "Einheit konnte nicht geladen werden"
	GwLocalization["AURAS_DESC"] = "Bearbeite welche Buffs und Debuffs angezeigt werden."
	GwLocalization["AURAS_IGNORED"] = "Ignorierte Auren"
	GwLocalization["AURAS_IGNORED_DESC"] = "Eine Liste von Aura-Namen, die nicht angezeigt werden sollen."
	GwLocalization["AURAS_MISSING"] = "Fehlende Buffs"
	GwLocalization["AURAS_MISSING_DESC"] = "Eine Liste von Aura-namen, die nur angezeit werden sollen wenn sie fehlen."
	GwLocalization["AURAS_TOOLTIP"] = "Zeige oder verstecke Auren und bearbeite Raid Indikatoren."
	GwLocalization["BANK_COMPACT_ICONS"] = "Kompakte Icons"
	GwLocalization["BANK_EXPAND_ICONS"] = "Erweiterte Icons"
	GwLocalization["BUTTON_ASSIGNMENTS"] = "Aktionsbuttonzuweisungen"
	GwLocalization["BUTTON_ASSIGNMENTS_DESC"] = "Aktiviere oder deaktiviere die Aktionsbuttonzuweisungen"
	GwLocalization["CASTING_BAR_DESC"] = "Aktiviere die Zauberleiste im GW2 Style."
	GwLocalization["CHARACTER_NEXT_RANK"] = "NÄCHSTER"
	GwLocalization["CHARACTER_NOT_LOADED"] = "Nicht geladen."
	GwLocalization["CHARACTER_OUTFITS_DELETE"] = "Bist du sicher, dass du das Outfit löschen möchtest?"
	GwLocalization["CHARACTER_OUTFITS_SAVE"] = "Bist du sicher, dass du das Outfit speichern möchtest?"
	GwLocalization["CHARACTER_PARAGON"] = "Huldigend"
	GwLocalization["CHARACTER_REPUTATION_TRACK"] = "Als Bar anzeigen"
	GwLocalization["CHAT_BUBBLES"] = "Sprechblasen"
	GwLocalization["CHAT_BUBBLES_DESC"] = "Ersetze die standard Sprechblasen."
	GwLocalization["CHAT_FADE"] = "Chat verblassen"
	GwLocalization["CHAT_FADE_DESC"] = "Erlaube den Chat zu verblassen, wenn dieser nicht genutzt wird."
	GwLocalization["CHAT_FRAME_DESC"] = "Aktiviere das erweiterte Chatfenster."
	GwLocalization["CHRACTER_WINDOW_DESC"] = "Ersetzt das standard Charakterfenster."
	GwLocalization["CLASS_COLOR_DESC"] = "Aktiviert die Klassenfarbe als Gesundheitsanzeige"
	GwLocalization["CLASS_COLOR_RAID_DESC"] = "Benutze die Klassenfarben, anstelle von Klassensymbolen."
	GwLocalization["CLASS_POWER"] = "Klassenpower"
	GwLocalization["CLASS_POWER_DESC"] = "Aktiviere die alternativen Klassenpowerbars."
	GwLocalization["CLICK_TO_TRACK"] = "Zum Verfolgen klicken"
	GwLocalization["COMPACT_ICONS"] = "Kompakte Icons"
	GwLocalization["COMPASS_TOGGLE"] = "Kompass einschalten"
	GwLocalization["COMPASS_TOGGLE_DESC"] = "Aktiviere oder deaktiviere den Quest Tracker Kompass."
	GwLocalization["DAMAGED_OR_BROKEN_EQUIPMENT"] = "Beschädigte oder zerstörte Ausrüstung"
	GwLocalization["DEBUFF_DISPELL_DESC"] = "Zeige nur Schächungszauber an, die du entfernen kannst."
	GwLocalization["DISCORD"] = "Discord beitreten"
	GwLocalization["DYNAMIC_HUD"] = "Dynamisches HUD"
	GwLocalization["DYNAMIC_HUD_DESC"] = "Aktiviere oder deaktivieren das dynamische Ändern des HUD Hintergrundes."
	GwLocalization["EXP_BAR_TOOLTIP_EXP_RESTED"] = "Ausgeruht "
	GwLocalization["EXP_BAR_TOOLTIP_EXP_RESTING"] = " (Erholen)"
	GwLocalization["EXPAND_ICONS"] = "Erweiterte Icons"
	GwLocalization["FOCUS_DESC"] = "Modifiziere die Einstellungen der Fokuseinheit."
	GwLocalization["FOCUS_FRAME_DESC"] = "Aktiviert das Fokus Ziel."
	GwLocalization["FOCUS_TARGET_DESC"] = "Zeige das Ziel des Fokusziels an."
	GwLocalization["FOCUS_TOOLTIP"] = "Bearbeite die Einstellungen der Fokuseinheiten"
	GwLocalization["FONTS"] = "Schriftart"
	GwLocalization["FONTS_DESC"] = "Ersetze die standard Schriftart durch die GW 2 Schriftart."
	GwLocalization["GROUND_MARKER"] = "WM"
	GwLocalization["GROUP_DESC"] = "Bearbeite die Einstellungen der Gruppen und des Schlachtzugs zu deinen Bedürfnissen."
	GwLocalization["GROUP_FRAMES"] = "Gruppenrahmen"
	GwLocalization["GROUP_FRAMES_DESC"] = "Ersetze die Standard Gruppenfenster"
	GwLocalization["GROUP_TOOLTIP"] = "Bearbeite die Gruppeneinstellungen."
	GwLocalization["HEALTH_GLOBE"] = "Gesundheitskugel"
	GwLocalization["HEALTH_GLOBE_DESC"] = "Aktiviere die Gesundheitskugel."
	GwLocalization["HEALTH_PERCENTAGE_DESC"] = "Zeigt die Gesundheit in Prozent an. Kann auch in Verbindung oder anstelle der Gesundheit als Wert angezeigt werden."
	GwLocalization["HEALTH_VALUE_DESC"] = "Zeigt die Gesundheit als Wert an."
	GwLocalization["HIDE_EMPTY_SLOTS"] = "Leere Plätze ausblenden"
	GwLocalization["HIDE_EMPTY_SLOTS_DESC"] = "Verstecke die leeren Aktionsleitenplätze."
	GwLocalization["HUD_CAT"] = "HUD"
	GwLocalization["HUD_CAT_1"] = "HUD"
	GwLocalization["HUD_DESC"] = "Bearbeite die Module im HUD für mehr Individualisierung."
	GwLocalization["HUD_MOVE_ERR"] = "Du kannst keine Elemente während des Kampfes verschieben!"
	GwLocalization["HUD_SCALE"] = "HUD Skalierung"
	GwLocalization["HUD_SCALE_DESC"] = "Ändere die Größe des HUDs."
	GwLocalization["HUD_SCALE_TINY"] = "Sehr klein"
	GwLocalization["HUD_TOOLTIP"] = "Bearbeite die HUD Module."
	GwLocalization["INDICATORS"] = "Raid Indikatoren"
	GwLocalization["INDICATORS_DESC"] = "Bearbeite Aura Indikatoren in Raids."
	GwLocalization["INDICATORS_ICON"] = "Zeige Zauber Symbole"
	GwLocalization["INDICATORS_ICON_DESC"] = "Zeige Zauber Symbole anstatt einfarbige Quadrate."
	GwLocalization["INDICATORS_TIME"] = "Zeige verbleibende Zeit"
	GwLocalization["INDICATORS_TIME_DESC"] = "Zeige die verbleibende Zeit von Auren als Overlay."
	GwLocalization["INDICATOR_TITLE"] = "Indikator %s"
	GwLocalization["INDICATOR_DESC"] = "Bearbeite den Raid Aura Indikator %s."
	GwLocalization["INDICATOR_BAR"] = "Fortschrittsleiste"
	GwLocalization["INVENTORY_FRAME_DESC"] = "Aktiviere das einheitliche Iventar."
	GwLocalization["LEVEL_REWARDS"] = "Belohnung für die nächsten Level"
	GwLocalization["MAP_CLOCK_LOCAL_REALM"] = "Links Klick zum wechseln zwischen Lokaler- und Serverzeit "
	GwLocalization["MAP_CLOCK_MILITARY"] = "Shift-Klick zum umschalten in das militärische Zeitformat."
	GwLocalization["MAP_CLOCK_STOPWATCH"] = "Rechts Klick zum öffnen der Stoppuhr"
	GwLocalization["MAP_CLOCK_TIMEMANAGER"] = "Shift-Rechts Klick zum öffnen der Zeit Einstellungen"
	GwLocalization["MINIMAP_DESC"] = "Benutze den GW2 UI Minimaprahmen."
	GwLocalization["MINIMAP_HOVER"] = "Minimap Details"
	GwLocalization["MINIMAP_HOVER_TOOLTIP"] = "Zeige Minimap Informationen dauerhaft."
	GwLocalization["MINIMAP_SCALE"] = "Minimap Skalierung"
	GwLocalization["MINIMAP_SCALE_DESC"] = "Ändere die Größe der Minimap."
	GwLocalization["MODULES_CAT"] = "MODULE"
	GwLocalization["MODULES_CAT_1"] = "Module"
	GwLocalization["MODULES_CAT_TOOLTIP"]= "Aktiviere oder deaktiviere Komponenten"
	GwLocalization["MODULES_DESC"] = "Aktiviere oder deaktiviere die Module die du brauchst oder nicht brauchst."
	GwLocalization["MODULES_TOOLTIP"] = "Aktiviere oder deaktiviere UI Module."
	GwLocalization["MOUSE_TOOLTIP"] = "Tooltip an der Maus"
	GwLocalization["MOUSE_TOOLTIP_DESC"] = "Tooltips am Mauszeiger anzeigen"
	GwLocalization["MOVE_HUD_BUTTON"] = "HUD bewegen"
	GwLocalization["NAME_LOAD_ERROR"] = "Name konnte nicht geladen werden"
	GwLocalization["PET_BAR_DESC"] = "Benutze das verbesserten GW2 UI Begleiterfenster."
	GwLocalization["PLAYER_AURAS_DESC"] = "Bewege und verändere die Größe der Spieler Auren."
	GwLocalization["POWER_BARS_RAID_DESC"] = "Zeige die Ressourcenbalken in den Schlachtzugseinheiten."
	GwLocalization["PROFILES_CAT"] = "PROFILE"
	GwLocalization["PROFILES_CAT_1"] = "Profile"
	GwLocalization["PROFILES_CREATED"] = "Erstellt: "
	GwLocalization["PROFILES_CREATED_BY"] = "\nErstellt von: "
	GwLocalization["PROFILES_DEFAULT_SETTINGS"] = "Standardeinstellungen"
	GwLocalization["PROFILES_DEFAULT_SETTINGS_DESC"] = "Lade die standard Addon Einstellungen in das aktuelle Profil."
	GwLocalization["PROFILES_DEFAULT_SETTINGS_PROMPT"] = "Bist du sicher, dass du die Standardeinstellungen wiederhertellen möchtest?\n\nAlle vorherigen Einstellungen gehen dabei verloren."
	GwLocalization["PROFILES_DELETE"] = "Bist du sicher, dass du dieses Profil löschen möchtest?"
	GwLocalization["PROFILES_DESC"] = "Profile sind ein einfacher Weg Einstellungen zwischen Charakteren und Servern zu teilen."
	GwLocalization["PROFILES_LAST_UPDATE"] = "\nzuletzt aktualisiert: "
	GwLocalization["PROFILES_LOAD_BUTTON"] = "Laden"
	GwLocalization["PROFILES_MISSING_LOAD"] = "Wenn du diese Text siehst, haben wir vergessen einen Text zu laden."
	GwLocalization["PROFILES_TOOLTIP"] = "Erstelle und lösche Profile."
	GwLocalization["QUEST_TRACKER_DESC"] = "Aktiviere den erneuerten und verbesserten Quest Tracker."
	GwLocalization["QUEST_VIEW_SKIP"] = "Überspringen"
	GwLocalization["QUESTING_FRAME"] = "Immersiv Questing"
	GwLocalization["QUESTING_FRAME_DESC"] = "Aktiviere die Immersiv Questing Ansicht."
	GwLocalization["RAID_ANCHOR"] = "Setze die Schlachtzug-Verankerung"
	GwLocalization["RAID_ANCHOR_DESC"] = "Bestimme wo der Schlachtzugcontainer verankert sein soll.\n\nNach Position: Immer so wie seine Position auf dem Bildschirm.\nNach Wachstum: Immer entgegen seiner der Wachstumsrichtung."
	GwLocalization["RAID_ANCHOR_BY_POSITION"] = "Nach Position auf dem Bildschirm"
	GwLocalization["RAID_ANCHOR_BY_GROWTH"] = "Nach Wachstumsrichtung"
	GwLocalization["RAID_BAR_HEIGHT"] = "Höhe der Schlachtzugseinheiten"
	GwLocalization["RAID_BAR_HEIGHT_DESC"] = "Setze die Höhe der Schlachtzugseinheiten."
	GwLocalization["RAID_BAR_WIDTH"] = "Breite der Schlachtzugseinheiten"
	GwLocalization["RAID_BAR_WIDTH_DESC"] = "Setze die Breite der Schlachtzugseinheiten."
	GwLocalization["RAID_CONT_HEIGHT"] = "Höhe des Schlachtzugcontainers"
	GwLocalization["RAID_CONT_HEIGHT_DESC"] = "Setze die maximale Höhe des Schlachtzugcontainers.\n\nSchlachtzugeinheiten werden verkleinert oder in die nächste Spalte verschoben."
	GwLocalization["RAID_CONT_WIDTH"] = "Breite des Schlachtzugcontainers"
	GwLocalization["RAID_CONT_WIDTH_DESC"] = "Setze die maximale Breite des Schlachtzugcontainers.\n\nSchlachtzugeinheiten werden verkleinert oder in die nächste Zeile verschoben."
	GwLocalization["RAID_GROW"] = "Bestimme die Wachstumsrichtung"
	GwLocalization["RAID_GROW_DESC"] = "Bestimme die Wachstumsrichtung der Schlachtzugsfenster."
	GwLocalization["RAID_GROW_DIR"] = "%s und dann %s"
	GwLocalization["RAID_MARKER_DESC"] = "Die Zielmarkierungen werden auf den Schlachtzugeinheiten angezeigt"
	GwLocalization["RAID_PARTY_STYLE_DESC"] = "Style die Gruppeneinheiten genau so wie die Schlachtzugseinheiten."
	GwLocalization["RAID_PREVIEW"] = "Schlachtzugsvorschau"
	GwLocalization["RAID_PREVIEW_DESC"] = "Zeige/Verberge die Vorschau des Schlachtzugsfenders und durchlaufe verschiedene Gruppengrößen."
	GwLocalization["RAID_SORT_BY_ROLE"] = "Sortiere Schlachtzug nach Rolle"
	GwLocalization["RAID_SORT_BY_ROLE_DESC"] = "Sortiere Einheitenfenster in Schlachtzügen nach Rolle (Tank, Heiler, Schaden) anstatt nach Gruppe."
	GwLocalization["RAID_AURA_TOOLTIP_IN_COMBAT"] = "Zeige Aura-Tooltips auch im Kampf"
	GwLocalization["RAID_AURA_TOOLTIP_IN_COMBAT_DESC"] = "Zeige Tooltips von Buffs und Debuffs auch im Kampf."
	GwLocalization["RAID_UNIT_FLAGS"] = "Zeige Länderflaggen"
	GwLocalization["RAID_UNIT_FLAGS_2"] = "Nur andere Länder als das Eigene"
	GwLocalization["RAID_UNIT_FLAGS_TOOLTIP"] = "Zeige die Länderflaggen der Spieler neben dem Namen"
	GwLocalization["RAID_UNITS_PER_COLUMN"] = "Schlachtzugseinheiten pro Spalte"
	GwLocalization["RAID_UNITS_PER_COLUMN_DESC"] = "Setzen die Anzahl der Wachstumsrichtung der Schlachtzugsfenster pro Spalte oder Zeile, abhängig von der Wachstumsrichtung."
	GwLocalization["RESOURCE_DESC"] = "Ersetze die Standard Mana/Powerbar."
	GwLocalization["SETTING_LOCK_HUD"] = "HUD sperren"
	GwLocalization["SETTINGS_BUTTON"] = "GW2 UI Einstellungen"
	GwLocalization["SETTINGS_NO_LOAD_ERROR"] = "Einige Texte wurden nicht geladen, bitte versuche dein Interface neu zu laden."
	GwLocalization["SETTINGS_RESET_TO_DEFAULT"] = "Standardeinstellungen wiederherstellen."
	GwLocalization["SETTINGS_SAVE_RELOAD"] = "Speichern und \nneu laden"
	GwLocalization["SHOW_ALL_DEBUFFS_DESC"] = "Zeige alle Schächungszauber des Ziels an."
	GwLocalization["SHOW_BUFFS_DESC"] = "Zeige die Stärkungszauber des Ziels."
	GwLocalization["SHOW_DEBUFFS_DESC"] = "Zeige die Schwächungszauber des Ziel, welche du zugefügt hast."
	GwLocalization["SHOW_ILVL"] = "Zeige durschnittliches Item-Level"
	GwLocalization["SHOW_ILVL_DESC"] = "Zeige das durschnittliche Item-Level statt des Prestige-Levels für freundliche Einheiten."
	GwLocalization["TARGET_DESC"] = "Modifiziere die Einstellungen der Zieleinheit."
	GwLocalization["TARGET_FRAME_DESC"] = "Aktiviere den Zieleinheiten."
	GwLocalization["TARGET_OF_TARGET_DESC"] = "Aktiert das Ziel des Ziels."
	GwLocalization["TARGET_TOOLTIP"] = "Bearbeite die Einstellungen der Zieleinheit"
	GwLocalization["TOOLTIPS"] = "Tooltips"
	GwLocalization["TOOLTIPS_DESC"] = "Ersetze die Standard UI Tooltips."
	GwLocalization["TRACKER_RETRIVE_CORPSE"] = "Erreiche deine Leiche"
	GwLocalization["UPDATE_STRING_1"] = "Ein neues Update steht zum download bereit."
	GwLocalization["UPDATE_STRING_2"] = "Ein neues Update mit neuen Funktionen ist verfügbar."
	GwLocalization["UPDATE_STRING_3"] = "Ein  |cFFFF0000wichtiges|r update ist verfügbar.\nEs wird drigend empfohlen ein Umpdate durch zuführen."
	GwLocalization["UNEQUIP_LEGENDARY"] = "Du musst das Item erst ausziehen, bevor du es aufwerten kannst."
	GwLocalization["NOT_A_LEGENDARY"] = "Du kannst dieses Item nicht aufwerten."
	GwLocalization["BAG_SORT_ORDER_FIRST"] = "Sortieren: Erste Tasche"
	GwLocalization["BAG_SORT_ORDER_LAST"] = "Sortieren: Letzte Tasche"
	GwLocalization["BAG_NEW_ORDER_FIRST"] = "Neue Items in erste Tasche"
	GwLocalization["BAG_NEW_ORDER_LAST"] = "Neue Items in letzte Tasche"
	GwLocalization["BAG_ORDER_NORMAL"] = "Normale Sortierung"
	GwLocalization["BAG_ORDER_REVERSE"] = "Umgekehrte Sortierung"
	GwLocalization["STG_RIGHT_BAR_COLS"] = "Rechte Aktionleistenbreite"
	GwLocalization["STG_RIGHT_BAR_COLS_DESC"] = "Anzahl an Spalten für die zwei extra Aktionsleisten an der rechten Seite."
	GwLocalization["DISABLED_MA_BAGS"] = "MoveAnything's Taschen Handling ausgeschaltet."
	GwLocalization["FADE_MICROMENU"] = "Micro Menü ausblenden"
	GwLocalization["FADE_MICROMENU_DESC"] = "Blendet das Micro Menü aus, wenn die Maus nicht in der Nähe ist."
	GwLocalization["TALENTS_BUTTON_DESC"] = "Aktiviert das GW2_UI Talent-, Berufs- und Zauberbuchfenster."
	GwLocalization["ALL_BINDINGS_SAVE"] = "Alle Tastaturbelegungen wurden gespeichert."
	GwLocalization["ALL_BINDINGS_DISCARD"] = "Alle neu gesetzten Tastaturbelegungen wurden verworfen."
	GwLocalization["BINDINGS_DESC"] = "Bewegen Sie die Maus über eine beliebige Aktionstaste, um sie zu binden. Drücken Sie die Escape-Taste oder klicken Sie mit der rechten Maustaste, um die Tastaturkürzel der aktuellen Aktionstaste zu löschen."
	GwLocalization["BINDINGS_TRIGGER"] = "Auslösen"
	GwLocalization["BINGSINGS_KEY"] = "Taste"
	GwLocalization["BINGSINGS_CLEAR"] = "Alle Tastaturbelegungen gelöscht für"
	GwLocalization["BINGSINGS_BIND"] = "gebunden an"
	GwLocalization["MINIMAP_POS"] = "Minikartenposition"
	GwLocalization["MINIMAP_COORDS"] = "Koordinaten"
	GwLocalization["WORLD_MARKER_DESC"] = "Zeige Menü, um in Schlachtzügen Welt-Markierungen zu positionieren."
	GwLocalization["UP"] = "hoch"
	GwLocalization["DOWN"] = "runter"
	GwLocalization["LEFT"] = "links"
	GwLocalization["RIGHT"] = "rechts"
	GwLocalization["TOP"] = "hoch"
	GwLocalization["BOTTOM"] = "unten"
	GwLocalization["CENTER"] = "mitte"
	GwLocalization["TOPLEFT"] = ("%s %s"):format(GwLocalization["TOP"], GwLocalization["LEFT"])
	GwLocalization["TOPRIGHT"] = ("%s %s"):format(GwLocalization["TOP"], GwLocalization["RIGHT"])
	GwLocalization["BOTTOMLEFT"] = ("%s %s"):format(GwLocalization["BOTTOM"], GwLocalization["LEFT"])
	GwLocalization["BOTTOMRIGHT"] = ("%s %s"):format(GwLocalization["BOTTOM"], GwLocalization["RIGHT"])
	GwLocalization["RAID_UNIT_LOST_HEALTH_PREC"] = "Verlorene Gesundheit in Prozent"
	GwLocalization["SHOW_THREAT_VALUE"] = "Bedrohung anzeigen"
	GwLocalization["MINIMAP_FPS"] = "FPS an der Minimap anzeigen"
	GwLocalization["TARGET_COMBOPOINTS"] = "Zeige Combopunkt am Ziel"
	GwLocalization["TARGET_COMBOPOINTS_DEC"] = "Zeige Combopunkt am Ziel unterhalb des Gesundheitsbalkens"
	GwLocalization["PIXEL_PERFECTION"] = "Pixel Perfection-Modus"
	GwLocalization["PIXEL_PERFECTION_DESC"] = "Skaliert das UI in einen Pixel Perfection-Modus. Dieser ist abhängig von der Bildschirmauflösung."
	GwLocalization["WELCOME_SPLASH_HEADER"] = "Willkommen beim GW2-UI"
	GwLocalization["CHANGELOG"] = "Changelog"
	GwLocalization["WELCOME"] = "Willkommen"
	GwLocalization["PIXEL_PERFECTION_ON"] = "Pixel Perfection-Modus einschalten"
	GwLocalization["PIXEL_PERFECTION_OFF"] = "Pixel Perfection-Modus ausschalten"
	GwLocalization["WELCOME_SPLASH_WELCOME_TEXT"] = "Das GW2-UI ist ein vollständiger UI-Ersatz. Wir haben die Benutzeroberfläche modular aufgebaut, dies bedeutet, wenn du einen bestimmten Teil des Addons nicht magst - oder du hast ein anders Addon, dass du für die Funktion bevorzugst - kannst du diesen Teil einfach deaktivieren, während der Rest des UI's intakt bleibt.\nEinige der Module, die dir zur Verfügung stehen, sind ein umfassendes Questfenster, ein vollständiger Inventarersatz sowie ein vollständiger Charakterfesterersatz. Es gibt viel mehr welche du erleben kannst. Wirf einfach ein Blick in die Einstellungen und schaue was zur Verfügung steht."
	GwLocalization["WELCOME_SPLASH_WELCOME_TEXT_PP"] = "Was ist 'Pixel Perfection'?\n\nGW2 UI verfügt über eine integrierte Einstellung namens 'Pixel Perfection Mode'. Das bedeutet für dich, dass das UI wie vorgesehen aussieht, mit gestochen scharfen Texturen und einer besseren Skalierung. Natürlich kannst du dies in den Einstellungen ausschalten, falls du dies vorziehst."
	GwLocalization["FUTURE_SPELLS"] = "Zukünftige Zauber"
	GwLocalization["STANCEBAR_POSITION"] = "Position der Stancebar"
	GwLocalization["STANCEBAR_POSITION_DESC"] = "Setze die Position der Stancebar (Links oder recht von der Hauptaktionsleiste)"
end
	
	
if GetLocale() == "deDE" then
	GWUseThisLocalization()
end

-- After using this localization or deciding that we don"t need it, remove it from memory.
GWUseThisLocalization = nil
	
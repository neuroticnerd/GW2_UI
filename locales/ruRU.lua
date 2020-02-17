-- ruRU localization

local function GWUseThisLocalization()
	-- Create a global variable for the language strings
	GwLocalization = {}

	--Fonts
	GwLocalization['FONT_NORMAL'] = 'Interface\\AddOns\\GW2_UI\\fonts\\menomonia.ttf' 
	GwLocalization['FONT_BOLD'] = 'Interface\\AddOns\\GW2_UI\\fonts\\headlines.ttf' 
	GwLocalization['FONT_NARROW'] = 'Interface\\AddOns\\GW2_UI\\fonts\\menomonia.ttf'
	GwLocalization['FONT_NARROW_BOLD'] = 'Interface\\AddOns\\GW2_UI\\fonts\\menomonia.ttf'
	GwLocalization['FONT_LIGHT'] = 'Interface\\AddOns\\GW2_UI\\fonts\\menomonia-italic.ttf'
	GwLocalization['FONT_DAMAGE'] = 'Interface\\AddOns\\GW2_UI\\fonts\\headlines.ttf'

	--Strings
	GwLocalization["ACTION_BAR_FADE"] = "Скрывать панели"
	GwLocalization["ACTION_BAR_FADE_DESC"] = "Скрыть дополнительные панели вне боя."
	GwLocalization["ACTION_BARS_DESC"] = "Использовать интерфейс GW2 UI для панелей."
	GwLocalization["ADV_CAST_BAR"] = "Информативный кастбар"
	GwLocalization["ADV_CAST_BAR_DESC"] = "Включить или выключить дополнительную индикацию кастбара."
	GwLocalization["ALL_BINDINGS_DISCARD"] = "Новые назначенные клавиши были сброшены."
	GwLocalization["ALL_BINDINGS_SAVE"] = "Назначенные клавиши были сохранены."
	GwLocalization["AMOUNT_LOAD_ERROR"] = "Какие-то ошибки"
	GwLocalization["AURAS_DESC"] = "Изменить отображение бафов и дебафов."
	GwLocalization["AURAS_IGNORED"] = "Не отображать ауры"
	GwLocalization["AURAS_IGNORED_DESC"] = "Никогда не показывать ауры из списка"
	GwLocalization["AURAS_MISSING"] = "Не хватает бафов"
	GwLocalization["AURAS_MISSING_DESC"] = "Отображать бафы из списка, только если их нет."
	GwLocalization["AURAS_TOOLTIP"] = "Настроить отображение аур и индикации на панелях."
	GwLocalization["BAG_NEW_ORDER_FIRST"] = "Новое в начале"
	GwLocalization["BAG_NEW_ORDER_LAST"] = "Новое в конце"
	GwLocalization["BAG_ORDER_NORMAL"] = "Порядок сумок сверху"
	GwLocalization["BAG_ORDER_REVERSE"] = "Порядок сумок снизу"
	GwLocalization["BAG_SORT_ORDER_FIRST"] = "Сортировать сверху"
	GwLocalization["BAG_SORT_ORDER_LAST"] = "Сортировать снизу"
	GwLocalization["BANK_COMPACT_ICONS"] = "Уменьшить иконки"
	GwLocalization["BANK_EXPAND_ICONS"] = "Увеличить иконки"
	GwLocalization["BINDINGS_DESC"] = "Наведите курсор на кнопку, чтобы привязать клавиши либо очистить от назначенных клавиш, нажав ESC или ПКМ при наведении."
	GwLocalization["BINDINGS_TRIGGER"] = "Триггер"
	GwLocalization["BINGSINGS_BIND"] = "назначить на"
	GwLocalization["BINGSINGS_CLEAR"] = "Назначения клавиш сброшены для "
	GwLocalization["BINGSINGS_KEY"] = "Клавиша"
	GwLocalization["BOTTOM"] = "внизу"
	GwLocalization["BUTTON_ASSIGNMENTS"] = "Отображение назначенных клавиш"
	GwLocalization["BUTTON_ASSIGNMENTS_DESC"] = "Включить или выключить отображение назначенных клавиш на кнопках на панели задач."
	GwLocalization["CASTING_BAR_DESC"] = "Использовать интерфейс GW2 UI для полоски каста."
	GwLocalization["CENTER"] = "по центру"
	GwLocalization["CHANGELOG"] = "Список изменений"
	GwLocalization["CHARACTER_NEXT_RANK"] = "Следующий"
	GwLocalization["CHARACTER_NOT_LOADED"] = "Не загружено."
	GwLocalization["CHARACTER_OUTFITS_DELETE"] = "Вы уверены, что хотите удалить этот набор?"
	GwLocalization["CHARACTER_OUTFITS_SAVE"] = "Вы уверены, что хотите сохранить этот набор?"
	GwLocalization["CHARACTER_PARAGON"] = "Образец"
	GwLocalization["CHARACTER_REPUTATION_TRACK"] = "Отображать полосу"
	GwLocalization["CHAT_BUBBLES"] = "Облачка чата"
	GwLocalization["CHAT_BUBBLES_DESC"] = "Заменить стандартные облачка чата."
	GwLocalization["CHAT_FADE"] = "Затемнить чат"
	GwLocalization["CHAT_FADE_DESC"] = "Затемнять неактивный чат."
	GwLocalization["CHAT_FRAME_DESC"] = "Использовать интерфейс GW2 UI для окна чата."
	GwLocalization["CHRACTER_WINDOW_DESC"] = "Использовать интерфейс GW2 UI для окна персонажа."
	GwLocalization["CLASS_COLOR_DESC"] = "Окрасить рамку цели в цвет класса."
	GwLocalization["CLASS_COLOR_RAID_DESC"] = "Использовать цвета вместо иконок классов."
	GwLocalization["CLASS_POWER"] = "Индикатор личного ресурса"
	GwLocalization["CLASS_POWER_DESC"] = "Заменить стандартный индикатор личного ресурса."
	GwLocalization["CLICK_TO_TRACK"] = "Отследить"
	GwLocalization["COMPACT_ICONS"] = "Маленькие иконки"
	GwLocalization["COMPASS_TOGGLE"] = "Компас"
	GwLocalization["COMPASS_TOGGLE_DESC"] = "Включить или отключить компас для заданий."
	GwLocalization["DAMAGED_OR_BROKEN_EQUIPMENT"] = "Экипировка повреждена или сломана"
	GwLocalization["DEBUFF_DISPELL_DESC"] = "Отображать только те дебафы, которые можно снять."
	GwLocalization["DISABLED_MA_BAGS"] = "Отключить обработку сумок плагином MoveAnything."
	GwLocalization["DISCORD"] = "Discord"
	GwLocalization["DOWN"] = "вниз"
	GwLocalization["DYNAMIC_HUD"] = "Динамические эффекты HUD"
	GwLocalization["DYNAMIC_HUD_DESC"] = "Включить или отключить динамические визуальные эффекты интерфейса."
	GwLocalization["EXP_BAR_TOOLTIP_EXP_RESTED"] = "Состояние бодрости "
	GwLocalization["EXP_BAR_TOOLTIP_EXP_RESTING"] = " (Вы отдыхаете)"
	GwLocalization["EXPAND_ICONS"] = "Большие иконки"
	GwLocalization["FADE_MICROMENU"] = "Скрывать панель меню"
	GwLocalization["FADE_MICROMENU_DESC"] = "Показывать панель меню только при наведении курсора."
	GwLocalization["FOCUS_DESC"] = "Настроить рамку запомненной цели."
	GwLocalization["FOCUS_FRAME_DESC"] = "Использовать интерфейс GW2 UI для рамки запомненной цели."
	GwLocalization["FOCUS_TARGET_DESC"] = "Показать рамку запомненной цели."
	GwLocalization["FOCUS_TOOLTIP"] = "Настроить рамку запомненной цели."
	GwLocalization["FONTS"] = "Шрифты"
	GwLocalization["FONTS_DESC"] = "Заменить шрифты по умолчанию на шрифты GW 2 UI"
	GwLocalization["GROUND_MARKER"] = "Панель меток"
	GwLocalization["GROUP_DESC"] = "Редактировать необходимые настройки окон группы и рейда."
	GwLocalization["GROUP_FRAMES"] = "Окно группы"
	GwLocalization["GROUP_FRAMES_DESC"] = "Использовать интерфейс GW2 UI для рейд-фреймов."
	GwLocalization["GROUP_TOOLTIP"] = "Изменить настройки рейд-фреймов."
	GwLocalization["HEALTH_GLOBE"] = "Панель здоровья"
	GwLocalization["HEALTH_GLOBE_DESC"] = "Использовать интерфейс GW2 UI для полосы здоровья."
	GwLocalization["HEALTH_PERCENTAGE_DESC"] = "Отображать здоровье в процентах. Можно использовать вместе с цифровым значением."
	GwLocalization["HEALTH_VALUE_DESC"] = "Цифровое обозначение здоровья."
	GwLocalization["HIDE_EMPTY_SLOTS"] = "Скрыть пустые слоты"
	GwLocalization["HIDE_EMPTY_SLOTS_DESC"] = "Скрыть пустые слоты на панели команд."
	GwLocalization["HUD_CAT"] = "HUD"
	GwLocalization["HUD_CAT_1"] = "HUD"
	GwLocalization["HUD_DESC"] = "Настроить модули HUD'а для большей кастомизации."
	GwLocalization["HUD_MOVE_ERR"] = "Вы не можете перемещать элементы интерфейса в бою!"
	GwLocalization["HUD_SCALE"] = "Масштаб HUD"
	GwLocalization["HUD_SCALE_DESC"] = "Изменить размер HUD."
	GwLocalization["HUD_SCALE_TINY"] = "Очень маленький"
	GwLocalization["HUD_TOOLTIP"] = "Включить модули HUD."
	GwLocalization["INDICATOR_BAR"] = "полоса прогресса"
	GwLocalization["INDICATOR_DESC"] = "Настроить %s индикатор ауры."
	GwLocalization["INDICATOR_TITLE"] = "%s индикатор"
	GwLocalization["INDICATORS"] = "Индикация в рейде"
	GwLocalization["INDICATORS_DESC"] = "Редактировать индикаторы аур."
	GwLocalization["INDICATORS_ICON"] = "Показать иконки способностей"
	GwLocalization["INDICATORS_ICON_DESC"] = "Отображать нативные иконки способностей."
	GwLocalization["INDICATORS_TIME"] = "Показать отсчёт времени"
	GwLocalization["INDICATORS_TIME_DESC"] = "Отображать анимацию отсчёта времени."
	GwLocalization["INVENTORY_FRAME_DESC"] = "Включить единый стиль интерфейса для инвентаря."
	GwLocalization["LEFT"] = "слева"
	GwLocalization["LEVEL_REWARDS"] = "Награда за уровень"
	GwLocalization["MAP_CLOCK_LOCAL_REALM"] = "ЛКМ для переключения между локальным и серверным временем"
	GwLocalization["MAP_CLOCK_MILITARY"] = "Shift+ЛКМ для переключения на 24-часовой формат"
	GwLocalization["MAP_CLOCK_STOPWATCH"] = "ПКМ для открытия секундомера"
	GwLocalization["MAP_CLOCK_TIMEMANAGER"] = "Shift+ПКМ для открытия будильника"
	GwLocalization["MINIMAP_COORDS"] = "Координаты"
	GwLocalization["MINIMAP_DESC"] = "Использовать мини-карту в стиле GW2 UI"
	GwLocalization["MINIMAP_FPS"] = "Показать FPS на мини-карте"
	GwLocalization["MINIMAP_HOVER"] = "Элементы миникарты"
	GwLocalization["MINIMAP_HOVER_TOOLTIP"] = "Постоянно показывать выбранные элементы миникарты."
	GwLocalization["MINIMAP_POS"] = "Расположение мини-карты"
	GwLocalization["MINIMAP_SCALE"] = "Скалирование мини-карты"
	GwLocalization["MINIMAP_SCALE_DESC"] = "Изменить размер мини-карты."
	GwLocalization["MODULES_CAT"] = "МОДУЛИ"
	GwLocalization["MODULES_CAT_1"] = "Модули"
	GwLocalization["MODULES_CAT_TOOLTIP"] = "Включить или выключить модули"
	GwLocalization["MODULES_DESC"] = "Включить или выключить модули интерфейса, которые вам нужны."
	GwLocalization["MODULES_TOOLTIP"] = "Включить или выключить модули интерфейса."
	GwLocalization["MOUSE_TOOLTIP"] = "Подсказки под курсором"
	GwLocalization["MOUSE_TOOLTIP_DESC"] = "Прикрепить всплывающие подсказки к курсору."
	GwLocalization["MOVE_HUD_BUTTON"] = "Вид HUD"
	GwLocalization["NAME_LOAD_ERROR"] = "Не удалось загрузить имя"
	GwLocalization["NOT_A_LEGENDARY"] = "Этот предмет нельзя улучшить."
	GwLocalization["PET_BAR_DESC"] = "Использовать интерфейс GW2 UI для панели питомца."
	GwLocalization["PIXEL_PERFECTION"] = "Режим Pixel Perfection"
	GwLocalization["PIXEL_PERFECTION_DESC"] = "Скалирует интерфейс под режим Pixel Perfection."
	GwLocalization["PIXEL_PERFECTION_OFF"] = "Отключить режим Pixel Perfection"
	GwLocalization["PIXEL_PERFECTION_ON"] = "Включить режим Pixel Perfection"
	GwLocalization["PLAYER_AURAS_DESC"] = "Переместить ауры и бафы игрока."
	GwLocalization["POWER_BARS_RAID_DESC"] = "Отобразить индикаторы личного ресурса в рейд-фрейме."
	GwLocalization["PROFILES_CAT"] = "ПРОФИЛИ"
	GwLocalization["PROFILES_CAT_1"] = "Профили"
	GwLocalization["PROFILES_CREATED"] = "Создан: "
	GwLocalization["PROFILES_CREATED_BY"] = "Создан: "
	GwLocalization["PROFILES_DEFAULT_SETTINGS"] = "Настройки по умолчанию"
	GwLocalization["PROFILES_DEFAULT_SETTINGS_DESC"] = "Сбросить настройки аддона по умолчанию для текущего профиля."
	GwLocalization["PROFILES_DEFAULT_SETTINGS_PROMPT"] = [=[Вы уверены, что вы хотите сбросить настройки по умолчанию?\nВсе предыдущие настройки будут утеряны.]=]
	GwLocalization["PROFILES_DELETE"] = "Вы уверены, что вы хотите удалить этот профиль?"
	GwLocalization["PROFILES_DESC"] = "Профили помогут легко применять настройки для любых персонажей и серверов."
	GwLocalization["PROFILES_LAST_UPDATE"] = " Последнее обновление: "
	GwLocalization["PROFILES_LOAD_BUTTON"] = "Сброс"
	GwLocalization["PROFILES_MISSING_LOAD"] = "Данное сообщение означает, что мы забыли добавить здесь текст. Не беспокойтесь, для таких случаев у нас есть это самое предупреждение, чтобы вы были в курсе."
	GwLocalization["PROFILES_TOOLTIP"] = "Добавлять и удалять профили."
	GwLocalization["QUEST_REQUIRED_ITEMS"] = "Необходимые предметы:"
	GwLocalization["QUEST_TRACKER_DESC"] = "Использовать интерфейс GW2 UI для отображения заданий."
	GwLocalization["QUEST_VIEW_SKIP"] = "Пропустить"
	GwLocalization["QUESTING_FRAME"] = "Задания с улучшенным погружением"
	GwLocalization["QUESTING_FRAME_DESC"] = "Использовать оформление заданий в стиле GW2."
	GwLocalization["RAID_ANCHOR"] = "Привязка окна рейда"
	GwLocalization["RAID_ANCHOR_BY_GROWTH"] = "К вектору роста фреймов"
	GwLocalization["RAID_ANCHOR_BY_POSITION"] = "К позиции на экране"
	GwLocalization["RAID_ANCHOR_DESC"] = "Выберите привязку окна рейда. К позиции: Всегда там же, где и фрейм-контейнер на экране. К вектору: Всегда против вектора роста фреймов."
	GwLocalization["RAID_AURA_TOOLTIP_IN_COMBAT"] = "Подсказки в бою"
	GwLocalization["RAID_AURA_TOOLTIP_IN_COMBAT_DESC"] = "Показывать подсказки к бафам и дебафам даже когда вы в бою."
	GwLocalization["RAID_BAR_HEIGHT"] = "Высота юнит-фреймов"
	GwLocalization["RAID_BAR_HEIGHT_DESC"] = "Установить высоту рейдовых юнит-фреймов."
	GwLocalization["RAID_BAR_WIDTH"] = "Ширина юнит-фреймов"
	GwLocalization["RAID_BAR_WIDTH_DESC"] = "Установить ширину рейдовых юнит-фреймов."
	GwLocalization["RAID_CONT_HEIGHT"] = "Высота окна рейда"
	GwLocalization["RAID_CONT_HEIGHT_DESC"] = "Установить максимальную высоту для окна рейда.\nЭто уменьшит высоту юнит-фреймов или сдвинет их в соседний столбец."
	GwLocalization["RAID_CONT_WIDTH"] = "Ширина окна рейда"
	GwLocalization["RAID_CONT_WIDTH_DESC"] = "Установить максимальную ширину для окна рейда.\nЭто уменьшит ширину юнит-фреймов или сдвинет их на другую строку."
	GwLocalization["RAID_GROW"] = "Вектор роста фреймов"
	GwLocalization["RAID_GROW_DESC"] = "Выберите вектор роста рейдовых фреймов."
	GwLocalization["RAID_GROW_DIR"] = "%s и потом %s"
	GwLocalization["RAID_MARKER_DESC"] = "Отобразить метки цели на рейдовых юнит-фреймах."
	GwLocalization["RAID_PARTY_STYLE_DESC"] = "Групповые фреймы выглядят как рейдовые фреймы."
	GwLocalization["RAID_PREVIEW"] = "Предпросмотр фреймов"
	GwLocalization["RAID_PREVIEW_DESC"] = "Включите предпросмотр фреймов и переключайтесь между размерами группы."
	GwLocalization["RAID_SORT_BY_ROLE"] = "Отсортировать по ролям"
	GwLocalization["RAID_SORT_BY_ROLE_DESC"] = "Отсортировать юнит-фреймы по ролям (танк, лекарь, боец) вместо сортировки по группам."
	GwLocalization["RAID_UNIT_FLAGS"] = "Показать флаг страны"
	GwLocalization["RAID_UNIT_FLAGS_2"] = "Только другие страные"
	GwLocalization["RAID_UNIT_FLAGS_TOOLTIP"] = "Отобразить флаги стран игроков по языку серверов"
	GwLocalization["RAID_UNIT_LOST_HEALTH_PREC"] = "Оставшееся здоровье в процентах"
	GwLocalization["RAID_UNITS_PER_COLUMN"] = "Число юнит-фреймов в столбце"
	GwLocalization["RAID_UNITS_PER_COLUMN_DESC"] = "Установить число рейдовых юнит-фреймов в столбцах или строках в зависимости от вектора роста фреймов."
	GwLocalization["RESOURCE_DESC"] = "Заменить стандартную панель основного ресурса (мана, энергия и т.д.)."
	GwLocalization["RIGHT"] = "cправа"
	GwLocalization["SETTING_LOCK_HUD"] = "Закрепить HUD"
	GwLocalization["SETTINGS_BUTTON"] = "Настройки GW2 UI"
	GwLocalization["SETTINGS_NO_LOAD_ERROR"] = "Некоторый текст не загружен, пожалуйста, перезагрузите интерфейс."
	GwLocalization["SETTINGS_RESET_TO_DEFAULT"] = "Сбросить настройки по умолчанию."
	GwLocalization["SETTINGS_SAVE_RELOAD"] = "Применить"
	GwLocalization["SHOW_ALL_DEBUFFS_DESC"] = "Отображать все отрицательные эффекты на цели."
	GwLocalization["SHOW_BUFFS_DESC"] = "Отображать положительные эффекты на цели."
	GwLocalization["SHOW_DEBUFFS_DESC"] = "Отображать только наложенные вами отрицательные эффекты."
	GwLocalization["SHOW_ILVL"] = "Отображать средний уровень предметов"
	GwLocalization["SHOW_ILVL_DESC"] = "Отображать средний уровень предметов вместо уровня чести на союзных целях."
	GwLocalization["SHOW_THREAT_VALUE"] = "Уровень угрозы цели"
	GwLocalization["STG_RIGHT_BAR_COLS"] = "Ширина доп. панелей"
	GwLocalization["STG_RIGHT_BAR_COLS_DESC"] = "Количество столбцов в двух дополнительных правых панелях команд."
	GwLocalization["TALENTS_BUTTON_DESC"] = "Заменить стиль оформления талантов, специализации и заклинаний."
	GwLocalization["TARGET_COMBOPOINTS"] = "Отображать очки комбо на цели"
	GwLocalization["TARGET_COMBOPOINTS_DEC"] = "Отображать очки комбо на цели под полосой здоровья."
	GwLocalization["TARGET_DESC"] = "Изменить настройки рамки цели."
	GwLocalization["TARGET_FRAME_DESC"] = "Заменить рамку цели."
	GwLocalization["TARGET_OF_TARGET_DESC"] = "Включить отображение цели выбранной цели."
	GwLocalization["TARGET_TOOLTIP"] = "Изменить настройки рамок целей."
	GwLocalization["TOOLTIPS"] = "Подсказки"
	GwLocalization["TOOLTIPS_DESC"] = "Заменить стандартный интерфейс для подсказок."
	GwLocalization["TOP"] = "вверху"
	GwLocalization["TRACKER_RETRIVE_CORPSE"] = "Найдите ваше тело"
	GwLocalization["UNEQUIP_LEGENDARY"] = "Вы должны снять этот предмет, чтобы улучшить его."
	GwLocalization["UP"] = "вверх"
	GwLocalization["UPDATE_STRING_1"] = "Доступно новое обновление для загрузки."
	GwLocalization["UPDATE_STRING_2"] = "Доступно обновление с новыми возможностями."
	GwLocalization["UPDATE_STRING_3"] = "Доступно обновление |cFFFF0000major|r.\nНастоятельно рекомендуем обновиться."
	GwLocalization["WELCOME"] = "Инфо"
	GwLocalization["WELCOME_SPLASH_HEADER"] = "Приветствуем в GW2 UI"
	GwLocalization["WELCOME_SPLASH_WELCOME_TEXT"] = "GW2 UI - полная замена пользовательского интерфейса. Мы создали модульный UI, его суть в том, что если вам не нравится определенная часть аддона или у вас есть другой аддон для той же функции, вы можете просто отключить эту часть, оставив остальной интерфейс нетронутым. Некоторые из доступных вам модулей - это захватывающее окно квестов, полная замена инвентаря, а также полная замена окна персонажа. Здесь полно того, что вам понравится, просто зайдите в меню настроек, чтобы увидеть все доступные опции!"
	GwLocalization["WELCOME_SPLASH_WELCOME_TEXT_PP"] = "Что такое 'Pixel Perfection'?\n\nВ GW2 UI есть режим с таким названием. Он создан, чтобы ваш UI выглядел, как задумано, с четкими текстурами и лучшим масштабированием. Конечно, по желанию вы можете отключить этот режим в настройках."
	GwLocalization["WORLD_MARKER_DESC"] = "Отображать панель с метками цели пока вы в рейде."
	GwLocalization["TOPLEFT"] = ("%s %s"):format(GwLocalization["TOP"], GwLocalization["LEFT"])
	GwLocalization["TOPRIGHT"] = ("%s %s"):format(GwLocalization["TOP"], GwLocalization["RIGHT"])
	GwLocalization["BOTTOMLEFT"] = ("%s %s"):format(GwLocalization["BOTTOM"], GwLocalization["LEFT"])
	GwLocalization["BOTTOMRIGHT"] = ("%s %s"):format(GwLocalization["BOTTOM"], GwLocalization["RIGHT"])
	GwLocalization["STANCEBAR_POSITION"] = "Position of the Stancebar"
	GwLocalization["STANCEBAR_POSITION_DESC"] = "Set the position of the Stancebar (Left or Right from the main Actionbar)"
	GwLocalization["CURSOR_ANCHOR_TYPE"] = "Cursor Anchor Type"
	GwLocalization["CURSOR_ANCHOR_TYPE_DESC"] = "Take only effect if the option 'Cursor Tooltips' is activated"
	GwLocalization["CURSOR_ANCHOR"] = "Cursor Anchor"
	GwLocalization["ANCHOR_CURSOR_LEFT"] = "Cursor Anchor left"
	GwLocalization["ANCHOR_CURSOR_RIGHT"] = "Cursor Anchor right"
	GwLocalization["ANCHOR_CURSOR_OFFSET_X"] = "Cursor Anchor Offset X"
	GwLocalization["ANCHOR_CURSOR_OFFSET_Y"] = "Cursor Anchor Offset Y"
	GwLocalization["ANCHOR_CURSOR_OFFSET_DESC"] = "Take only effect if the option 'Cursor Tooltips' is activated and the Cursoer Anchor is NOT 'Cursor Anchor'"
	GwLocalization["MOUSE_OVER"] = "Only Mouse over"
	GwLocalization["PLAYER_AURA_GROW"] = "Set Player Aura grow directions"
	GwLocalization["RED_OVERLAY"] = "Red overlay"
	GwLocalization["MAINBAR_RANGE_INDICATOR"] = "Mainbar range indicator"
end


if GetLocale() == "ruRU" then
	GWUseThisLocalization()
end

-- After using this localization or deciding that we don"t need it, remove it from memory.
GWUseThisLocalization = nil

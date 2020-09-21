-- ptBR localization
local _, GW = ...

local function GWUseThisLocalization()
    local L = GW.L
    
    --Fonts
    L["FONT_NORMAL"] = "Interface/AddOns/GW2_UI/fonts/menomonia.ttf"
    L["FONT_BOLD"] = "Interface/AddOns/GW2_UI/fonts/headlines.ttf"
    L["FONT_NARROW"] = "Interface/AddOns/GW2_UI/fonts/menomonia.ttf"
    L["FONT_NARROW_BOLD"] = "Interface/AddOns/GW2_UI/fonts/menomonia.ttf"
    L["FONT_LIGHT"] = "Interface/AddOns/GW2_UI/fonts/menomonia-italic.ttf"
    L["FONT_DAMAGE"] = "Interface/AddOns/GW2_UI/fonts/headlines.ttf"
    
    --Strings
    L["ACTION_BAR_FADE"] = "Ocultar Barra de Ações"
    L["ACTION_BAR_FADE_DESC"] = "Ocultar Barras de Ações adicionais quando fora de combate."
    L["ACTION_BARS_DESC"] = "Usar as Barras de Ações melhoradas pelo GW2 ui"
    L["ADV_CAST_BAR"] = "Barra de Conjuração Avançada"
    L["ADV_CAST_BAR_DESC"] = "Habilitar ou Desabilitar a Barra de Conjuração Avançada"
    L["ADVANCED_TOOLTIP"] = "Descrições Avançadas"
    L["ADVANCED_TOOLTIP_DESC"] = "Exibe informações adicionais na descrição (mais informação é mostrada ao pressionar a tecla SHIFT)"
    L["ADVANCED_TOOLTIP_NPC_ID"] = "IDs dos PNJs"
    L["ADVANCED_TOOLTIP_NPC_ID_DESC"] = "Mostra o ID de um PNJ quando o mouse passa sobre a descrição."
    L["ADVANCED_TOOLTIP_OPTION_ITEMCOUNT"] = "Contagem de Itens"
    L["ADVANCED_TOOLTIP_OPTION_ITEMCOUNT_DESC"] = "Mostra quantos de um certo item você tem em sua posse."
    L["ADVANCED_TOOLTIP_SHOW_GUILD_RANKS"] = "Postos de Guilda"
    L["ADVANCED_TOOLTIP_SHOW_GUILD_RANKS_DESC"] = "Mostra o posto da guilda se a unidade estiver em uma."
    L["ADVANCED_TOOLTIP_SHOW_MOUNT"] = "Montaria Atual"
    L["ADVANCED_TOOLTIP_SHOW_MOUNT_DESC"] = "Mostra a montaria que a unidade está usando agora."
    L["ADVANCED_TOOLTIP_SHOW_PLAYER_TITLES_DESC"] = "Mostra títulos dos jogadores."
    L["ADVANCED_TOOLTIP_SHOW_REALM_ALWAYS"] = "Sempre exibir Reino"
    L["ADVANCED_TOOLTIP_SHOW_ROLE_DESC"] = "Mostra a função da unidade na descrição."
    L["ADVANCED_TOOLTIP_SHOW_TARGET_INFO"] = "Informação do Alvo"
    L["ADVANCED_TOOLTIP_SHOW_TARGET_INFO_DESC"] = "Quando estiver em um grupo de raide, mostra se alguém na sua raide tem a unidade atualmente mostrada na descrição como alvo."
    L["ADVANCED_TOOLTIP_SPELL_ITEM_ID"] = "IDs dos Feitiços/Itens"
    L["ADVANCED_TOOLTIP_SPELL_ITEM_ID_DESC"] = "Mostra o ID do feitiço ou item quando o mouse estiver sobre a descrição de um feitiço ou item."
    L["AFK_MODE"] = "Modo AFK"
    L["AFK_MODE_DESC"] = "Quando você vai ao AFK, exibe a tela AFK."
    L["ALL_BINDINGS_DISCARD"] = "Todas as novas teclas de atalho escolhidas foram descartadas."
    L["ALL_BINDINGS_SAVE"] = "Todos os atalhos de teclas foram salvos."
    L["AMOUNT_LOAD_ERROR"] = "Quantidade não pôde ser carregada"
    L["ANCHOR_CURSOR_LEFT"] = "Ancorar à Esquerda do Cursor"
    L["ANCHOR_CURSOR_OFFSET_DESC"] = "Funciona apenas se a opção \"Descrições sobre o Cursos\" estiver ativada e a Âncora do Cursor NÃO estiver em 'Ancorar no Cursor'."
    L["ANCHOR_CURSOR_OFFSET_X"] = "Deslocamento da Âncora do Cursor em X"
    L["ANCHOR_CURSOR_OFFSET_Y"] = "Deslocamento da Âncora do Cursor em Y"
    L["ANCHOR_CURSOR_RIGHT"] = "Ancorar à Direita do Cursor"
    L["AURA_STYLE"] = "Estilo de Aura"
    L["AURAS_PER_ROW"] = "Auras por Linha"
    L["BAG_NEW_ORDER_FIRST"] = "Novos itens para primeira mochila"
    L["BAG_NEW_ORDER_LAST"] = "Novos itens para última mochila"
    L["BAG_ORDER_NORMAL"] = "Ordenação Normal de Mochilas"
    L["BAG_ORDER_REVERSE"] = "Ordenação de Mochilas Reversa"
    L["BAG_SORT_ORDER_FIRST"] = "Organizar para a Primeira Mochila"
    L["BAG_SORT_ORDER_LAST"] = "Organizar para a Última Mochila"
    L["BANK_COMPACT_ICONS"] = "Ícones Compactos"
    L["BANK_EXPAND_ICONS"] = "Ícones Grandes"
    L["BINDINGS_DESC"] = "Passe o mouse sobre qualquer botão de ação para vinculá-lo. Pressione a tecla de escape ou clique com o botão direito para limpar a tecla de atalho do botão de ação atual."
    L["BINDINGS_TRIGGER"] = "Gatilho"
    L["BINGSINGS_BIND"] = "associada a"
    L["BINGSINGS_CLEAR"] = "Todas as teclas atalho removidas para"
    L["BINGSINGS_KEY"] = "Tecla"
    L["BOTTOM"] = "debaixo"
    L["BUTTON_ASSIGNMENTS"] = "Atribuições dos Botões de Ação"
    L["BUTTON_ASSIGNMENTS_DESC"] = "Habilitar ou Desabilitar as atribuições dos Botões de Ação"
    L["CASTING_BAR_DESC"] = "Habilitar a Barra de Conjuração estilo GW2"
    L["CENTER"] = "centro"
    L["CHANGELOG"] = "Lista de alterações"
    L["CHARACTER_NEXT_RANK"] = "PRÓXIMO"
    L["CHARACTER_PARAGON"] = "Paragon"
    L["CHAT_BUBBLES_DESC"] = "Substituir os Balões de conversa da UI padrão (Only in not protected areas)"
    L["CHAT_FADE"] = "Ocultar conversa"
    L["CHAT_FADE_DESC"] = "Permitir que a conversa seja ocultada quando não estiver em uso."
    L["CHAT_FRAME_DESC"] = "Habilitar janela de conversa aprimorada."
    L["CHRACTER_WINDOW_DESC"] = "Substituir a janela de personagem padrão."
    L["CLASS_COLOR_DESC"] = "Mostrar a cor da classe como barra de vida."
    L["CLASS_COLOR_RAID_DESC"] = "Usar a cor da classe em vez dos ícones das classes."
    L["CLASS_POWER"] = "Recurso da Classe"
    L["CLASS_POWER_DESC"] = "Habilitar os recursos de classe alternativos."
    L["COMPACT_ICONS"] = "Ícones Compactos"
    L["COMPASS_TOGGLE"] = "Habilitar Bússola"
    L["COMPASS_TOGGLE_DESC"] = "Habilitar ou desabilitar a bússola do rastreador de missões."
    L["CURSOR_ANCHOR"] = "Ancorar no Cursor"
    L["CURSOR_ANCHOR_TYPE"] = "Tipo de Âncora no Cursor"
    L["CURSOR_ANCHOR_TYPE_DESC"] = "Funciona apenas se a opção \"Descrições no Cursor\" estiver ativa."
    L["DEBUFF_DISPELL_DESC"] = "Mostra apenas os efeitos negativos que você é capaz de remover."
    L["DISABLED_MA_BAGS"] = "Disabilitada a interação com mochilas do MoveAnything"
    L["DISCORD"] = "Entre no Discord"
    L["DOWN"] = "por baixo"
    L["DOWN_AND_RIGHT"] = "Abaixo e à Direita"
    L["DYNAMIC_HUD"] = "Interface dinâmica"
    L["DYNAMIC_HUD_DESC"] = "Habilitar ou desabilitar interface de fundo que se ajusta dinamicamente."
    L["EXP_BAR_TOOLTIP_EXP_RESTED"] = "Descansado "
    L["EXP_BAR_TOOLTIP_EXP_RESTING"] = " (Descansando)"
    L["EXPAND_ICONS"] = "Ícones Grandes"
    L["FADE_MICROMENU"] = "Esconder o Menu-barra"
    L["FADE_MICROMENU_DESC"] = "Esconder o micro-menu principal quando o cursor não estiver próximo."
    L["FOCUS_DESC"] = "Modificar as configurações da unidade do foco."
    L["FOCUS_FRAME_DESC"] = "Habilitar a substituição da unidade do alvo do foco."
    L["FOCUS_TARGET_DESC"] = "Mostrar a unidade do alvo do foco."
    L["FOCUS_TOOLTIP"] = "Editar as configurações da unidade do foco."
    L["FONTS"] = "Fontes"
    L["FONTS_DESC"] = "Substituir as fontes padrão pelas fontes do GW2 UI."
    L["GRID_BUTTON_HIDE"] = "Ocultar grade"
    L["GRID_BUTTON_SHOW"] = "Mostrar grade"
    L["GRID_SIZE_LABLE"] = "Tamanho da Grade:"
    L["GROUND_MARKER"] = "MM"
    L["GROUP_DESC"] = "Edite as opções de grupo e raide para se adaptar às suas necessidades."
    L["GROUP_FRAMES"] = "Unidades do Grupo"
    L["GROUP_FRAMES_DESC"] = "Substituir as unidades de grupo da interface padrão."
    L["GROUP_TOOLTIP"] = "Editar as configurações de grupo."
    L["HEALTH_GLOBE"] = "Globo de Vida"
    L["HEALTH_GLOBE_DESC"] = "Habilitar a substituição da barra de vida."
    L["HEALTH_PERCENTAGE_DESC"] = "Mostrar a vida como porcentagem. Pode substituir ou ser usada junto com o Valor de Vida."
    L["HEALTH_VALUE_DESC"] = "Mostrar vida como um valor numérico."
    L["HIDE_EMPTY_SLOTS"] = "Ocultar Espaços Vazios"
    L["HIDE_EMPTY_SLOTS_DESC"] = "Ocultar os espaços vazios das barras de ações."
    L["HIDE_SETTING_IN_COMBAT"] = "Configurações não ficam disponíveis em combate!"
    L["HUD_DESC"] = "Edite os módulos da Interface para maior customização."
    L["HUD_MOVE_ERR"] = "Você não pode mover elementos durante o combate!"
    L["HUD_SCALE"] = "Escala da Interface"
    L["HUD_SCALE_DESC"] = "Mudar o tamanho da Interface."
    L["HUD_SCALE_TINY"] = "Minúscula"
    L["HUD_TOOLTIP"] = "Editar os módulos da Interface."
    L["INDICATOR_BAR"] = "barra de progresso"
    L["INDICATOR_DESC"] = "Alterar o indicador %s de auras de raid."
    L["INDICATOR_TITLE"] = "Indicador %s"
    L["INDICATORS"] = "Indicadores de Raid"
    L["INDICATORS_DESC"] = "Alterar indicadores de auras de raid."
    L["INDICATORS_ICON"] = "Mostrar o ícone de feitiço"
    L["INDICATORS_ICON_DESC"] = "Mostrar os ícones de feitiço invés de quadrados monocromáticos."
    L["INDICATORS_TIME"] = "Mostrar o tempo restante."
    L["INDICATORS_TIME_DESC"] = "Mostrar o tempo restante das auras com uma sobreposição animada."
    L["INVENTORY_FRAME_DESC"] = "Habilitar a interface de inventário unificado."
    L["LEFT"] = "esquerda"
    L["LEVEL_REWARDS"] = "Recompensas dos Próximos Níveis"
    L["MAINBAR_RANGE_INDICATOR"] = "Indicador de Alcance da Barra Principal"
    L["MAP_CLOCK_LOCAL_REALM"] = "Shift+Clique para alternar entre horário Local ou do Servidor"
    L["MAP_CLOCK_MILITARY"] = "Clique com Botão Esquerdo para habilitar horário em formato militar"
    L["MAP_CLOCK_STOPWATCH"] = "Clique com Botão Direito para abrir o Cronômetro"
    L["MAP_CLOCK_TIMEMANAGER"] = "Shift-Botão Direito para abrir o Time Manager"
    L["MAP_COORDINATES_TITLE"] = "Coordenadas do mapa"
    L["MAP_COORDINATES_TOGGLE_TEXT"] = "Clique esquerdo para alternar as coordenadas de precisão mais alta."
    L["MINIMAP_COORDS"] = "Coordenadas"
    L["MINIMAP_DESC"] = "Usar a unidade de Minimapa do GW2 UI"
    L["MINIMAP_FPS"] = "Mostrar FPS no mini mapa"
    L["MINIMAP_HOVER"] = "Detalhes do Minimapa"
    L["MINIMAP_HOVER_TOOLTIP"] = "Sempre mostrar detalhes do Minimapa."
    L["MINIMAP_POS"] = "Posição do mini-mapa"
    L["MINIMAP_SCALE"] = "Escala do Minimapa"
    L["MINIMAP_SCALE_DESC"] = "Alterar o tamanho do Minimapa."
    L["MODULES_CAT"] = "MÓDULOS"
    L["MODULES_CAT_1"] = "Módulos"
    L["MODULES_CAT_TOOLTIP"] = "Habilitar e desabilitar componentes"
    L["MODULES_DESC"] = "Habilite ou desabilite os módulos que você precisa ou não precisa."
    L["MODULES_TOOLTIP"] = "Habilitar ou desabilitar módulos da Interface."
    L["MOUSE_OVER"] = "Somente com Mouse Sobreposto"
    L["MOUSE_TOOLTIP"] = "Informações Adicionais do Cursor"
    L["MOUSE_TOOLTIP_DESC"] = "Ancorar as informações adicionais ao cursor."
    L["MOVE_HUD_BUTTON"] = "Mover Interface"
    L["NAME_LOAD_ERROR"] = "Nome não pôde ser carregado"
    L["NO_GUILD"] = "Sem Guilda"
    L["NOT_A_LEGENDARY"] = "Você não pode aprimorar aquele item."
    L["PET_BAR_DESC"] = "Usar a barra de Pet aprimorada do GW2 UI."
    L["PIXEL_PERFECTION"] = "Modo Pixel Perfection"
    L["PIXEL_PERFECTION_DESC"] = "Redimensiona o UI para o modo Pixel Perfection. Dependerá da resolução da tela."
    L["PIXEL_PERFECTION_OFF"] = "Desactivar Pixel Perfection"
    L["PIXEL_PERFECTION_ON"] = "Activar Pixel Perfection"
    L["PLAYER_ABSORB_VALUE_TEXT"] = "Mostra Valor do Escudo"
    L["PLAYER_BUFFS_GROW"] = "Direção da Distribuição das Buffs do Jogador"
    L["PLAYER_DEBUFFS_GROW"] = "PDireção da Distribuição das Debuffs do Jogador"
    L["PLAYER_AURAS_DESC"] = "Mover e redimensionar as auras dos jogadores."
    L["PLAYER_DESC"] = "Modificar as configurações do quadro do jogador."
    L["POWER_BARS_RAID_DESC"] = "Exibe as barras de recursos nas unidades da raide."
    L["PROFESSION_BAG_COLOR"] = "Cores para bolsas de profissões"
    L["PROFILES_CAT"] = "PERFIS"
    L["PROFILES_CAT_1"] = "Perfis"
    L["PROFILES_CREATED"] = "Criado: "
    L["PROFILES_CREATED_BY"] = "\nCriado por: "
    L["PROFILES_DEFAULT_SETTINGS"] = "Configurações Padrão"
    L["PROFILES_DEFAULT_SETTINGS_DESC"] = "Carregar as configurações padrão do addon no perfil atual."
    L["PROFILES_DEFAULT_SETTINGS_PROMPT"] = "Tem certeza que deseja carregar as configurações padrão? Todas as configurações anteriores serão perdidas."
    L["PROFILES_DELETE"] = "Tem certeza que deseja deletar este perfil?"
    L["PROFILES_DESC"] = "Perfis são uma forma fácil de compartilhas suas configurações entre personagens e reinos."
    L["PROFILES_LAST_UPDATE"] = "\nÚltima atualização:"
    L["PROFILES_LOAD_BUTTON"] = "Carregar"
    L["PROFILES_MISSING_LOAD"] = "Se você vê esta mensagem, é porque esquecemos de carregar algum texto. Não se preocupe, nós temos bastante texto de amostra como este para mantê-lo informado."
    L["PROFILES_TOOLTIP"] = "Adicione e remova perfis."
    L["QUEST_REQUIRED_ITEMS"] = "Itens Necessários:"
    L["QUEST_TRACKER_DESC"] = "Habilitar o rastreador de missões remodelado e aprimorado."
    L["QUEST_VIEW_SKIP"] = "Pular"
    L["QUESTING_FRAME"] = "Missões Imersivas"
    L["QUESTING_FRAME_DESC"] = "Habilitar o modo de Missões Imersivas."
    L["RAID_ANCHOR"] = "Definir fixador da Raide"
    L["RAID_ANCHOR_BY_GROWTH"] = "Por direção de crescimento"
    L["RAID_ANCHOR_BY_POSITION"] = "Por posição na tela"
    L["RAID_ANCHOR_DESC"] = "Defina onde o quadro da raide deve ser fixado. Por posição: sempre o mesmo que a posição do quadro na tela.\nPor crescimento: sempre oposto à direção de crescimento."
    L["RAID_AURA_TOOLTIP_IN_COMBAT"] = "Mostrar as dicas da aura em combate"
    L["RAID_AURA_TOOLTIP_IN_COMBAT_DESC"] = "Mostrar dicas dos buffs e debuffs mesmo quando está em combate."
    L["RAID_AURAS"] = "Auras da Raide"
    L["RAID_AURAS_DESC"] = "Altere quais os buffs e debuffs são mostradas."
    L["RAID_AURAS_IGNORED"] = "Auras Ignoradas"
    L["RAID_AURAS_IGNORED_DESC"] = "Lista de auras que não devem ser mostradas."
    L["RAID_AURAS_MISSING"] = "Buffs em falta."
    L["RAID_AURAS_MISSING_DESC"] = "Lista de buffs que só serão mostrados quando estão em falta."
    L["RAID_AURAS_TOOLTIP"] = "Mostrar ou esconder auras e alterar os indicadores de auras da raid."
    L["RAID_BAR_HEIGHT"] = "Ajustar a Altura das Unidades de Raide"
    L["RAID_BAR_HEIGHT_DESC"] = "Ajustar a altura das unidades de raide."
    L["RAID_BAR_WIDTH"] = "Ajustar a Largura das Unidades de Raide"
    L["RAID_BAR_WIDTH_DESC"] = "Ajustar a largura das unidades de raide."
    L["RAID_CONT_HEIGHT"] = "Ajustar a Altura do Quadro da Raide"
    L["RAID_CONT_HEIGHT_DESC"] = "Ajuste a altura máxima com que as unidades de raide podem ser exibidas."
    L["RAID_CONT_WIDTH"] = "Ajustar comprimento do Quadro da Raide"
    L["RAID_CONT_WIDTH_DESC"] = "Defina a largura máxima que os quadros da raide podem ser exibidos. Isso fará com que os quadros encolham ou passem para a próxima linha."
    L["RAID_GROW"] = "Ajustar a direção do crescimento da Raide"
    L["RAID_GROW_DESC"] = "Ajustar a direção do crescimento dos quadros da Raide."
    L["RAID_GROW_DIR"] = "%s e depois %s"
    L["RAID_MARKER_DESC"] = "Mostra os Marcadores Alvo nas Unidades da Raide"
    L["RAID_PARTY_STYLE_DESC"] = "Configura as unidades do grupo como unidades de raide."
    L["RAID_PREVIEW"] = "Pré-visualizar os quadros da raide"
    L["RAID_PREVIEW_DESC"] = "Clique para alternar a visualização do quadro da raide e percorra os diferentes tamanhos de grupos."
    L["RAID_SORT_BY_ROLE"] = "Ordenar quadros de raid por função"
    L["RAID_SORT_BY_ROLE_DESC"] = "Ordenar quadros de raid por função (tank, heal, dano) invés de por grupo."
    L["RAID_UNIT_FLAGS"] = "Mostrar bandeira do país"
    L["RAID_UNIT_FLAGS_2"] = "Diferentes do seu próprio"
    L["RAID_UNIT_FLAGS_TOOLTIP"] = "Mostrar a bandeira do país baseado no idioma da unidade"
    L["RAID_UNIT_LOST_HEALTH_PREC"] = "Percentagem restante de vida"
    L["RAID_UNITS_PER_COLUMN"] = "Ajustar unidades da raid por coluna"
    L["RAID_UNITS_PER_COLUMN_DESC"] = "Ajustar o numero de unidades da raide por coluna ou linha, dependendo da direção de crescimento."
    L["RED_OVERLAY"] = "Realce Vermelho"
    L["RESOURCE_DESC"] = "Substitui a barra de recurso/mana padrão."
    L["RIGHT"] = "Direita"
    L["SECURE"] = "Sem sobreposição"
    L["SELLING_JUNK"] = "Vendendo Tralha"
    L["SELLING_JUNK_FOR"] = "Tralha Vendida por: %s"
    L["SETTING_LOCK_HUD"] = "Travar Interface"
    L["SETTINGS_BUTTON"] = "Configurações do GW2 UI"
    L["SETTINGS_NO_LOAD_ERROR"] = "Algum texto não foi carregado, por favor tente recarregar a interface."
    L["SETTINGS_RESET_TO_DEFAULT"] = "Resetar para o Padrão."
    L["SETTINGS_SAVE_RELOAD"] = "Salvar e Recarregar"
    L["SHOW_ALL_DEBUFFS_DESC"] = "Mostrar todos os efeitos negativos no alvo."
    L["SHOW_BUFFS_DESC"] = "Mostrar os efeitos positivos no alvo."
    L["SHOW_DEBUFFS_DESC"] = "Mostrar os efeitos negativos no alvo que foram causados por você."
    L["SHOW_ILVL"] = "Mostrar a média do item level"
    L["SHOW_ILVL_DESC"] = "Mostrar a média do nível de item invés do nível de prestigio para unidades amigáveis."
    L["SHOW_JUNK_ICON"] = "Mostrar Ícone de Tralha"
    L["SHOW_QUALITY_COLOR"] = "Mostrar Cores de Qualidade"
    L["SHOW_SCRAP_ICON"] = "Mostrar Ícone de Sucata"
    L["SHOW_THREAT_VALUE"] = "Mostrar nível de ameaça"
    L["SHOW_UPGRADE_ICON"] = "Mostrar Ícone de Melhoria"
    L["STANCEBAR_POSITION"] = "Posição da Barra de Posturas"
    L["STANCEBAR_POSITION_DESC"] = "Define a posição da barra de posturas (esquerda ou direita a partir da barra de ação principal)."
    L["STG_RIGHT_BAR_COLS"] = "Largura da barra direita"
    L["STG_RIGHT_BAR_COLS_DESC"] = "Número de colunas nas duas barras de ação extras da direita. "
    L["TALENTS_BUTTON_DESC"] = "Habilitar substituição de talentos, especialização e livro de magias."
    L["TARGET_COMBOPOINTS"] = "Mostrar pontos de combo no alvo"
    L["TARGET_COMBOPOINTS_DEC"] = "Mostrar pontos de combo no alvo, debaixo da barra de vida"
    L["TARGET_DESC"] = "Modificar as configurações da unidade do alvo."
    L["TARGET_FRAME_DESC"] = "Habilitar a substituição da unidade do alvo."
    L["TARGET_OF_TARGET_DESC"] = "Habilitar a unidade do alvo do alvo."
    L["TARGET_TOOLTIP"] = "Editar as configurações da unidade do alvo."
    L["TARGETED_BY"] = "Alvejado por:"
    L["TOOLTIPS"] = "Descrições"
    L["TOOLTIPS_DESC"] = "Substituir as descrições da Interface padrão."
    L["TOP"] = "Topo"
    L["TRACKER_RETRIVE_CORPSE"] = "Retorne ao seu corpo"
    L["UNEQUIP_LEGENDARY"] = "Você precisar desequipar aquele item para poder aprimorá-lo."
    L["UP"] = "por cima"
    L["UP_AND_RIGHT"] = "Acima e à Direita"
    L["UPDATE_STRING_1"] = "Nova atualização disponível para download."
    L["UPDATE_STRING_2"] = "Nova atualização disponível com características novas."
    L["UPDATE_STRING_3"] = "Uma atualização |cFFFF0000maior|r está disponível. É altamente recomendado que você atualize."
    L["VENDOR_GRAYS"] = "Vender Tralha automaticamente"
    L["WELCOME"] = "Bem vindo "
    L["WELCOME_SPLASH_HEADER"] = "Bem vindo ao GW2 UI"
    L["WELCOME_SPLASH_WELCOME_TEXT"] = "GW2 UI é uma substituição completa da interface do usuário. Criamos a interface do usuário com uma abordagem modular, isso significa que, se você não gosta de uma certa parte do complemento - ou tem outra que prefere para essa função - você pode simplesmente desativar essa parte, mantendo o restante da interface intacta.\nAlguns dos módulos disponíveis para você são uma janela imersiva de missões, uma substituição completa do inventário e uma substituição completa da janela de personagem. Você pode desfrutar de muito mais, basta dar uma olhada no menu de configurações para ver o que está disponível para você!"
    L["WELCOME_SPLASH_WELCOME_TEXT_PP"] = "O que é 'Pixel Perfection'?\n\nA GW2 UI possui uma configuração interna chamada 'Modo Pixel Perfection'. O que isso significa para você é que a interface do usuário terá a aparência desejada, com texturas mais nítidas e melhor escala. Obviamente, você pode desativar isso no menu de configurações, se preferir."
    L["WORLD_MARKER_DESC"] = "Mostrar menu para colocar marcadores quando está em raide."
    L["REPAIRD_FOR"] = "Seus itens foram reparadas por: %s"
    L["REPAIRD_FOR_GUILD"] = "Seus itens foram reparados usando fundos do banco da guilda por: %s"
    L["AUTO_REPAIR"] = "Reparar automaticamente"
    L["AUTO_REPAIR_DESC"] = "Reparar automaticamente usando o seguinte método ao visitar um vendedor."
    L["FADE_GROUP_MANAGE_FRAME"] = "Fade Group Manage Button"
    L["FADE_GROUP_MANAGE_FRAME_DESC"] = "Fade the Group Manage Button when the mouse is not near."
    L["HUD_BACKGROUND"] = "Show HUD background"
    L["HUD_BACKGROUND_DESC"] = "The HUD background changes color in the following situations: In Combat, Not In Combat, In Water, Low HP, Ghost"
    L["RAID_SHOW_IMPORTEND_RAID_DEBUFFS"] = "Dungeon & Raid Debuffs"
    L["RAID_SHOW_IMPORTEND_RAID_DEBUFFS_DESC"] = "Show importent Dungeon & Raid debuffs"
    L["ALERTFRAMES"] = "Alertas"
    L["PLAYER_GROUP_FRAME"] = "Playerframe in group"
    L["PLAYER_GROUP_FRAME_DESC"] = "Show Player as Groupframe"
    L["PLAYER_BUFF_SIZE"] = "Buff size"
    L["PLAYER_DEBUFF_SIZE"] = "Debuff size"
    L["ASCENDING"] = "Ascending"
    L["DESCENDING"] = "Descending"
    L["CLASS_TOTEMS"] = "Class Totems"
    L["TOTEMBAR_GROW_DIRECTION"] = "Class Totmes grow direction"
    L["TOTEMBAR_SORTING"] = "Class Totmes sorting"
    L["HORIZONTAL"] = "Horizontal"
    L["VERTICAL"] = "Vertical"
    L["DISPLAY_PORTRAIT_DAMAGED"] = "Mostrar dano no retrato"
    L["DISPLAY_PORTRAIT_DAMAGED_DESC"] = "Mostrar dano no retrato neste quadro"
    L["IMPORT"] = "Import"
    L["DECODE"] = "Decode"
    L["IMPORT_SUCCESSFUL"] = "Import string succsessfully imported!"
    L["IMPORT_FAILED"] = "Error importing profile: Invalid or corrupted string!"
    L["IMPORT_DECODE_FALIED"] = "Error decoding profile: Invalid or corrupted string!"
    L["IMPORT_DECODE:SUCCESSFUL"] = "Import string succsessfully decoded!"
    L["EXPORT_PROFILE"] = "Export Profile"
    L["EXPORT_PROFILE_DESC"] = "Profile string to share your settings:"
    L["IMPORT_PROFILE"] = "Import Profile"
    L["IMPORT_PROFILE_DESC"] = "Past your profile string here, to import the profile."
    L["IMPORT_POFILE_BUTTON"] = "Import Profile"
    L["EXPORT"] = "Export"
    L["SMALL_SETTINGS_DEFAULT_DESC"] = "Right click on a moverframe to show extra frame options"
    L["SMALL_SETTINGS_NO_SETTINGS_FOR"] = "No extra frame settings for '%s'"
    L["SMALL_SETTINGS_HEADER"] = "Extra frame options"
    L["SMALL_SETTINGS_OPTION_SCALE"] = "Scale"
    L["INSTALL_START_HEADER"] = "Installation process"
    L["INSTALL_DESCRIPTION_HEADER"] = "GW2_UI installation process"
    L["INSTALL_DESCRIPTION_DSC"] = "This short installation process, will help you to set up all neccessary settings which are used from GW2_UI"
    L["INSTALL_START_BTN"] = "Start installation process"
    L["INSTALL_CHAT_DESC"] = "This part sets up your chat windows names, positions and colors."
    L["INSTALL_CHAT_BTN"] = "Setup Chat"
    L["INSTALL_CVARS_DESC"] = "This part sets up your World of Warcraft default options."
    L["INSTALL_CVARS_BTN"] = "Setup CVars"
    L["INSTALL_UISCALE_DESC"] = "Adjust the UI Scale to fit your screen, press the autoscale button to set the UI Scale automatically."
    L["INSTALL_UISCALE_BTN"] = "Auto Scale"
    L["INSTALL_FINISHED_HEADER"] = "Installation done"
    L["INSTALL_FINISHED_DESC"] = "You are now finished with the installation process."
    L["INSTALL_FINISHED_BTN"] = "Finished"

    --Composite
    L["TOPLEFT"] = ("%s %s"):format(L["TOP"], L["LEFT"])
    L["TOPRIGHT"] = ("%s %s"):format(L["TOP"], L["RIGHT"])
    L["BOTTOMLEFT"] = ("%s %s"):format(L["BOTTOM"], L["LEFT"])
    L["BOTTOMRIGHT"] = ("%s %s"):format(L["BOTTOM"], L["RIGHT"])
end

if GetLocale() == "ptBR" then
    GWUseThisLocalization()
end

-- After using this localization or deciding that we don"t need it, remove it from memory.
GWUseThisLocalization = nil
return {
  {
    'codethread/qmk.nvim',
    ft = 'dts',
    ---@type qmk.UserConfig
    opts = {
      name = 'corneo',
      variant = 'zmk',
      auto_format_pattern = '*.keymap',
      comment_preview = {
        keymap_overrides = {
          ['&none'] = '∅',
          ['&trans'] = '',
          ['&sys_reset'] = '🔄',
          ['&bootloader'] = '💾',
          ['&studio_unlock'] = '🔓',
          ['&caps_word'] = '⇪',
          PRINTSCREEN = '🖨️',
          BT_NXT = '🛜🔼',
          BT_PRV = '🛜🔽',
          BT_CLR = '🛜❌',
          BT_SEL = '🛜',
          C_MUTE = '🔇',
          C_VOL_DN = '🔉',
          C_VOL_UP = '🔊',
          C_BRI_UP = '🔆',
          C_BRI_DN = '🔅',
          EP_TOG = '🔌',
          AMPS = '&',
          STAR = '*',
          LPAR = '(',
          RPAR = ')',
          MEH = 'MEH',
          HYPER = 'HYPER',
          TAB = '⇥',
          RET = '⏎',
          RSHIFT = '⇧',
          LSHIFT = '⇧',
          LG = '⌘',
          RG = '⌘',
          LC = '⌃',
          RC = '⌃',
          LA = '⌥',
          RA = '⌥',
          ['COPY'] = '📄',
          ['PASTE'] = '📋',
          ['CUT'] = '✂️',
          SPACE = '␣',
          BSPC = '⌫',
          DEL = '⌦',
          ESC = '⎋',
          LALT = '⌥',
          RALT = '⌥',
          -- use MENU as compose key
          K_CMENU = '🌍',
          K_MENU = '🌍',
          COMPOSE = '🌍',
          LEFT = '←',
          RIGHT = '→',
          UP = '↑',
          DOWN = '↓',
          KP_PLUS = '+',
          DQT = '"',
          PG_UP = '⇞',
          PG_DN = '⇟',
          HOME = '⇱',
          END = '⇲',

          -- mouse stuff
          MB1 = '🖱️L',
          MB2 = '🖱️R',
          MB3 = '🖱️M',
          MB4 = '🖱️B4',
          MB5 = '🖱️F5',
          MOVE_X = '🖱️↔️', -- or 'X' or '➡️⬅️'
          MOVE_Y = '🖱️↕️', -- or 'Y' or '⬆️⬇️'
          MOUSE_MOVE_GEAR1_VAL = '1',
          MOUSE_MOVE_GEAR2_VAL = '2',
          MOUSE_MOVE_GEAR3_VAL = '3',
          MOUSE_MOVE_GEAR4_VAL = '4',
          MOUSE_SCROLL_GEAR1_VAL = '1',
          MOUSE_SCROLL_GEAR2_VAL = '2',
          MOUSE_SCROLL_GEAR3_VAL = '3',
          MOUSE_SCROLL_GEAR4_VAL = '4',
        },
      },
      layout = {
        'x x x x x x _ _ x x x x x x',
        'x x x x x x _ _ x x x x x x',
        'x x x x x x _ _ x x x x x x',
        '_ _ _ x x x _ _ x x x _ _ _',
      },
    },
    config = function(_, opts)
      ---@param keymap qmk.KeymapList
      package.loaded['qmk.format.get_key_text'] = function(keymap)
        ---@type table<string, string>
        local mapped = {}
        for _, k in ipairs(keymap) do
          mapped[k.key] = k.value
        end
        for _, v in ipairs { 'GUI', 'ALT', 'CTRL', 'SHIFT' } do
          mapped['R' .. v] = 'R' .. v
          mapped['L' .. v] = 'L' .. v
        end
        return function(key)
          local parts = vim.split(key, ' ')
          if vim.tbl_contains({ '&kp', '&bt', '&ext_power', '&msc', '&mmv', '&mkp' }, parts[1]) then
            table.remove(parts, 1)
          end
          for i, part in ipairs(parts) do
            part = mapped[part] or mapped['KC_' .. part] or part
            part = part:gsub('^N(%d)$', '%1')
            if part:find '&' ~= 1 then
              part = part:upper()
            end
            parts[i] = part
          end
          return table.concat(parts, ' ')
        end
      end

      require('qmk').setup(opts)
    end,
  },
}

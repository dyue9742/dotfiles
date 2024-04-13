local CR = '<CR>'

vim.keymap.set('i', '<C-x>o', '<Esc>O')

vim.keymap.set('n', '[b', ':bprevious' .. CR)
vim.keymap.set('n', ']b', ':bnext' .. CR)
vim.keymap.set('n', '<C-x>b', ':bdelete' .. CR)

vim.keymap.set('n', '<C-j>', ':cprevious' .. CR)
vim.keymap.set('n', '<C-k>', ':cnext' .. CR)

vim.keymap.set('n', 'ga', ':EasyAlign' .. CR) -- in visual mode, vipga=
vim.keymap.set('n', 'ga', ':EasyAlign' .. CR) -- for a motion/text object, gaip=

vim.keymap.set('n', '<Leader>f', ':call fzf#run({"sink": "e", "window": "60vnew"})' .. CR)

--[[
RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
INITIAL_QUERY="${*:-}"
: | fzf --ansi --disabled --query "$INITIAL_QUERY" \
    --bind "start:reload:$RG_PREFIX {q}" \
    --bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
    --delimiter : \
    --preview 'bat --color=always {1} --highlight-line {2}' \
    --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
    --bind 'enter:become(vim {1} +{2})'

local function rg()
end
vim.keymap.set('n', '<Leader>F', '')
--]]

vim.keymap.set('n', '<Leader>p', ':echo expand("%:p")<CR>')

vim.keymap.set({'n', 'x'}, '<M-up>', ':m -2<CR>')
vim.keymap.set({'n', 'x'}, '<M-down>', ':m +1<CR>')


-- basic motions
-- f( move forward to the next occurrence of character (
-- fb move forward to the next occurrence of character b
-- 3f" move forward to the third occurrence of character "
-- t; move forward to the character just before ;
-- 3tx move forward to the character just before the third occurrence of character x
-- Fa move backward to the character a
-- Ta move backward to the character just after a
-- ; repeat previous f or F or t or T motion in the same direction
-- , repeat previous f or F or t or T motion in the opposite direction
-- for example, tc becomes Tc and vice versa

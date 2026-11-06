# Neovim tahák

`<leader>` = mezerník · otevřít tahák: `<leader>?` · zavřít: `:q`

## Módy

| Klávesa | Co dělá |
|---|---|
| `Esc` | zpět do normálního módu |
| `i` / `a` | psát před / za kurzorem |
| `I` / `A` | psát na začátku / konci řádku |
| `o` / `O` | nový řádek pod / nad a psát |
| `v` / `V` | označit znaky / řádky |
| `Ctrl+O` | (v insertu) jeden příkaz a zpět do psaní |

## Pohyb

| Klávesa | Co dělá |
|---|---|
| `h` `j` `k` `l` | vlevo, dolů, nahoru, vpravo |
| `w` / `b` / `e` | další slovo / předchozí slovo / konec slova |
| `0` / `^` / `$` | začátek řádku / první znak / konec řádku |
| `f(` / `t(` | skočit na `(` / těsně před `(` na řádku (`;` opakuje) |
| `5j` / `5k` | o 5 řádků dolů / nahoru |
| `gg` / `G` | začátek / konec souboru |
| `:42` | na řádek 42 |
| `Ctrl+d` / `Ctrl+u` | půl obrazovky dolů / nahoru |
| `%` | na párovou závorku |
| `{` / `}` | předchozí / další prázdný řádek |

## Úpravy

| Klávesa | Co dělá |
|---|---|
| `x` | smazat znak |
| `dd` | smazat řádek |
| `dw` / `D` | smazat slovo / do konce řádku |
| `ciw` | přepsat slovo |
| `C` | přepsat do konce řádku |
| `ci(` `ci"` `ci{` | přepsat obsah závorek / uvozovek |
| `di(` `da(` | smazat obsah / i se závorkami |
| `r` + znak | nahradit jeden znak |
| `>>` / `<<` | odsadit / zrušit odsazení |
| `J` | spojit s dalším řádkem |
| `u` / `Ctrl+r` | zpět / znovu |
| `.` | zopakovat poslední úpravu |

## Kopírování

| Klávesa | Co dělá |
|---|---|
| `yy` | zkopírovat řádek |
| `yiw` | zkopírovat slovo |
| `p` / `P` | vložit za / před |
| `V` + pohyb + `y` | zkopírovat označené řádky |
| `"+y` / `"+p` | kopírovat do / vložit ze systémové schránky |

Docstring: na řádku s `"""` → `^` → `V` → `/"""` `Enter` → `y`

## Hledání

| Klávesa | Co dělá |
|---|---|
| `/text` `Enter` | hledat dopředu |
| `n` / `N` | další / předchozí výskyt |
| `*` | hledat slovo pod kurzorem |
| `Ctrl+L` | zrušit zvýraznění hledání |
| `:%s/staré/nové/g` | nahradit v celém souboru |

## Soubory

| Klávesa | Co dělá |
|---|---|
| `:w` / `:q` / `:wq` | uložit / zavřít / obojí |
| `:q!` | zavřít bez uložení |
| `<leader>ff` | najít soubor |
| `<leader>fg` | hledat text ve všech souborech |
| `<leader>fb` | otevřené soubory |
| `<leader>cd` | prohlížeč souborů |
| `gx` | otevřít odkaz v prohlížeči |

## Harpoon (oblíbené soubory)

| Klávesa | Co dělá |
|---|---|
| `<leader>a` | přidat soubor |
| `Ctrl+e` | seznam |
| `Ctrl+n` / `Ctrl+p` | další / předchozí |
| `<leader>fl` | seznam s náhledem |

## Okna

| Klávesa | Co dělá |
|---|---|
| `:vsplit` / `:split` | rozdělit vedle sebe / pod sebe |
| `Ctrl+w` + `h` `j` `k` `l` | přepnout okno |
| `Ctrl+w` `q` | zavřít okno |

## Kód (LSP)

| Klávesa | Co dělá |
|---|---|
| `K` | dokumentace pod kurzorem |
| `gd` | jít na definici |
| `gr` | kde se to používá |
| `gl` | ukázat chybu na řádku |
| `F2` | přejmenovat všude |
| `F3` | naformátovat |
| `F4` | rychlé opravy |
| `Ctrl+o` | zpět, odkud jsi skočil |

## Doplňování (v insertu)

| Klávesa | Co dělá |
|---|---|
| `↑` `↓` / `Ctrl+n` `Ctrl+p` | vybrat návrh |
| `Enter` | potvrdit |
| `Ctrl+Space` / `Ctrl+e` | ukázat / schovat |

## Debug

| Klávesa | Co dělá |
|---|---|
| `<leader>b` | breakpoint |
| `F5` | spustit / pokračovat |
| `F10` / `F11` / `F12` | přes / dovnitř / ven |
| `<leader>de` | vyhodnotit výraz |
| `<leader>du` | panel debuggeru |
| `<leader>dq` | ukončit |

<div align="center">

# 🛒 SellShop

**A clean, easy-to-use item shop for your Minecraft server.**
Players type `/sell`, pick a category, click an item, and get paid. That's it.

![Version](https://img.shields.io/badge/version-1.2-2ea44f?style=for-the-badge)
![Paper](https://img.shields.io/badge/Paper-26.3-1f6feb?style=for-the-badge)
![Java](https://img.shields.io/badge/Java-25-e76f00?style=for-the-badge)
![Vault](https://img.shields.io/badge/Vault-required-8957e5?style=for-the-badge)

</div>

---

## ✨ Features

- 🗂️ **Clean menu** with categories and pages, fully server-side (players need no mods)
- 📦 **Sell by full stack or by bundle.** Each item is sold either as a full stack (64, 16, 1, ...) or as a bundle of N pieces, for example *24 pieces for 1*
- 💰 **Vault economy.** Works with any Vault-compatible economy plugin
- 🌍 **Two languages.** Ukrainian (default) and English, switched with one option. You can also add your own language file
- 🏷️ **Custom currency name.** Prices are shown like `Дзеньки х1` (or `Coins x1` in English)
- 💎 **Second (donate) currency** for categories that pay in something else
- 📊 **Sales counter.** Sold items are not lost: see the totals and take the items back
- 📝 **Sales log.** Every sale is written to a file
- ⚙️ **Fully in-game admin tools.** Add items, change prices and create categories without a restart
- 🔄 **Safe updates.** New config options are added automatically and your settings are kept

---

## 🖼️ What players see

Each item in a category shows exactly what you sell and what it pays (shown here in Ukrainian, the default language; set `language: en` for English):

```
Ціна за 24 шт.: Дзеньки х1

У вашому інвентарі: 48 шт.
(наборів по 24 шт.: 2)
Виручка за все: Дзеньки х2

ЛКМ — Продати 24 шт.
Shift + ЛКМ — Продати все з інвентарю
```

After a sale:

```
[Скупник] Продаж успішний! 24х Raw Iron Block за Дзеньки х1
```

---

## 📋 Requirements

| Requirement | Notes |
|---|---|
| **Paper 26.3** | the server software |
| **Java 25** | needed to run the server |
| **[Vault](https://www.spigotmc.org/resources/vault.34315/)** | must support your server version |
| **An economy plugin** | EssentialsX, CMI or any other plugin that works with Vault |

---

## 🚀 Installation

1. Download `SellShop-1.2.jar`.
2. Put it into your server's `plugins` folder.
3. Make sure Vault and an economy plugin are installed.
4. Restart the server.

On first start the plugin creates the folder `plugins/SellShop` with `config.yml`, `shop.yml` and the language files in `lang/`. A default set of categories (Blocks, Ores, Farm) is included, so the shop works right away.

The default language is Ukrainian. To use English, set `language: en` in `config.yml` and run `/sa reload`. The default categories in `shop.yml` are created in Ukrainian on the first start; to get them in English, delete `shop.yml` after switching the language and restart (this resets your prices, so do it only on a fresh install) or translate the `title` fields by hand.

### 🔄 Updating from an older version

1. Replace the old jar in `plugins` with the new one and restart the server.
2. **Do not delete** `config.yml` or `shop.yml`. On start the plugin adds the new options to your `config.yml` and keeps everything you already set. A backup is saved as `config.yml.bak`, and the console shows which options were added.
3. Options that already exist are **never overwritten**, so changed defaults are not applied automatically. For example, if your `config.yml` has `currencies.vault.name: "монет"`, it stays as it is. Set it to `""` to take the name from the language file (`Дзеньки` in Ukrainian, `Coins` in English).
4. **Texts moved to language files.** All texts now live in `plugins/SellShop/lang/uk.yml` and `en.yml`. On the first start after updating, the texts you customized in the old `messages` section, `prefix` and `gui.main-title` of `config.yml` are copied into `lang/uk.yml`. Those old entries in `config.yml` are no longer used and can be deleted.
5. `shop.yml` is not changed. The old format (`STONE: 64.0`) still works and means "price per full stack".

---

## 🎮 How to use

Type `/sell`, click a category, then click an item.

| Action | Result |
|---|---|
| **Left click** | sells one stack (or one bundle) of the item |
| **Shift + left click** | sells everything of that item you have, in whole stacks or bundles |

> Only whole stacks (or whole bundles) are sold, partial amounts are not. Only plain items are sold: items with a custom name, enchantments or other special data are skipped.

---

## ⌨️ Commands and permissions

### Players

| Command | Permission | Description |
|---|---|---|
| `/sell` | `sellshop.use` (everyone by default) | open the shop |

### Admins

The main command is `/selladmin`, short form `/sa`. Permission: `sellshop.admin` (operators by default).

| Command | Description |
|---|---|
| `/sa help` | show all admin commands |
| `/sa add <category> <amount> <price> [item]` | add an item. The price is for `<amount>` pieces (for example `1`, `24` or `64`), and the menu shows the same amount. Without an item name, the item in your hand is used |
| `/sa price <category> <item> <price>` | change an item's price (per stack, or per bundle for bundle items) |
| `/sa unit <category> <item> <amount\|stack>` | sell the item in bundles of `<amount>` pieces, or `stack` to sell full stacks |
| `/sa remove <category> <item>` | remove an item from a category |
| `/sa addcategory <id> <icon> [title]` | create a category. The title supports `&` color codes |
| `/sa removecategory <id>` | delete a category |
| `/sa stats [page]` | show what players have sold (10 items per page) |
| `/sa take <item> [amount\|all]` | take items from the sales counter into your inventory. Without an amount you get one stack |
| `/sa reload` | reload the configuration |

Item names are the standard Minecraft names in capital letters, for example `DIAMOND`, `OAK_LOG` or `IRON_INGOT`. Press **Tab** to autocomplete.

### ⚡ Quick start

```
/sa addcategory tools DIAMOND_PICKAXE &bTools
/sa add tools 1 15.5 IRON_PICKAXE         # 1 piece for 15.5
/sa add ores 24 1 RAW_IRON_BLOCK          # 24 pieces for 1
/sa add blocks 64 64 STONE                # a full stack of 64 for 64
/sa price blocks STONE 70                 # change the price
/sa unit ores RAW_IRON_BLOCK 16           # now 16 pieces per sale
/sa unit ores RAW_IRON_BLOCK stack        # back to full stacks
/sa take COBBLESTONE all
```

> If the amount you give is a full stack of that item (64 for stone, 16 for ender pearls), the item is saved as a normal stack item. For you it works the same way.

---

## ⚙️ Configuration

### `shop.yml`: categories and prices

You can edit this file by hand or use the `/sa` commands. Run `/sa reload` after editing.

```yaml
categories:
  blocks:
    title: "&aBlocks"      # name shown in the menu
    icon: GRASS_BLOCK      # icon in the main menu
    slot: 11               # slot in the main menu (-1 = automatic)
    currency: vault        # vault or donate
    items:
      STONE: 64.0          # price per FULL STACK (64 pcs for stone, 16 for ender pearls, ...)
      COBBLESTONE: 32.0
      RAW_IRON_BLOCK:      # sold in bundles of N pieces instead of full stacks
        mode: piece
        amount: 24         # how many pieces are sold at once
        price: 1.0         # price for that amount (24 pcs = 1.0)
```

An item is sold either by **full stack** (just write the price) or by a **bundle of N pieces** (`mode: piece`, plus `amount` and the `price` for that amount).

### `config.yml`: texts and currencies

| Option | Description |
|---|---|
| `language` | `uk` (Ukrainian, default) or `en` (English), or the code of your own language file |
| `gui.main-rows`, `gui.filler` | look of the main menu |
| `gui.show-full-stack` | show items in a category with their full amount (`true`) or as a single item (`false`) |
| `currencies` | currency names. Leave `name: ""` to use the language's default (`Дзеньки` / `Coins`) or write your own. Prices are shown as `<name> х<amount>` in Ukrainian and `<name> x<amount>` in English |

### 🌍 Languages and texts

All texts (menu, messages, admin help, console logs, price format) are stored in `plugins/SellShop/lang/`:

| File | Language |
|---|---|
| `uk.yml` | Ukrainian (default) |
| `en.yml` | English |

- Switch the language with `language` in `config.yml`, then run `/sa reload`.
- Edit any text in the language file to restyle it. Your edits are kept on updates, and new texts are added automatically (a `.bak` backup is made).
- **Your own language:** copy `en.yml` to `lang/de.yml`, translate it, and set `language: de`.
- Category titles live in `shop.yml` (`title`), so they are not translated automatically. The default categories are created in the language set in `config.yml` at the first start.

The `sold` message (`messages.sold` in the language file) supports these placeholders:

| Placeholder | Meaning |
|---|---|
| `{amount}` | number of pieces sold |
| `{item}` | item name |
| `{money}` | earned amount with the currency name (`Дзеньки х64`) |
| `{currency}` | currency name |
| `{value}` | earned amount as a plain number |
| `{stacks}` | number of stacks or bundles sold |

---

## 💎 Donate currency

Categories pay in regular money by default (`currency: vault`). To pay some categories in a donate currency:

1. In `config.yml`, enable the donate currency and set the command that gives it:

   ```yaml
   currencies:
     donate:
       enabled: true
       name: "donate coins"
       command: "points give {player} {amount}"
   ```

   `{player}` and `{amount}` are filled in automatically. Replace the command with the one your donate plugin uses.
2. In `shop.yml`, set `currency: donate` for the categories that should pay in it.
3. Run `/sa reload`.

---

## 📊 Sales counter

Every item sold by players is added to the sales counter instead of disappearing. Use `/sa stats` to see the totals and `/sa take` to get the items back, for example to restock admin chests or event rewards.

## 📝 Sales log

All sales and counter withdrawals are written to `plugins/SellShop/sales.log`:

```
[2026-11-13 13:30:12] SELL Steve sold 64x STONE for 64 (vault, category=blocks, mode=stack)
[2026-11-13 13:41:50] TAKE Admin took 64x STONE from counter (left 0)
```

---

## ❓ FAQ

<details>
<summary><b>Nothing happens when I sell, or I get an economy error.</b></summary>

Check that Vault and an economy plugin are installed. The server console shows a warning if no economy plugin is found.
</details>

<details>
<summary><b>My item is not sold.</b></summary>

Make sure the item is in a shop category, has no custom name or enchantments, and that you have at least a full stack (or the full bundle amount set for it).
</details>

<details>
<summary><b>Where are the sold items?</b></summary>

In the sales counter. Use `/sa stats` to see them and `/sa take` to get them.
</details>

<details>
<summary><b>I updated and still see the old currency name or messages.</b></summary>

Existing options are never overwritten. Set `currencies.vault.name: ""` in `config.yml` to use the language's default name, and edit the texts in `plugins/SellShop/lang/<language>.yml`, then run `/sa reload`.
</details>

<details>
<summary><b>How do I switch the plugin to English?</b></summary>

Set `language: en` in `config.yml` and run `/sa reload`. Category titles from `shop.yml` stay as you wrote them.
</details>

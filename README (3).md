# SellShop

A simple, easy-to-use shop for selling items on your Minecraft server. Players type `/sell`, open a category, and click an item to sell it for in-game money.

- **Left click** an item: sell one stack
- **Shift + left click**: sell everything of that item you have in your inventory
- Fully server-side menu. Players do not need any mods.

## Features

- Clean menu with categories and pages
- Each item shows its price per piece, price per stack, how many you have and how much you will earn
- Payments through Vault, so it works with any Vault-compatible economy plugin
- Every sale is saved to a log file
- Built-in sales counter: see what was sold and how much
- Admins can take sold items out of the counter
- Admins can add items, change prices and create categories in-game, no restart needed
- Support for a second (donate) currency

## Requirements

| Requirement | Notes |
|---|---|
| Paper 26.3 | the server software |
| Java 25 | needed to run the server |
| [Vault](https://www.spigotmc.org/resources/vault.34315/) | must support your server version |
| An economy plugin | EssentialsX, CMI or any other plugin that works with Vault |

## Installation

1. Download `SellShop-1.0.0.jar`.
2. Put it into your server's `plugins` folder.
3. Make sure Vault and an economy plugin are installed.
4. Restart the server.

On first start the plugin creates the folder `plugins/SellShop` with the files `config.yml` and `shop.yml`. A default set of categories (Blocks, Ores, Farm) is included, so the shop works right away.

## How to use

Type `/sell`, click a category, then click an item:

| Action | Result |
|---|---|
| Left click | sells one stack of the item |
| Shift + left click | sells all of that item in your inventory |

Only plain items are sold. Items with a custom name, enchantments or other special data are skipped.

## Commands and permissions

### Players

| Command | Permission | Description |
|---|---|---|
| `/sell` | `sellshop.use` (everyone by default) | open the shop |

### Admins

The main command is `/selladmin`, short form `/sa`. Permission: `sellshop.admin` (operators by default).

| Command | Description |
|---|---|
| `/sa help` | show all admin commands |
| `/sa add <category> <price> [item]` | add an item with a price per piece. Without an item name, the item in your hand is used |
| `/sa price <category> <item> <price>` | change an item's price |
| `/sa remove <category> <item>` | remove an item from a category |
| `/sa addcategory <id> <icon> [title]` | create a category. The title supports `&` color codes |
| `/sa removecategory <id>` | delete a category |
| `/sa stats [page]` | show what players have sold (10 items per page) |
| `/sa take <item> [amount\|all]` | take items from the sales counter into your inventory. Without an amount you get one stack |
| `/sa reload` | reload the configuration |

Item names are the standard Minecraft names in capital letters, for example `DIAMOND`, `OAK_LOG` or `IRON_INGOT`. Press Tab to autocomplete.

Examples:

```
/sa addcategory tools DIAMOND_PICKAXE &bTools
/sa add tools 15.5 IRON_PICKAXE
/sa add blocks 2
/sa price blocks STONE 1.5
/sa take COBBLESTONE all
```

`/sa add blocks 2` adds the item you are holding to the `blocks` category for 2 per piece.

## Sales counter

Every item sold by players is added to the sales counter instead of disappearing. Use `/sa stats` to see the totals and `/sa take` to get the items back, for example to restock admin chests or event rewards.

## Sales log

All sales and counter withdrawals are written to `plugins/SellShop/sales.log`:

```
[2026-11-13 13:30:12] SELL Steve sold 64x STONE for 64 (vault, category=blocks, mode=stack)
[2026-11-13 13:41:50] TAKE Admin took 64x STONE from counter (left 0)
```

## Configuration

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
      STONE: 1.0           # price per piece
      COBBLESTONE: 0.5
```

### `config.yml`: texts and currencies

- `prefix`: prefix of all plugin messages
- `gui.main-title`, `gui.main-rows`, `gui.filler`: look of the main menu
- `currencies`: names of the currencies
- `messages`: every message the plugin sends, so you can translate or restyle it

## Donate currency

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

## FAQ

**Nothing happens when I sell, or I get an economy error.**
Check that Vault and an economy plugin are installed. The server console shows a warning if no economy plugin is found.

**My item is not sold.**
Make sure the item is in a shop category and has no custom name or enchantments.

**Where are the sold items?**
In the sales counter. Use `/sa stats` to see them and `/sa take` to get them.

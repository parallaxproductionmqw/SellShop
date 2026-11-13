# SellShop

A seller (shop) plugin for Minecraft servers running Paper 26.3. Players type `/sell`, pick a category and sell items for in-game currency through Vault.

- **Left click** an item: sell one stack
- **Shift + left click**: sell everything of that item in the inventory
- Custom GUI: the menu is rendered by the server, no client mods needed

## Features

- Main menu with categories; items inside a category are paginated
- Item lore shows the price per item, the price per stack, how many the player has, and the total payout
- Payment through Vault; if the payout fails, the items are returned to the player
- Every sale is written to a `sales.log` file
- Sales counter (`stats.yml`): what was sold and how many
- Admins can take items out of the counter with a command
- Admins add items, prices and categories themselves, including in-game by command
- Groundwork for a donate currency (disabled by default)

## Requirements

| What | Version |
|---|---|
| Minecraft server | Paper 26.3 |
| Java (running the server and building) | 25 |
| [Vault](https://www.spigotmc.org/resources/vault.34315/) | must support your server version |
| Vault-compatible economy plugin | EssentialsX, CMI, etc. |
| Maven (build only) | 3.9+ |

Without an economy plugin the plugin still starts, but selling for Vault money will not work and a warning is printed to the console.

## Building the jar from the source zip

### Option 1: on your own computer

1. Install **JDK 25** and **Maven**. Check that `java -version` and `mvn -version` work.
2. Unzip `SellShop-repo.zip` (or `SellShop-source.zip`) into any folder.
3. Open a terminal in the `SellShop` folder, the one containing `pom.xml`.
4. Run:

   ```
   mvn package
   ```

5. The finished file appears in `target/` as `SellShop-1.0.0.jar`.
6. Put the jar into your server's `plugins/` folder and restart the server.

An internet connection is required for the build: Maven downloads the Paper API and VaultAPI.

If the build fails with an error about the `paper-api` dependency, open `pom.xml` and replace the version `26.3.build.230-stable` with the current one from https://jd.papermc.io/paper/26.3/.

### Option 2: through GitHub (no Java or Maven installation)

1. Create an empty repository on GitHub.
2. Unzip `SellShop-repo.zip` and, in the `SellShop` folder, run:

   ```
   git remote add origin https://github.com/<your-username>/SellShop.git
   git push -u origin main
   ```

3. Open the repository, go to the **Actions** tab, open the latest **Build** run, and download `SellShop-jar` from the **Artifacts** section.
4. To have the jar in **Releases**, create a tag:

   ```
   git tag v1.0.0
   git push origin v1.0.0
   ```

The build is described by `.github/workflows/build.yml`.

## Installation

1. Make sure Vault and an economy plugin are installed on the server.
2. Put `SellShop-1.0.0.jar` into the `plugins/` folder.
3. Start the server: `config.yml` and `shop.yml` appear in `plugins/SellShop/`.
4. Give your admins the `sellshop.admin` permission.

## Commands

### For players

| Command | Permission | Description |
|---|---|---|
| `/sell` | `sellshop.use` (everyone by default) | open the shop |

### For admins

Main command `/selladmin`, short form `/sa`. Permission: `sellshop.admin` (operators by default).

| Command | Description |
|---|---|
| `/sa help` | list of commands |
| `/sa add <category> <price> [item]` | add an item with a price per piece. If no item is given, the item in your hand is used |
| `/sa price <category> <item> <price>` | change an item's price |
| `/sa remove <category> <item>` | remove an item from a category |
| `/sa addcategory <id> <icon> [title]` | create a category. The title may contain `&` color codes |
| `/sa removecategory <id>` | delete a category |
| `/sa stats [page]` | sales counter, 10 items per page |
| `/sa take <item> [amount\|all]` | take items from the counter into your inventory. Without an amount, one stack is given |
| `/sa reload` | reload `config.yml` and `shop.yml` |

Item names are written in English as in the game: `DIAMOND`, `OAK_LOG`, `IRON_INGOT`. Tab completion is supported.

Examples:

```
/sa addcategory tools DIAMOND_PICKAXE &bTools
/sa add tools 15.5 IRON_PICKAXE
/sa add blocks 2            (item from your hand)
/sa price blocks STONE 1.5
/sa take COBBLESTONE all
```

## Plugin files

Located in `plugins/SellShop/`:

| File | Contents |
|---|---|
| `config.yml` | prefix, menu title, currencies, message texts |
| `shop.yml` | categories, icons, slots, category currency, items and prices |
| `stats.yml` | sales counter (do not edit while the server is running) |
| `sales.log` | log of sales and withdrawals from the counter |

Example line from `sales.log`:

```
[2026-11-13 13:30:12] SELL Steve sold 64x STONE for 64 (vault, category=blocks, mode=stack)
```

### Configuring a category in `shop.yml`

```yaml
categories:
  blocks:
    title: "&aBlocks"      # name shown in the menu
    icon: GRASS_BLOCK      # icon in the main menu
    slot: 11               # slot in the main menu (-1 = automatic)
    currency: vault        # vault or donate
    items:
      STONE: 1.0           # price per piece
```

## Donate currency

By default every category pays in regular money (`currency: vault`). A donate currency is already built in but disabled. Money is given by a console command.

1. Enable and configure the block in `config.yml`:

   ```yaml
   currencies:
     donate:
       enabled: true
       name: "donate coins"
       command: "points give {player} {amount}"
   ```

   `{player}` and `{amount}` are substituted automatically. Replace the command with the one your plugin uses to give the donate currency.
2. In `shop.yml`, set `currency: donate` on the category you want.
3. Run `/sa reload`.

## Good to know

- Only plain items are sold: items with a custom name, enchantments or other data are skipped.
- The counter is saved every 30 seconds and when the server shuts down.
- Items sold by players go into the counter instead of disappearing. An admin can take them with `/sa take`.

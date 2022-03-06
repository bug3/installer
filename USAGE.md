# Installation

-   With [curl](https://curl.se):

    ```bash
    bash <(curl -fsSL dar.vin/install) $userName $repository $branch
    ```

-   With [wget](https://www.gnu.org/software/wget):

    ```bash
    bash <(wget -qO- dar.vin/install) $userName $repository $branch
    ```

# Uninstallation

-   With [curl](https://curl.se):

    ```bash
    bash <(curl -fsSL dar.vin/install) $userName $repository $branch -r
    ```

-   With [wget](https://www.gnu.org/software/wget):

    ```bash
    bash <(wget -qO- dar.vin/install) $userName $repository $branch -r
    ```

### Note

Default branch is **master**

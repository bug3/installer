# Installation

-   [curl](https://curl.se):

    ```bash
    bash <(curl -sL dar.vin/install) $userName $repository $branch
    ```

-   [wget](https://www.gnu.org/software/wget):

    ```bash
    bash <(wget -qO- dar.vin/install) $userName $repository $branch
    ```

# Uninstallation

-   [curl](https://curl.se):

    ```bash
    bash <(curl -sL dar.vin/install) $userName $repository $branch -r
    ```

-   [wget](https://www.gnu.org/software/wget):

    ```bash
    bash <(wget -qO- dar.vin/install) $userName $repository $branch -r
    ```

# Windows

-   Install:

    ```powershell
    . { iwr -useb dar.vin/winstall } | iex; w -user $userName -repo $repository -branch $branch
    ```

-   Uninstall:

    ```powershell
    . { iwr -useb dar.vin/winstall } | iex; w -user $userName -repo $repository -branch $branch -remove $true
    ```

### Note

Default branch is **master**

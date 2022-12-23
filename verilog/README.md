# Verilog

本程式為原創作品，僅有 `ALU_test.v`、`RAM16K_test.v`、`PC_test.v`、`Computer_test.v` 修改自[老師的專案](https://gitlab.com/cccnqu111/co/-/tree/master/verilog/02-nand2tetris)。

## 實作細節

### 第一步：設定環境

先前往 `iverilog` [官網](https://bleyer.org/icarus/)下載安裝檔，並在下載好後進行安裝。  
安裝完畢後，進入 `CMD` 內就可以使用 `iverilog` 和 `vvp` 了。

### 第二步：撰寫程式

閱讀網路上的隨機教材，並模仿先前做的 `nand2tetris` 邏輯閘寫法，開始撰寫 1 ~ 5 章的習題內容。  
撰寫完畢後，把主要程式碼放到每一章節下的 `gates.v` ， 並把測試程式獨立到同資料夾下的 `[檔案名稱]_test.v` 裡。

### 第三步：執行程式

在同資料夾下打開終端機，並輸入以下指令：
```
iverilog -o [檔案名稱].out [檔案名稱]_test.v
vvp [檔案名稱].out
```
輸入完畢後，即可確認執行結果是否正常。

## 授權聲明

[LICENSE](https://github.com/LeeYi-user/co111a/tree/main/verilog/LICENSE)

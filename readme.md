# readme

## 目的

不論是寫何種語言，都希望能把當下程式中的註解，直接轉譯為 .md，並且能最小化註解風格格式化
方便性為，若為 restful-api 對外的文件，則可直接將要公開的文件內容輸出為 .md 檔案
降低文件的重複編輯性，加速工程人員對於文件註解的習慣與完整性

Hope this script could help accelerate development and persist in good comment habit.
Do not need to maintain twice version between code and document.
When developer write down comment in code context, it mean that you finish the document at the same time. 

## 說明

將註解的內容，依照格式完整地變成一份檔案
目前預設的
 
- start_sign : `/*===`
- end_sign : `===*/`

介於此註解中的內容，會完整的產生到 .md 中

如範例 index2.php -> index2.md

## 注意

- 輸入的檔案，為相對位置
- 輸出的檔案，為本地位置
- 預設的 `start_sign` & `end_sign`，長度為固定的 5
	- 配合他種語言，請選擇適當的 sign

## 使用

![img](./img1.png)
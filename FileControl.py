import autoit

class FileControl:
    def set_file(self):
        #設置焦點
        autoit.control_focus("開啟","[Class:Edit; instance:1]")
        #輸入text
        autoit.control_set_text("開啟","[Class:Edit; instance:1]",r"C:\Users\1700485\Pictures\1.png")

        # autoit.control_set_text("開啟","[Class:Edit; instance:1]",r"C:\Users\Administrator\Desktop\226523.jpg")
        # 單擊按鈕
        autoit.control_click("開啟","[Class:Button; instance:1]")
        return
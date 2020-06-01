import autoit
# from vars import image_path, audio_path

class FileControl:
    def set_file(self, file_path):
        #設置焦點
        autoit.control_focus("開啟","[Class:Edit; instance:1]")
        #輸入text        
        autoit.control_set_text("開啟","[Class:Edit; instance:1]", file_path)
        # 單擊按鈕
        autoit.control_click("開啟","[Class:Button; instance:1]")
        return
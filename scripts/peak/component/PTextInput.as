package peak.component
{
   import com.arabicode.text.Flaraby.FlarabyAS3;
   import fl.controls.TextInput;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.text.TextFormat;
   import peak.display.TextInputDTO;
   import peak.i18n.lang.Languages;
   import peak.resource.asset.display.AssetDisplayObject;
   import peak.util.FullScreenExitUtil;
   
   public class PTextInput extends TextInput
   {
      
      private var _flarabyAS3:FlarabyAS3;
      
      private var _inputId:String;
      
      private var _externalInputEnabled:Boolean;
      
      private var currentFrame:int = -1;
      
      public function PTextInput()
      {
         super();
         this.textField.antiAliasType = "advanced";
         this.textField.embedFonts = Languages.isActiveLanguageEmdedded();
         this.addEventListener("enterFrame",onEnterFrame);
         _inputId = "";
         _externalInputEnabled = false;
         if(Languages.activeLanguageId == "ar")
         {
            _flarabyAS3 = new FlarabyAS3();
            this.addEventListener("click",onMouseClicked);
         }
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(stage && this.visible && currentFrame == 2)
         {
            currentFrame = -1;
            stage.focus = textField;
            textField.setSelection(textField.text.length,textField.text.length);
            removeEventListener("enterFrame",onEnterFrame);
            return;
         }
         currentFrame = currentFrame + 1;
      }
      
      override protected function getDisplayObjectInstance(param1:Object) : DisplayObject
      {
         if(param1 is AssetDisplayObject)
         {
            return (param1 as AssetDisplayObject).clone();
         }
         if(param1 is Bitmap)
         {
            return new Bitmap((param1 as Bitmap).bitmapData);
         }
         return super.getDisplayObjectInstance(param1);
      }
      
      override protected function focusInHandler(param1:FocusEvent) : void
      {
         if(stage && stage.displayState == "fullScreen" && !FullScreenExitUtil.fullScreenRequestWhileFocused)
         {
            FullScreenExitUtil.exitingFullScreenForKeyboardInteractivity = true;
            stage.displayState = "normal";
            currentFrame = 0;
            addEventListener("enterFrame",onEnterFrame);
         }
         if(FullScreenExitUtil.fullScreenRequestWhileFocused)
         {
            if(stage.displayState != "fullScreen")
            {
               stage.displayState = "fullScreen";
            }
            stage.focus = stage;
            FullScreenExitUtil.fullScreenRequestWhileFocused = false;
         }
         super.focusInHandler(param1);
      }
      
      private function onMouseClicked(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(_externalInputEnabled && _flarabyAS3 != null && ExternalInterface.available)
         {
            if(_flarabyAS3 != null)
            {
               _loc2_ = this.text;
            }
            else
            {
               _loc2_ = this.textField.text;
            }
            ExternalInterface.call("WOM.input.get",_inputId,_loc2_,this.maxChars);
         }
      }
      
      public function get inputId() : String
      {
         return _inputId;
      }
      
      public function set inputId(param1:String) : void
      {
         _inputId = param1 != null ? param1 : "";
      }
      
      public function get externalInputEnabled() : Boolean
      {
         return _externalInputEnabled;
      }
      
      public function set externalInputEnabled(param1:Boolean) : void
      {
         var _loc2_:TextFormat = null;
         if(_flarabyAS3 != null && ExternalInterface.available)
         {
            _externalInputEnabled = param1;
            this.editable = !param1;
            if(_externalInputEnabled)
            {
               _loc2_ = new TextFormat();
               _loc2_.align = "right";
               this.textField.defaultTextFormat = _loc2_;
            }
         }
      }
      
      public function externalTextInputUpdated(param1:TextInputDTO) : void
      {
         if(param1 != null && param1.inputId == _inputId)
         {
            if(_flarabyAS3 != null)
            {
               this.textField.text = _flarabyAS3.convertArabicString(param1.text,this.textField.width,this.textField.getTextFormat());
            }
            else
            {
               this.textField.text = param1.text;
            }
         }
      }
      
      override public function get text() : String
      {
         if(_flarabyAS3 != null)
         {
            return _flarabyAS3.convertArabicString(this.textField.text,this.textField.width,this.textField.getTextFormat());
         }
         return super.text;
      }
   }
}


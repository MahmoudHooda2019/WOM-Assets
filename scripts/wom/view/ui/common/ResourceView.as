package wom.view.ui.common
{
   import flash.text.TextFormat;
   import wom.view.component.WomTextFormats;
   
   public class ResourceView extends IconLabelView
   {
      
      private var _resourceId:int;
      
      public function ResourceView(param1:int, param2:String, param3:String, param4:int = 95, param5:int = 70, param6:Number = 1)
      {
         super(param2,param3,param4,param5,null,WomTextFormats.CENTER_18_BRIGHT_RED,true,param6);
         _resourceId = param1;
      }
      
      override public function updateTextFormat(param1:Boolean) : void
      {
         textField.defaultTextFormat = param1 ? WomTextFormats.CENTER_18_BRIGHT_RED : defaultTextFormat;
         textField.filters = param1 ? [WomTextFormats.RED_FILTER] : [WomTextFormats.DEFAULT_FILTER];
         textField.text = textField.text;
      }
      
      public function get resourceId() : int
      {
         return _resourceId;
      }
   }
}


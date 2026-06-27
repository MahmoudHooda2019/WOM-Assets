package wom.view.ui.mainframe.city.tooltip
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextFormats;
   
   public class TooltipInfoView extends Sprite
   {
      
      public var background:DisplayObject;
      
      public var image:DisplayObject;
      
      public var infoText:CaptionTextField;
      
      public function TooltipInfoView(param1:WomAssetRepository, param2:String, param3:String)
      {
         super();
         background = param1.getDisplayObject("BackgroundLight");
         background.width = 70;
         background.height = 22;
         addChild(background);
         image = param1.getDisplayObject(param2);
         image.addEventListener("change",onAssetChange,false,0,true);
         addChild(image);
         infoText = new CaptionTextField();
         infoText.width = background.width - 15;
         infoText.defaultTextFormat = WomTextFormats.CENTER_16;
         infoText.text = param3;
         addChild(infoText);
         drawLayout();
      }
      
      private function drawLayout() : void
      {
         image.x = background.x - (image.width >> 1) + 3;
         image.y = background.y - (image.height - background.height >> 1);
         infoText.x = background.x + 10;
         infoText.y = background.y + 2;
      }
      
      private function onAssetChange(param1:Event) : void
      {
         drawLayout();
      }
   }
}


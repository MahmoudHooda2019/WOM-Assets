package wom.view.ui.mainframe.combat.eventitems
{
   import fl.controls.Button;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import peak.display.View;
   import peak.i18n.PText;
   import wom.model.domain.domaininfoobject.EventItemDIO;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.AvatarButton;
   
   public class CombatEventItemView extends Sprite implements View
   {
      
      public static const SELECTED_FILTERS:Array = [new GlowFilter(2135263,1,7,7,5)];
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      private var _selected:Boolean;
      
      private var _enabled:Boolean;
      
      private var _background:Button;
      
      private var itemAsset:DisplayObject;
      
      private var itemCountTF:TextField;
      
      private var _used:Boolean;
      
      private var _eventItemDIO:EventItemDIO;
      
      public function CombatEventItemView()
      {
         super();
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
         drawLayout();
      }
      
      public function initLayout() : void
      {
         _background = new AvatarButton();
         _background.useHandCursor = true;
         _background.buttonMode = true;
         _background.width = 64;
         _background.height = 64;
         addChild(_background);
         itemAsset = null;
         itemCountTF = new CaptionTextField();
         itemCountTF.defaultTextFormat = WomTextFormats.CENTER_18;
         itemCountTF.height = 16;
         itemCountTF.width = _background.width;
         _background.addChild(itemCountTF);
         _used = false;
         _selected = false;
         _enabled = false;
      }
      
      public function drawLayout() : void
      {
         if(itemAsset)
         {
            itemAsset.x = 5;
            itemAsset.y = 5;
         }
         itemCountTF.y = 37;
      }
      
      public function updateWithEventItemInfo(param1:EventItemDIO, param2:int) : void
      {
         _eventItemDIO = param1;
         updateItemCount(param2);
         updateItemAsset(param1.assetName);
         drawLayout();
      }
      
      private function updateItemAsset(param1:String) : void
      {
         if(itemAsset && _background.contains(itemAsset))
         {
            _background.removeChild(itemAsset);
         }
         itemAsset = assetRepository.getDisplayObject(param1);
         _background.addChildAt(itemAsset,0);
      }
      
      public function updateItemCount(param1:int) : void
      {
         if(param1 >= 0)
         {
            itemCountTF.text = param1.toString();
         }
         updateItemEnabling(param1 > 0);
      }
      
      public function updateSelection(param1:Boolean) : void
      {
         _selected = param1;
         updateFilters();
      }
      
      public function updateItemUsed(param1:Boolean) : void
      {
         _used = param1;
         if(param1 && itemCountTF)
         {
            var _temp_3:* = itemCountTF;
            var _loc2_:String = "ui.mainframe.combat.eventitems.used";
            _temp_3.text = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         }
         updateItemEnabling(!param1);
      }
      
      public function updateItemEnabling(param1:Boolean) : void
      {
         _enabled = param1;
         this.alpha = param1 ? 1 : 0.5;
      }
      
      public function updateFilters() : void
      {
         filters = _selected ? SELECTED_FILTERS : [];
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function get used() : Boolean
      {
         return _used;
      }
      
      public function get enabled() : Boolean
      {
         return _enabled;
      }
      
      public function get background() : Button
      {
         return _background;
      }
      
      public function get eventItemDIO() : EventItemDIO
      {
         return _eventItemDIO;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
      }
   }
}


package wom.model.component.attribute.viewManager
{
   import peak.cuckoo.core.Attribute;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.Layer;
   import peak.cuckoo.game.attribute.Position;
   import peak.cuckoo.game.attribute.bounds.compositeBased.CompositeChildRenderBounds;
   import peak.cuckoo.game.attribute.projection.HeightRevertedProjection;
   import peak.cuckoo.game.attribute.view.AssetView;
   import peak.cuckoo.game.dto.Point3;
   import wom.model.component.WomGameRoot;
   
   public class FloatingTextViewManager extends Attribute
   {
      
      public static const TYPE_ID:String = "FloatingTextViewManager";
      
      public static const WIDTH:int = 100;
      
      public static const HEIGHT:int = 100;
      
      public static const DAMAGE:int = 1;
      
      public static const HEAL:int = 2;
      
      public static const LOOT_WOOD:int = 3;
      
      public static const LOOT_STONE:int = 4;
      
      public static const LOOT_MIGHT:int = 5;
      
      public static const LOOT_IRON:int = 6;
      
      public static const HARVEST_WOOD:int = 7;
      
      public static const HARVEST_STONE:int = 8;
      
      public static const HARVEST_MIGHT:int = 9;
      
      public static const HARVEST_IRON:int = 10;
      
      public static const HARVEST_GOLD:int = 11;
      
      public static const HARVEST_RP:int = 12;
      
      public static const PART:int = 13;
      
      private const LETTER_SPACING:int = 4;
      
      private var text:String;
      
      private var color:int;
      
      private var assetId:String;
      
      private var blackStroke:Boolean;
      
      private var size:int;
      
      private var ownerSprite:GameSprite;
      
      private var assetSprite:GameSprite;
      
      private var numberSprites:Vector.<GameSprite>;
      
      private var womRoot:WomGameRoot;
      
      public var resourceImage:String;
      
      public var usedWidth:Number;
      
      public function FloatingTextViewManager()
      {
         super();
      }
      
      override public function get typeId() : String
      {
         return "FloatingTextViewManager";
      }
      
      override public function init() : void
      {
         super.init();
         ownerSprite = owner as GameSprite;
         womRoot = ownerSprite.root as WomGameRoot;
         numberSprites = new Vector.<GameSprite>();
         usedWidth = 0;
      }
      
      public function addText(param1:String, param2:uint, param3:String, param4:Boolean, param5:int) : void
      {
         var _loc9_:int = 0;
         var _loc8_:String = null;
         var _loc7_:GameSprite = null;
         usedWidth = 0;
         this.text = param1;
         this.color = param2;
         this.assetId = param3;
         this.blackStroke = param4;
         this.size = param5;
         this.resourceImage = param3;
         var _loc6_:int = 0;
         if(param3)
         {
            assetSprite = new GameSprite();
            assetSprite.componentManager.add(assetSprite.view = new AssetView(4,param3,false));
            assetSprite.componentManager.add(assetSprite.position = new Position(new Point3()));
            assetSprite.componentManager.add(new HeightRevertedProjection());
            assetSprite.componentManager.add(assetSprite.bounds = new CompositeChildRenderBounds());
            ownerSprite.root.addChild(assetSprite);
            assetSprite.composite = ownerSprite;
            ownerSprite.addChild(assetSprite);
            assetSprite.init();
            (ownerSprite.root.layers[4] as Layer).add(assetSprite);
            usedWidth += assetSprite.bounds.width * 0.85;
            _loc6_ = assetSprite.bounds.height / 2 - 9;
         }
         _loc9_ = 0;
         while(_loc9_ < param1.length)
         {
            _loc8_ = "Number" + param1.charAt(_loc9_);
            _loc7_ = new GameSprite();
            _loc7_.componentManager.add(_loc7_.view = new AssetView(4,_loc8_,false));
            _loc7_.componentManager.add(_loc7_.position = new Position(new Point3(usedWidth - 4,_loc6_)));
            _loc7_.componentManager.add(new HeightRevertedProjection());
            _loc7_.componentManager.add(_loc7_.bounds = new CompositeChildRenderBounds());
            ownerSprite.root.addChild(_loc7_);
            _loc7_.composite = ownerSprite;
            ownerSprite.addChild(_loc7_);
            _loc7_.init();
            (ownerSprite.root.layers[4] as Layer).add(_loc7_);
            var _temp_11:* = §§findproperty(usedWidth);
            usedWidth += _loc7_.bounds.width - ((param1.length - _loc9_) % 3 == 1 ? 0 : 4);
            _loc7_.view.colorFilter(param2);
            numberSprites.push(_loc7_);
            _loc9_++;
         }
         usedWidth += 4;
      }
      
      override public function destroy() : void
      {
         var _loc1_:GameSprite = null;
         if(assetSprite)
         {
            womRoot.removeChild(assetSprite);
            (womRoot.layers[4] as Layer).remove(assetSprite);
            assetSprite.destroy();
         }
         while(numberSprites.length > 0)
         {
            _loc1_ = numberSprites[0];
            womRoot.removeChild(_loc1_);
            (womRoot.layers[4] as Layer).remove(_loc1_);
            _loc1_.destroy();
            numberSprites.splice(0,1);
         }
         super.destroy();
      }
      
      public function changeText(param1:String, param2:String) : void
      {
         var _loc4_:GameSprite = null;
         if(param2 && assetSprite)
         {
            (owner.root.layers[4] as Layer).remove(assetSprite);
            owner.root.removeChild(assetSprite);
            ownerSprite.removeChild(assetSprite);
            assetSprite.destroy();
            assetSprite = null;
         }
         while(numberSprites.length > 0)
         {
            _loc4_ = numberSprites[0];
            (owner.root.layers[4] as Layer).remove(_loc4_);
            owner.root.removeChild(_loc4_);
            ownerSprite.removeChild(_loc4_);
            _loc4_.destroy();
            numberSprites.splice(0,1);
         }
         var _loc3_:int = int(param1) + int(this.text);
         addText("" + _loc3_,color,param2,blackStroke,size);
      }
   }
}


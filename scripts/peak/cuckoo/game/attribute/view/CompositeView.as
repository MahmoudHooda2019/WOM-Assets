package peak.cuckoo.game.attribute.view
{
   import flash.display.Sprite;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.behavior.sort.ZSort;
   
   public class CompositeView extends BaseView
   {
      
      public var sprite:Sprite;
      
      public var children:Vector.<GameSprite>;
      
      public function CompositeView()
      {
         super(3);
         children = new Vector.<GameSprite>();
      }
      
      override public function init() : void
      {
         var _loc1_:int = 0;
         super.init();
         if(owner.root.render.RENDER_TYPE == 1)
         {
            sprite = new Sprite();
            (sprite as Sprite).mouseEnabled = false;
            (sprite as Sprite).mouseChildren = false;
         }
      }
      
      public function addChild(param1:GameSprite) : void
      {
         children.push(param1);
         sort();
      }
      
      public function clearChild(param1:GameSprite) : void
      {
         var _loc2_:int = children.indexOf(param1);
         if(_loc2_ != -1)
         {
            children.splice(_loc2_,1);
         }
      }
      
      public function clearChildren() : void
      {
         var _loc1_:GameSprite = null;
         while(children.length != 0)
         {
            _loc1_ = children[0];
            _loc1_.destroyAll();
            children.splice(0,1);
         }
      }
      
      public function sort() : void
      {
         children.sort(ZSort.compareZ);
      }
      
      override public function destroy() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < children.length)
         {
            children[_loc1_].componentManager.destroyAll();
            _loc1_++;
         }
         super.destroy();
         clearChildren();
      }
      
      override public function colorFilter(param1:uint = 16777215) : void
      {
         for each(var _loc2_ in owner.children)
         {
            _loc2_.view.colorFilter(param1);
         }
      }
      
      override public function alphaFilter(param1:Number = 1) : void
      {
         for each(var _loc2_ in owner.children)
         {
            _loc2_.view.alphaFilter(param1);
         }
      }
      
      override public function glowEnabled(param1:Boolean) : void
      {
      }
      
      override public function rgbaFilter(param1:uint = 4294967295) : void
      {
         for each(var _loc2_ in children)
         {
            _loc2_.view.rgbaFilter(param1);
         }
      }
      
      public function colorFilterMain(param1:uint = 16777215) : void
      {
         for each(var _loc2_ in children)
         {
            _loc2_.view.colorFilter(param1);
         }
      }
      
      public function alphaFilterMain(param1:Number = 1) : void
      {
         for each(var _loc2_ in children)
         {
            _loc2_.view.alphaFilter(param1);
         }
      }
   }
}


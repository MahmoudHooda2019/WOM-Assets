package wom.model.component.behavior
{
   import peak.cuckoo.core.Behavior;
   import peak.cuckoo.game.attribute.view.CompositeView;
   import wom.model.component.attribute.data.Laser;
   import wom.model.component.attribute.data.Particle3D;
   
   public class LineAnimationManager extends Behavior
   {
      
      public var lines:Vector.<Laser>;
      
      public function LineAnimationManager()
      {
         super();
         lines = new Vector.<Laser>();
      }
      
      override public function init() : void
      {
         super.init();
         startEnabled = false;
      }
      
      override public function update() : void
      {
         var _loc1_:Laser = null;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _loc3_ = lines.length - 1;
         while(_loc3_ >= 0)
         {
            _loc1_ = lines[_loc3_];
            _loc2_ = _loc1_.update();
            if(_loc2_ == 3)
            {
               clearLine(_loc1_);
               lines.splice(_loc3_,1);
               if(lines.length == 0)
               {
                  disable();
               }
            }
            _loc3_--;
         }
      }
      
      public function clearLine(param1:Laser) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Particle3D = param1.lineStrips[0];
         (_loc2_.particleSprite.composite.view as CompositeView).clearChild(_loc2_.particleSprite);
         _loc2_.particleSprite.composite.removeChild(_loc2_.particleSprite);
         _loc2_.particleSprite.destroy();
         _loc3_ = 1;
         while(_loc3_ < param1.lineStrips.length)
         {
            _loc2_ = param1.lineStrips[_loc3_];
            owner.root.layers[4].remove(_loc2_.particleSprite);
            owner.root.removeChild(_loc2_.particleSprite);
            _loc2_.particleSprite.destroy();
            _loc3_++;
         }
         param1.lineStrips = new Vector.<Particle3D>();
      }
      
      public function clearAllLines() : void
      {
         var _loc1_:int = 0;
         _loc1_ = lines.length - 1;
         while(_loc1_ >= 0)
         {
            clearLine(lines[_loc1_]);
            _loc1_++;
         }
         lines = new Vector.<Laser>();
      }
      
      public function newLine(param1:Laser) : void
      {
         lines.push(param1);
         enable();
      }
      
      override public function enable() : void
      {
         super.enable();
      }
   }
}


package wom.model.component.behavior
{
   import peak.cuckoo.core.Behavior;
   import peak.cuckoo.game.behavior.FpsSync;
   import peak.cuckoo.game.behavior.Validator;
   import peak.cuckoo.game.dto.Point3;
   import wom.model.component.entity.gamesprite.Particle;
   
   public class ParticleManager extends Behavior
   {
      
      public static const TYPE_ID:String = "ParticleManager";
      
      private var sync:FpsSync;
      
      private var validator:Validator;
      
      private var particles:Vector.<Particle>;
      
      private var targetPoint:Point3 = new Point3();
      
      public function ParticleManager()
      {
         super();
         particles = new Vector.<Particle>();
      }
      
      override public function get typeId() : String
      {
         return "ParticleManager";
      }
      
      override public function init() : void
      {
         super.init();
         startEnabled = false;
         sync = owner.root.sync;
         validator = owner.root.validator;
      }
      
      override public function update() : void
      {
         var _loc2_:Particle = null;
         var _loc3_:Point3 = null;
         var _loc5_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:int = 0;
         var _loc1_:int = 0;
         if(particles.length == 0)
         {
            disable();
            return;
         }
         _loc9_ = particles.length - 1;
         while(_loc9_ >= 0)
         {
            _loc2_ = particles[_loc9_];
            if(_loc2_.lastPoint)
            {
               removeParticle(_loc2_);
            }
            else
            {
               targetPoint.x = _loc2_.targetPoint.x + _loc2_.targetOffset.x;
               targetPoint.y = _loc2_.targetPoint.y + _loc2_.targetOffset.y;
               _loc5_ = targetPoint.x - _loc2_.startPoint.x;
               _loc4_ = targetPoint.y - _loc2_.startPoint.y;
               _loc3_ = _loc2_.position.projected;
               if(_loc2_.guided || !_loc2_.differenceCalculated)
               {
                  _loc8_ = Math.sqrt(_loc5_ * _loc5_ + _loc4_ * _loc4_);
                  _loc7_ = _loc5_ / _loc8_ * _loc2_.velocityPerFrame * sync.precise;
                  _loc6_ = _loc4_ / _loc8_ * _loc2_.velocityPerFrame * sync.precise;
                  _loc2_.dx = _loc7_;
                  _loc2_.dy = _loc6_;
                  _loc3_.x += _loc7_;
                  _loc3_.y += _loc6_;
                  _loc2_.differenceCalculated = true;
               }
               else
               {
                  _loc3_.x += _loc2_.dx;
                  _loc3_.y += _loc2_.dy;
               }
               validator.add(_loc2_);
               _loc1_ = (_loc3_.x - targetPoint.x) * _loc5_ + (_loc3_.y - targetPoint.y) * _loc4_;
               if(_loc1_ >= 0)
               {
                  _loc2_.lastPoint = true;
                  _loc3_.x = targetPoint.x + Math.random() * 20 - 10;
                  _loc3_.y = targetPoint.y + Math.random() * 20 - 10;
               }
            }
            _loc9_--;
         }
      }
      
      public function throwParticle(param1:Particle) : void
      {
         owner.addChild(param1);
         particles.push(param1);
         param1.init();
         if(param1.testAngle != 0)
         {
            param1.view.rotate(param1.testAngle);
         }
         owner.root.layers[4].add(param1);
         enable();
      }
      
      private function removeParticle(param1:Particle, param2:Boolean = true) : void
      {
         if(param2)
         {
            param1.hit.dispatch();
         }
         owner.root.layers[4].remove(param1);
         owner.removeChild(param1);
         particles.splice(particles.indexOf(param1),1);
         param1.destroy();
      }
      
      override public function destroy() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Particle = null;
         super.destroy();
         _loc2_ = particles.length - 1;
         while(_loc2_ >= 0)
         {
            _loc1_ = particles[_loc2_];
            removeParticle(_loc1_,false);
            _loc2_--;
         }
      }
   }
}


package wom.model.component.behavior
{
   import flash.geom.Point;
   import peak.cuckoo.core.Behavior;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.behavior.FpsSync;
   import peak.cuckoo.game.behavior.animation.ActionAnimation;
   import peak.cuckoo.game.dto.Point3;
   import peak.util.ValidationRecorder;
   import peak.util.ValidationVerifier;
   import wom.model.component.WomGameRoot;
   import wom.model.component.behavior.battle.tower.FiringTower;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.component.entity.gamesprite.Unit;
   
   public class TowerAnimationManager extends Behavior
   {
      
      public static const TYPE_ID:String = "TowerAnimationManager";
      
      private const ANGLE_COEF:Number = 0.017453292519943295;
      
      private var actionAnimation:ActionAnimation;
      
      private var attackMode:Boolean;
      
      private var turnWait:int;
      
      private var sync:FpsSync;
      
      private var towerPosition:Point3;
      
      public var requested:Boolean = true;
      
      public function TowerAnimationManager()
      {
         super();
         priority = 0;
      }
      
      override public function get typeId() : String
      {
         return "TowerAnimationManager";
      }
      
      override public function init() : void
      {
         startEnabled = false;
         super.init();
         actionAnimation = (owner as Building).viewManager.animation as ActionAnimation;
         towerPosition = new Point3((owner as GameSprite).position.point.x + 7,(owner as GameSprite).position.point.y + 7);
         sync = (owner.root as WomGameRoot).sync;
         attackMode = false;
         if(actionAnimation && requested)
         {
            enable();
         }
      }
      
      override public function update() : void
      {
         var _loc1_:int = 0;
         if(!attackMode && actionAnimation)
         {
            turnWait -= sync.elapsed;
            if(turnWait > 0)
            {
               return;
            }
            _loc1_ = (owner.root as WomGameRoot).pseudoRandomGenerator.nextDouble() * 32;
            _loc1_ /= 2;
            actionAnimation.setStopFrame(_loc1_);
            actionAnimation.setForward(!(_loc1_ % 2));
            actionAnimation.animationFinished.addFunctionOnce(startWaiting);
            actionAnimation.startAnimation();
         }
         disable();
      }
      
      private function startWaiting() : void
      {
         turnWait = (owner.root as WomGameRoot).pseudoRandomGenerator.nextDouble() * 90 + 30;
         enable();
      }
      
      public function turn(param1:Point3, param2:FiringTower, param3:Unit) : Boolean
      {
         disable();
         actionAnimation.stopAnimation();
         actionAnimation.animationFinished.removeAll();
         turnWait = 0;
         attackMode = true;
         var _loc5_:int = (Math.atan2(towerPosition.x - param1.x,towerPosition.y - param1.y) / 0.017453292519943295 - 180) / -11.25;
         _loc5_ = _loc5_ / 2;
         if(_loc5_ == actionAnimation.frameNum)
         {
            return true;
         }
         actionAnimation.setStopFrame(_loc5_);
         var _loc4_:int = _loc5_ - actionAnimation.frameNum;
         actionAnimation.setForward((_loc4_ < 0 ? _loc4_ + 32 : _loc4_) < 16);
         actionAnimation.animationFinished.addOnce(new AnimationFinishedHandler(param2,param3));
         actionAnimation.startAnimation();
         return false;
      }
      
      public function immediateTurn(param1:Point) : void
      {
         disable();
         actionAnimation.stopAnimation();
         actionAnimation.animationFinished.removeAll();
         turnWait = 0;
         attackMode = true;
         var _loc2_:int = (Math.atan2(towerPosition.x - param1.x,towerPosition.y - param1.y) / 0.017453292519943295 - 180) / -11.25;
         _loc2_ /= 2;
         actionAnimation.setFrame(_loc2_);
      }
      
      public function immediateTurnToFrame(param1:int) : void
      {
         disable();
         actionAnimation.stopAnimation();
         actionAnimation.animationFinished.removeAll();
         turnWait = 0;
         attackMode = true;
         actionAnimation.setFrame(param1);
      }
      
      public function exitAttackMode() : void
      {
         attackMode = false;
      }
      
      public function getLastSide() : int
      {
         return actionAnimation.frameNum;
      }
      
      public function pauseTurning() : void
      {
         disable();
         if(actionAnimation)
         {
            actionAnimation.disable();
            actionAnimation.animationFinished.removeAll();
         }
      }
      
      public function resetAnimationForBattle() : void
      {
         var _loc1_:Number = (owner.root as WomGameRoot).pseudoRandomGenerator.nextDouble();
         _loc1_ /= 2;
         disable();
         actionAnimation.stopAnimation();
         actionAnimation.animationFinished.removeAll();
         turnWait = 0;
         attackMode = false;
         actionAnimation.setFrame(_loc1_);
         enable();
      }
   }
}

import peak.signal.Slot0;
import wom.model.component.behavior.battle.tower.FiringTower;
import wom.model.component.entity.gamesprite.Unit;

class AnimationFinishedHandler implements Slot0
{
   
   public var tower:FiringTower;
   
   public var targetUnit:Unit;
   
   public function AnimationFinishedHandler(param1:FiringTower, param2:Unit)
   {
      super();
      this.tower = param1;
      this.targetUnit = param2;
   }
   
   public function onSignal0() : void
   {
      tower.fire(targetUnit);
   }
}

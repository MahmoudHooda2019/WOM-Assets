package wom.model.component.behavior.battle.visuals
{
   import peak.cuckoo.core.Behavior;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.Layer;
   import peak.cuckoo.game.attribute.Position;
   import peak.cuckoo.game.attribute.projection.IsoOffsetProjection;
   import peak.cuckoo.game.attribute.view.AnimationAssetView;
   import peak.cuckoo.game.attribute.view.LoadingAssetView;
   import peak.cuckoo.game.behavior.animation.ActionAnimation;
   import peak.cuckoo.game.dto.Point3;
   import wom.model.component.WomGameRoot;
   import wom.model.component.behavior.battle.BattleManager;
   import wom.model.component.entity.gamesprite.Drop;
   
   public class BattleEffects extends Behavior
   {
      
      public static const TYPE_ID:String = "BattleFieldControl";
      
      private var battleManager:BattleManager;
      
      private var womRoot:WomGameRoot;
      
      private var drops:Vector.<Drop>;
      
      public function BattleEffects(param1:BattleManager)
      {
         super();
         this.battleManager = param1;
         womRoot = param1.owner.root as WomGameRoot;
         startEnabled = false;
         drops = new Vector.<Drop>();
      }
      
      override public function get typeId() : String
      {
         return "BattleFieldControl";
      }
      
      public function addExplosion(param1:Point3) : void
      {
         var _loc5_:GameSprite = new GameSprite();
         var _loc4_:ActionAnimation = new womRoot.render.renderSpecificActionAnimation(5,57);
         _loc5_.componentManager.add(_loc4_);
         _loc5_.componentManager.add(_loc5_.view = new AnimationAssetView("U14Explosion",4));
         _loc5_.componentManager.add(_loc5_.position = new Position(new Point3(param1.x,param1.y)));
         var _loc6_:IsoOffsetProjection = new IsoOffsetProjection();
         _loc5_.componentManager.add(_loc6_);
         _loc4_.animationFinished.add(new AnimationFinishedHandler(womRoot,_loc5_));
         womRoot.addChild(_loc5_);
         _loc6_.offset = new Point3(-38,-55);
         _loc5_.init();
         _loc4_.setStartFrame(0);
         _loc4_.setStopFrame(0);
         womRoot.layers[4].add(_loc5_);
         _loc4_.startAnimation();
         var _loc3_:GameSprite = new GameSprite();
         _loc3_.componentManager.add(_loc3_.position = new Position(new Point3(param1.x,param1.y)));
         var _loc2_:IsoOffsetProjection = new IsoOffsetProjection();
         _loc3_.componentManager.add(_loc2_);
         _loc2_.offset = new Point3(-22,-23);
         _loc3_.componentManager.add(_loc3_.view = new LoadingAssetView(2,womRoot.assetRepository.getBitmapAssetReference("B32Crater"),"B32Crater"));
         womRoot.addChild(_loc3_);
         _loc3_.init();
      }
      
      public function addFoamAnimation(param1:int, param2:int) : void
      {
         var _loc3_:Drop = new Drop(womRoot,new Point3(param1,param2),new Point3(),"AcidRainFoam2");
         womRoot.addChild(_loc3_);
         _loc3_.view.layerId = 2;
         _loc3_.init();
         (womRoot.layers[2] as Layer).add(_loc3_);
         drops.push(_loc3_);
         _loc3_.state = 2;
         _loc3_.velocity = 0;
         _loc3_.dx = 0;
         enable();
      }
      
      override public function update() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Drop = null;
         _loc2_ = drops.length - 1;
         while(_loc2_ >= 0)
         {
            _loc1_ = drops[_loc2_];
            switch(int(_loc1_.state) - 2)
            {
               case 0:
                  _loc1_.dx += womRoot.sync.precise;
                  if(_loc1_.dx >= 30)
                  {
                     _loc1_.view.scaleFixed(1);
                     _loc1_.velocity = 0;
                     _loc1_.dx = 0;
                     _loc1_.state = 3;
                  }
                  else
                  {
                     _loc1_.view.scaleFixed(_loc1_.dx / 30);
                  }
                  break;
               case 1:
                  _loc1_.dx += womRoot.sync.precise;
                  if(_loc1_.dx >= 180)
                  {
                     drops.splice(_loc2_,1);
                     (womRoot.layers[2] as Layer).remove(_loc1_);
                     womRoot.removeChild(_loc1_);
                     _loc1_.destroy();
                  }
                  else
                  {
                     _loc1_.view.alphaFilter(1 - _loc1_.dx / 180);
                  }
            }
            _loc2_--;
         }
         if(drops.length <= 0)
         {
            disable();
         }
      }
   }
}

import peak.cuckoo.game.GameSprite;
import peak.cuckoo.game.Root;
import peak.signal.Slot0;

class AnimationFinishedHandler implements Slot0
{
   
   public var womRoot:Root;
   
   public var explosion:GameSprite;
   
   public function AnimationFinishedHandler(param1:Root, param2:GameSprite)
   {
      super();
      this.womRoot = param1;
      this.explosion = param2;
   }
   
   public function onSignal0() : void
   {
      womRoot.layers[4].remove(explosion);
      womRoot.destroyChild(explosion);
   }
}

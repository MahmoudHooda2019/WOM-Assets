package wom.model.component.behavior.catapult
{
   import flash.geom.Point;
   import flash.media.Sound;
   import peak.cuckoo.core.Behavior;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.attribute.Position;
   import peak.cuckoo.game.attribute.projection.IsoProjection;
   import peak.cuckoo.game.attribute.view.AssetView;
   import peak.cuckoo.game.behavior.FpsSync;
   import peak.cuckoo.game.dto.Point3;
   import wom.model.component.WomGameRoot;
   import wom.model.component.attribute.SfxManager;
   import wom.model.component.attribute.projection.ProjectileProjection;
   import wom.model.component.behavior.battle.BattleManager;
   import wom.model.component.structure.SoundChannelContainer;
   import wom.model.domain.domaininfoobject.CatapultTypeDIO;
   import wom.model.dto.combat.CatapultInfo;
   
   public class BaseCatapult extends Behavior
   {
      
      public static const TYPE_ID:String = "BaseCatapult";
      
      public var radius:int;
      
      protected var womRoot:WomGameRoot;
      
      protected var battleManager:BattleManager;
      
      protected var sync:FpsSync;
      
      protected var catapultInfo:CatapultInfo;
      
      protected var catapultDIO:CatapultTypeDIO;
      
      protected var position:Point3;
      
      protected var duration:Number;
      
      protected var sfx:SfxManager;
      
      protected var catapultSound:Sound;
      
      protected var soundContainer:SoundChannelContainer;
      
      private var deployCircle:GameSprite;
      
      private var deployGlowCricle:GameSprite;
      
      public function BaseCatapult(param1:BattleManager, param2:CatapultInfo)
      {
         super();
         priority = 0;
         this.battleManager = param1;
         this.catapultInfo = param2;
      }
      
      override public function get typeId() : String
      {
         return "BaseCatapult";
      }
      
      override public function init() : void
      {
         super.init();
         womRoot = owner.root as WomGameRoot;
         sync = womRoot.sync;
         sfx = womRoot.sfxManager;
         catapultDIO = womRoot.domainInfo.getCatapults()[catapultInfo.type] as CatapultTypeDIO;
         duration = catapultDIO.activationTimesPerStage[catapultInfo.size];
         radius = catapultDIO.rangesPerStaqe[catapultInfo.size] / 10;
         startEnabled = false;
      }
      
      override public function update() : void
      {
      }
      
      override protected function start() : void
      {
         super.start();
         if(catapultSound)
         {
            soundContainer = sfx.catapultActivate(catapultSound);
         }
      }
      
      override protected function stop() : void
      {
         super.stop();
         if(soundContainer)
         {
            sfx.catapultFinished(soundContainer);
            soundContainer = null;
         }
         battleManager.catapultManager2.removeActiveCatapult(owner);
      }
      
      public function collideDeployCircle(param1:Point3) : void
      {
      }
      
      public function deployCatapult(param1:Point) : void
      {
         position = new Point3();
         womRoot.projection.reverse(param1,position);
         position.x >>= 0;
         position.y >>= 0;
         collideDeployCircle(position);
         resetCollusionFilters();
      }
      
      protected function drawEffectAreaCircle() : void
      {
         if(deployCircle)
         {
            return;
         }
         var _loc1_:Number = (womRoot.projection as IsoProjection).pitchX * radius * Math.sqrt(2);
         var _loc2_:Point3 = new Point3();
         (womRoot.projection as IsoProjection).transform(position,_loc2_);
         _loc2_.x -= _loc1_ / 2;
         _loc2_.y -= _loc1_ / 4;
         var _loc3_:String = "CatapultCircle" + catapultInfo.type;
         _loc3_ = "CatapultCircle3";
         deployCircle = new GameSprite();
         deployCircle.componentManager.add(deployCircle.view = new AssetView(2,_loc3_,true));
         deployCircle.componentManager.add(new ProjectileProjection());
         deployCircle.componentManager.add(deployCircle.position = new Position(_loc2_));
         deployCircle.componentManager.add(new DeployCircleFloor(_loc1_,catapultInfo.type));
         womRoot.addChild(deployCircle);
         deployCircle.init();
         deployCircle.position.projected.x = _loc2_.x;
         deployCircle.position.projected.y = _loc2_.y;
         deployCircle.bounds.update();
         womRoot.layers[2].add(deployCircle);
         deployGlowCricle = new GameSprite();
         deployGlowCricle.componentManager.add(deployGlowCricle.view = new AssetView(4,_loc3_,true));
         deployGlowCricle.componentManager.add(new ProjectileProjection());
         deployGlowCricle.componentManager.add(deployGlowCricle.position = new Position(_loc2_));
         deployGlowCricle.componentManager.add(new DeployCircleGlow(_loc1_,_loc2_.y,catapultInfo.type));
         womRoot.addChild(deployGlowCricle);
         deployGlowCricle.init();
         deployGlowCricle.position.projected.x = _loc2_.x;
         deployGlowCricle.position.projected.y = _loc2_.y;
         deployGlowCricle.bounds.update();
         womRoot.layers[4].add(deployGlowCricle);
      }
      
      protected function removeEffectAreaCircle() : void
      {
         if(deployCircle)
         {
            womRoot.layers[2].remove(deployCircle);
            deployCircle.parent && deployCircle.parent.destroyChild(deployCircle);
         }
         if(deployGlowCricle)
         {
            womRoot.layers[4].remove(deployGlowCricle);
            deployGlowCricle.parent && deployGlowCricle.parent.destroyChild(deployGlowCricle);
         }
      }
      
      public function resetCollusionFilters() : void
      {
      }
      
      override public function destroy() : void
      {
         resetCollusionFilters();
         super.destroy();
      }
   }
}


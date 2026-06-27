package wom.model.component.entity.gamesprite
{
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.behavior.animation.StateDirectionAnimation;
   import wom.model.component.attribute.data.UnitData;
   import wom.model.component.attribute.viewManager.UnitViewManager;
   import wom.model.component.behavior.battle.attack.UnitAttackManager;
   import wom.model.component.behavior.battle.defensive.DefensiveUnit;
   import wom.model.component.behavior.battle.hit.BaseHit;
   import wom.model.component.behavior.battle.underatack.UnderAttackUnit;
   import wom.model.component.behavior.movement.Movement;
   
   public class Unit extends GameSprite
   {
      
      public var isBeast:Boolean;
      
      public var data:UnitData;
      
      public var viewManager:UnitViewManager;
      
      public var underAttack:UnderAttackUnit;
      
      public var attack:UnitAttackManager;
      
      public var movement:Movement;
      
      public var animation:StateDirectionAnimation;
      
      public var defence:DefensiveUnit;
      
      public var aboutToBeKicked:Boolean = false;
      
      public var hit:BaseHit;
      
      public function Unit()
      {
         super();
      }
      
      override public function destroy() : void
      {
         super.destroy();
         data = null;
         viewManager = null;
         underAttack = null;
         attack = null;
         movement = null;
         animation = null;
         defence = null;
         hit = null;
      }
   }
}


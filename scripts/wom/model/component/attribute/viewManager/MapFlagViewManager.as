package wom.model.component.attribute.viewManager
{
   import peak.cuckoo.core.Attribute;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.attribute.Position;
   import peak.cuckoo.game.attribute.bounds.compositeBased.CompositeChildRenderBounds;
   import peak.cuckoo.game.attribute.bounds.compositeBased.CompositeRenderBounds;
   import peak.cuckoo.game.attribute.projection.BaseProjection;
   import peak.cuckoo.game.attribute.view.AssetView;
   import peak.cuckoo.game.attribute.view.CompositeView;
   import peak.cuckoo.game.dto.Point3;
   import wom.model.component.WomCampaignRoot;
   import wom.model.component.WomMapRoot;
   import wom.model.component.attribute.view.MapFlagLevelView;
   import wom.model.component.attribute.view.MapFlagNameView;
   import wom.model.component.attribute.view.MapFlagTokenView;
   import wom.model.component.attribute.view.MapFlagView;
   import wom.model.component.entity.gamesprite.MapFlag;
   import wom.model.configuration.WomDocumentConfiguration;
   import wom.model.game.Profile;
   import wom.model.resource.WomAssetRepository;
   
   public class MapFlagViewManager extends Attribute
   {
      
      private var compositeView:CompositeView;
      
      private var ownerTile:MapFlag;
      
      private var assetRepository:WomAssetRepository;
      
      private var documentConfiguration:WomDocumentConfiguration;
      
      private var levelView:GameSprite;
      
      private var avatarView:GameSprite;
      
      private var nameView:GameSprite;
      
      private var tokenView:GameSprite;
      
      private var visibleName:String = null;
      
      private var _pictureProfile:Profile;
      
      public var mainVisual:GameSprite;
      
      public var culled:Boolean = true;
      
      public function MapFlagViewManager(param1:MapFlag, param2:Profile = null)
      {
         super();
         param1.componentManager.add(param1.view = new CompositeView());
         compositeView = param1.view as CompositeView;
         param1.composite = param1;
         param1.componentManager.add(param1.bounds = new CompositeRenderBounds());
         _pictureProfile = param2;
      }
      
      override public function init() : void
      {
         if(initialized)
         {
            return;
         }
         super.init();
         ownerTile = owner as MapFlag;
         assetRepository = (owner.root is WomMapRoot ? owner.root as WomMapRoot : owner.root as WomCampaignRoot).assetRepository;
         documentConfiguration = (owner.root is WomMapRoot ? owner.root as WomMapRoot : owner.root as WomCampaignRoot).documentConfiguration;
         if(owner.root is WomCampaignRoot)
         {
            culled = false;
         }
         addMainVisual();
         addAvatar(_pictureProfile);
         if(!ownerTile.data.mapMemberInfo.profile.isNpc || ownerTile.data.mapMemberInfo.isEventNpc)
         {
            addLevel();
            addAllianceToken();
         }
         addName(visibleName != null ? visibleName : ownerTile.data.mapMemberInfo.profile.gameId);
      }
      
      private function addMainVisual() : void
      {
         mainVisual = new GameSprite();
         mainVisual.composite = ownerTile;
         mainVisual.componentManager.add(mainVisual.position = new Position(new Point3(9,8,0)));
         mainVisual.componentManager.add(mainVisual.view = new MapFlagView(ownerTile.data,assetRepository));
         mainVisual.componentManager.add(new BaseProjection());
         mainVisual.componentManager.add(mainVisual.bounds = new CompositeChildRenderBounds());
         owner.addChild(mainVisual);
         mainVisual.init();
         compositeView.addChild(mainVisual);
      }
      
      private function addLevel() : void
      {
         if(!levelView && !culled)
         {
            levelView = new GameSprite();
            levelView.composite = ownerTile;
            levelView.componentManager.add(levelView.position = new Position(new Point3(20,30,2)));
            levelView.componentManager.add(levelView.view = new MapFlagLevelView(ownerTile.data,assetRepository));
            levelView.componentManager.add(new BaseProjection());
            levelView.componentManager.add(levelView.bounds = new CompositeChildRenderBounds());
            owner.addChild(levelView);
            levelView.init();
            compositeView.addChild(levelView);
         }
      }
      
      public function removeLevel() : void
      {
         if(levelView)
         {
            compositeView.clearChild(levelView);
            owner.destroyChild(levelView);
            levelView = null;
         }
      }
      
      private function addAvatar(param1:Profile = null) : void
      {
         var _loc4_:Profile = null;
         var _loc3_:String = null;
         var _loc2_:String = null;
         if(!avatarView && !culled)
         {
            avatarView = new GameSprite();
            avatarView.composite = ownerTile;
            avatarView.componentManager.add(avatarView.position = new Position(new Point3(25,ownerTile.data.mapMemberInfo.profile.isNpc ? 43 : 39,1)));
            _loc4_ = param1 != null ? param1 : ownerTile.data.mapMemberInfo.profile;
            _loc3_ = _loc4_.isNpc ? _loc4_.npcClan : _loc4_.platformId;
            switch(_loc3_)
            {
               case "NPC_1":
                  _loc2_ = "ShriekingDragonMap";
                  break;
               case "NPC_2":
                  _loc2_ = "RagingBullMap";
                  break;
               case "NPC_3":
                  _loc2_ = "DemonKingMap";
                  break;
               case "NPC_4":
                  _loc2_ = "IronHandMap";
                  break;
               case "NPC_5":
                  _loc2_ = "GermanicHunterAvatar";
                  break;
               case "NPC-6":
                  _loc2_ = documentConfiguration.eventAvatarImageName;
                  break;
               case "NPC_D":
                  _loc2_ = "TutorialDefenderIcon";
            }
            avatarView.componentManager.add(avatarView.view = new AssetView(3,_loc2_));
            avatarView.componentManager.add(new BaseProjection());
            avatarView.componentManager.add(avatarView.bounds = new CompositeChildRenderBounds());
            owner.addChild(avatarView);
            avatarView.init();
            compositeView.addChild(avatarView);
         }
      }
      
      public function removeAvatar() : void
      {
         if(avatarView)
         {
            compositeView.clearChild(avatarView);
            owner.destroyChild(avatarView);
            avatarView = null;
         }
      }
      
      public function updateAvatar(param1:Profile = null) : void
      {
         removeAvatar();
         addAvatar(param1);
      }
      
      private function addName(param1:String) : void
      {
         if(!nameView && !culled)
         {
            nameView = new GameSprite();
            nameView.composite = ownerTile;
            nameView.componentManager.add(nameView.position = new Position(new Point3(15,89,3)));
            nameView.componentManager.add(nameView.view = new MapFlagNameView(ownerTile.data,param1));
            nameView.componentManager.add(new BaseProjection());
            nameView.componentManager.add(nameView.bounds = new CompositeChildRenderBounds());
            owner.addChild(nameView);
            nameView.init();
            compositeView.addChild(nameView);
         }
      }
      
      public function removeName() : void
      {
         if(nameView)
         {
            compositeView.clearChild(nameView);
            owner.destroyChild(nameView);
            nameView = null;
         }
      }
      
      public function updateName(param1:String) : void
      {
         visibleName = param1;
         removeName();
         addName(param1);
      }
      
      private function addAllianceToken() : void
      {
         if(!tokenView && !culled && ownerTile.data.mapMemberInfo.alliance)
         {
            tokenView = new GameSprite();
            tokenView.composite = ownerTile;
            tokenView.componentManager.add(tokenView.position = new Position(new Point3(62,35,2)));
            tokenView.componentManager.add(tokenView.view = new MapFlagTokenView(ownerTile.data,assetRepository));
            tokenView.componentManager.add(new BaseProjection());
            tokenView.componentManager.add(tokenView.bounds = new CompositeChildRenderBounds());
            owner.addChild(tokenView);
            tokenView.init();
            compositeView.addChild(tokenView);
         }
      }
      
      public function removeAllianceToken() : void
      {
         if(tokenView)
         {
            compositeView.clearChild(tokenView);
            owner.destroyChild(tokenView);
            tokenView = null;
         }
      }
      
      override public function destroy() : void
      {
         removeAllianceToken();
         removeLevel();
         removeAvatar();
         removeName();
         super.destroy();
      }
   }
}


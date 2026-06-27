package wom.view.ui
{
   import com.greensock.TweenMax;
   import flash.geom.Point;
   import peak.display.View;
   import starling.display.Sprite;
   import wom.view.ui.tutorial.mobile.MobileDeployHandView;
   
   public class MobileWomCuckooUILayer extends Sprite implements View
   {
      
      public static const EVENT_TYPE_FAKE_DEPLOY_CIRCLE:String = "fakeDeployCircle";
      
      private var buildingOptionsPanel:MobileCanvasOptionsPanel;
      
      private var _deployHand:MobileDeployHandView;
      
      public function MobileWomCuckooUILayer()
      {
         super();
      }
      
      public function init() : void
      {
      }
      
      public function initLayout() : void
      {
      }
      
      public function drawLayout() : void
      {
      }
      
      public function showBuildingOptionsPanel(param1:MobileCanvasOptionsPanel) : void
      {
         closeBuildingOptionsPanel();
         addChild(buildingOptionsPanel = param1);
         buildingOptionsPanel.x = 200;
         buildingOptionsPanel.y = 200;
      }
      
      public function closeBuildingOptionsPanel() : void
      {
         if(buildingOptionsPanel && contains(buildingOptionsPanel))
         {
            removeChild(buildingOptionsPanel);
         }
      }
      
      private function deployHandAnimationStep1() : void
      {
         TweenMax.to(_deployHand,0.6,{
            "x":-360,
            "y":50,
            "onComplete":deployHandAnimationStep1Complete
         });
      }
      
      private function deployHandAnimationStep1Complete() : void
      {
         var _loc1_:Point = new Point(-361,57);
         dispatchEventWith("fakeDeployCircle",false,{"point":_loc1_});
         TweenMax.to(_deployHand,0.1,{
            "x":_loc1_.x,
            "y":_loc1_.y,
            "repeat":1,
            "yoyo":true,
            "repeatDelay":0.1,
            "onComplete":deployHandAnimationStep2
         });
      }
      
      private function deployHandAnimationStep2() : void
      {
         TweenMax.to(_deployHand,0.6,{
            "x":-200,
            "y":0,
            "onComplete":deployHandAnimationStep2Complete
         });
      }
      
      private function deployHandAnimationStep2Complete() : void
      {
         var _loc1_:Point = new Point(-201,7);
         dispatchEventWith("fakeDeployCircle",false,{"point":_loc1_});
         TweenMax.to(_deployHand,0.1,{
            "x":_loc1_.x,
            "y":_loc1_.y,
            "repeat":1,
            "yoyo":true,
            "repeatDelay":0.1,
            "onComplete":deployHandAnimationStep3
         });
      }
      
      private function deployHandAnimationStep3() : void
      {
         TweenMax.to(_deployHand,0.6,{
            "x":-450,
            "y":-50,
            "onComplete":deployHandAnimationStep3Complete
         });
      }
      
      private function deployHandAnimationStep3Complete() : void
      {
         var _loc1_:Point = new Point(-451,-43);
         dispatchEventWith("fakeDeployCircle",false,{"point":_loc1_});
         TweenMax.to(_deployHand,0.1,{
            "x":_loc1_.x,
            "y":_loc1_.y,
            "repeat":1,
            "yoyo":true,
            "repeatDelay":0.1,
            "onComplete":deployHandAnimationStep1
         });
      }
      
      public function showDeployHand(param1:MobileDeployHandView) : void
      {
         hideDeployHand();
         _deployHand = param1;
         addChild(_deployHand);
         _deployHand.x = -450;
         _deployHand.y = -50;
         deployHandAnimationStep3Complete();
      }
      
      public function hideDeployHand() : void
      {
         if(_deployHand && contains(_deployHand))
         {
            TweenMax.killTweensOf(_deployHand);
            removeChild(_deployHand);
         }
         _deployHand = null;
      }
   }
}


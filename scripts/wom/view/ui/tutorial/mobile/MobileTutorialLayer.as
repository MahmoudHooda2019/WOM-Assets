package wom.view.ui.tutorial.mobile
{
   import com.greensock.TweenMax;
   import feathers.textures.Scale9Textures;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import peak.component.mobile.MPTextField;
   import peak.display.View;
   import peak.starling.FlatteningSprite;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.game.tutorial.TutorialArrowDirection;
   import wom.model.game.tutorial.TutorialFocusedObject;
   import wom.model.game.tutorial.TutorialInfo;
   import wom.model.game.tutorial.TutorialListInfo;
   import wom.model.game.tutorial.TutorialState;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileWomTextField;
   import wom.view.getWomTextFormat;
   
   public class MobileTutorialLayer extends Sprite implements View
   {
      
      public static const ZERO_POINT:Point = new Point();
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _visibleWidth:int;
      
      private var _visibleHeight:int;
      
      private var _mask:MobileTutorialMaskContainer;
      
      private var _areaToBePointed:Rectangle;
      
      private var _tutorialWindow:MobileGenericTutorialWindow;
      
      private var _arrows:Vector.<DisplayObject>;
      
      private var _tutorialsInfo:TutorialListInfo;
      
      private var _currentTutorial:TutorialInfo;
      
      private var _currentState:TutorialState;
      
      private var _currentStateTextField:MPTextField;
      
      private var _keepAliveTimer:Timer;
      
      private var _focusedObject:TutorialFocusedObject;
      
      public function MobileTutorialLayer()
      {
         super();
         _visibleWidth = Starling.current.stage.stageWidth;
         _visibleHeight = Starling.current.stage.stageHeight;
         _keepAliveTimer = new Timer(60000);
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         var _loc1_:DisplayObject = null;
         _areaToBePointed = null;
         _currentTutorial = null;
         _currentState = null;
         _mask = new MobileTutorialMaskContainer(new Scale9Textures(assetRepository.getTexture("TutorMaskM"),new Rectangle(11,11,1,1)));
         addChild(_mask);
         _tutorialWindow = new MobileGenericTutorialWindow();
         _tutorialWindow.visible = false;
         addChild(_tutorialWindow);
         _arrows = new Vector.<DisplayObject>();
         _arrows.push(assetRepository.getDisplayObject("TutorialArrowLeftRightM"));
         _arrows.push(assetRepository.getDisplayObject("TutorialArrowUpM"));
         _loc1_ = assetRepository.getDisplayObject("TutorialArrowLeftRightM");
         _loc1_.scaleX = -1;
         _arrows.push(_loc1_);
         _arrows.push(assetRepository.getDisplayObject("TutorialArrowDownM"));
         for each(_loc1_ in _arrows)
         {
            _loc1_.visible = false;
            addChild(_loc1_);
         }
      }
      
      public function drawLayout() : void
      {
         var _loc1_:DisplayObject = null;
         if(_mask != null)
         {
            if(_tutorialsInfo != null && _tutorialsInfo.enabled && _currentState != null)
            {
               _tutorialWindow.visible = _currentState.window.enabled;
               hideAllArrows();
               if(_areaToBePointed != null)
               {
                  switch(_currentState.pointedArea.arrowDirection)
                  {
                     case TutorialArrowDirection.RIGHT:
                        _loc1_ = _arrows[0];
                        _loc1_.x = _areaToBePointed.x + _areaToBePointed.width + _currentState.pointedArea.arrowMarginX;
                        _loc1_.y = _areaToBePointed.y + (_areaToBePointed.height - _loc1_.height) / 2 + _currentState.pointedArea.arrowMarginY;
                        _loc1_.visible = true;
                        TweenMax.to(_loc1_,0.55,{
                           "x":"25",
                           "repeat":-1,
                           "yoyo":true,
                           "overwrite":1
                        });
                        break;
                     case TutorialArrowDirection.BOTTOM:
                        _loc1_ = _arrows[1];
                        _loc1_.x = _areaToBePointed.x + (_areaToBePointed.width - _loc1_.width) / 2 + _currentState.pointedArea.arrowMarginX;
                        _loc1_.y = _areaToBePointed.y + _areaToBePointed.height + _currentState.pointedArea.arrowMarginY;
                        _loc1_.visible = true;
                        TweenMax.to(_loc1_,0.55,{
                           "y":"25",
                           "repeat":-1,
                           "yoyo":true,
                           "overwrite":1
                        });
                        break;
                     case TutorialArrowDirection.LEFT:
                        _loc1_ = _arrows[2];
                        _loc1_.x = _areaToBePointed.x + _currentState.pointedArea.arrowMarginX;
                        _loc1_.y = _areaToBePointed.y + (_areaToBePointed.height - _loc1_.height) / 2 + _currentState.pointedArea.arrowMarginY;
                        _loc1_.visible = true;
                        TweenMax.to(_loc1_,0.55,{
                           "x":"-25",
                           "repeat":-1,
                           "yoyo":true,
                           "overwrite":1
                        });
                        break;
                     case TutorialArrowDirection.TOP:
                        _loc1_ = _arrows[3];
                        _loc1_.x = _areaToBePointed.x + (_areaToBePointed.width - _loc1_.width) / 2 + _currentState.pointedArea.arrowMarginX;
                        _loc1_.y = _areaToBePointed.y - _loc1_.height + _currentState.pointedArea.arrowMarginY;
                        _loc1_.visible = true;
                        TweenMax.to(_loc1_,0.55,{
                           "y":"-25",
                           "repeat":-1,
                           "yoyo":true,
                           "overwrite":1
                        });
                  }
               }
               if(_currentState.mask.enabled)
               {
                  _mask.update(_currentState.mask,_focusedObject == null ? _areaToBePointed : null);
                  _mask.visible = true;
               }
               else
               {
                  _mask.visible = false;
               }
               if(_currentStateTextField != null && contains(_currentStateTextField))
               {
                  _currentStateTextField.text = "T" + _currentState.id;
                  _currentStateTextField.x = _visibleWidth - _currentStateTextField.width - 9;
                  _currentStateTextField.y = 200;
                  _currentStateTextField.visible = _currentState.id != "-1";
               }
            }
            else
            {
               _mask.visible = false;
               _tutorialWindow.visible = false;
               hideAllArrows();
               hideFocusedObject();
            }
         }
      }
      
      private function hideAllArrows() : void
      {
         for each(var _loc1_ in _arrows)
         {
            _loc1_.visible = false;
            TweenMax.killTweensOf(_loc1_);
         }
      }
      
      private function hideFocusedObject() : void
      {
         if(_focusedObject != null)
         {
            _focusedObject.displayObjectContainer.addChildAt(removeChild(_focusedObject.displayObject),_focusedObject.index);
            _focusedObject.displayObject.x = _focusedObject.position.x;
            _focusedObject.displayObject.y = _focusedObject.position.y;
            if(_focusedObject.displayObjectContainer is FlatteningSprite)
            {
               FlatteningSprite(_focusedObject.displayObjectContainer).flatten();
            }
            _focusedObject = null;
         }
      }
      
      public function updateWithTutorialInfo(param1:TutorialInfo) : void
      {
         _currentTutorial = param1;
         _currentState = _tutorialWindow.updateWithTutorialInfo(param1);
         _areaToBePointed = _currentState != null && _currentState.pointedArea.enabled ? _currentState.pointedArea.rect.clone() : null;
         updateWithAlignmentReferencePosition(ZERO_POINT);
         if(_currentState != null && _currentState.pointedArea.enabled)
         {
            _tutorialWindow.getReferencePosition(_currentState.pointedArea.alignmentReference,2,_currentState.additionalInfo);
         }
      }
      
      public function get tutorialWindow() : MobileGenericTutorialWindow
      {
         return _tutorialWindow;
      }
      
      public function get currentTutorial() : TutorialInfo
      {
         return _currentTutorial;
      }
      
      public function set currentTutorial(param1:TutorialInfo) : void
      {
         _currentTutorial = param1;
      }
      
      public function updateTutorialsInfo(param1:TutorialListInfo) : void
      {
         _tutorialsInfo = param1;
      }
      
      public function updateWithAlignmentReferencePosition(param1:Point, param2:DisplayObject = null) : void
      {
         var _loc3_:Point = null;
         hideFocusedObject();
         if(_currentState != null && _currentState.pointedArea.enabled && _areaToBePointed != null)
         {
            if(param2 != null)
            {
               _focusedObject = new TutorialFocusedObject(param2);
               _loc3_ = _focusedObject.displayObject.localToGlobal(new Point());
               addChildAt(_focusedObject.displayObjectContainer.removeChild(_focusedObject.displayObject),this.getChildIndex(_mask) + 1);
               _focusedObject.displayObject.x = _loc3_.x;
               _focusedObject.displayObject.y = _loc3_.y;
               _areaToBePointed = _focusedObject.displayObject.bounds;
            }
            else
            {
               _areaToBePointed.x = _currentState.pointedArea.rect.x + param1.x;
               _areaToBePointed.y = _currentState.pointedArea.rect.y + param1.y;
            }
         }
         drawLayout();
      }
      
      public function get currentState() : TutorialState
      {
         return _currentState;
      }
      
      public function set currentState(param1:TutorialState) : void
      {
         _currentState = param1;
      }
      
      public function get visibleWidth() : int
      {
         return _visibleWidth;
      }
      
      public function get visibleHeight() : int
      {
         return _visibleHeight;
      }
      
      public function get keepAliveTimer() : Timer
      {
         return _keepAliveTimer;
      }
   }
}


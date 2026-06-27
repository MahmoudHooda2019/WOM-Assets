package wom.model.resource
{
   import feathers.controls.Button;
   import feathers.controls.popups.DropDownPopUpContentManager;
   import feathers.controls.text.ITextEditorViewPort;
   import feathers.controls.text.TextFieldTextEditor;
   import feathers.controls.text.TextFieldTextEditorViewPort;
   import feathers.core.DisplayListWatcher;
   import feathers.core.FeathersControl;
   import feathers.core.ITextRenderer;
   import feathers.display.Scale3Image;
   import feathers.display.Scale9Image;
   import feathers.layout.VerticalLayout;
   import feathers.skins.SmartDisplayObjectStateValueSelector;
   import feathers.textures.Scale3Textures;
   import feathers.textures.Scale9Textures;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import peak.component.mobile.MPBitmapFontTextRenderer;
   import peak.component.mobile.MPList;
   import peak.component.mobile.MPPickerList;
   import peak.component.mobile.MPRigidButton;
   import peak.i18n.PText;
   import peak.logging.log;
   import peak.resource.asset.core.MobileFacebookPicture;
   import peak.resource.asset.core.MobileRemoteDisplayObjectContainer;
   import peak.resource.atlas.AtlasManager;
   import peak.resource.atlas.starling.StarlingAtlasManager;
   import peak.starling.InflatedBoundsImage;
   import peak.starling.StarlingAssetManager;
   import peak.util.passParameters;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.Image;
   import starling.display.Quad;
   import starling.events.Event;
   import starling.textures.Texture;
   import starling.textures.TextureAtlas;
   import wom.Environment;
   import wom.model.configuration.WomDocumentConfiguration;
   import wom.model.game.Profile;
   import wom.service.logging.WomLoggerContexts;
   import wom.view.component.MobileWomCheckBox;
   import wom.view.component.MobileWomTabBar;
   import wom.view.component.MobileWomTabButton;
   import wom.view.component.MobileWomTextArea;
   import wom.view.component.MobileWomTextFieldTextEditor;
   import wom.view.component.MobileWomTextFormats;
   import wom.view.component.MobileWomTextInput;
   import wom.view.component.MobileWomToggleSwitch;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.button.MobileWomMenuButton;
   import wom.view.component.progressbar.MobileWomProgressBar;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   import wom.view.screen.MobileManualAuthenticationItemRenderer;
   
   public class MobileWomDefaultAssetRepository extends DisplayListWatcher implements MobileWomAssetRepository
   {
      
      private static const SCALE9:String = "feathers.display.Scale9Image";
      
      private static const SCALE3:String = "feathers.display.Scale3Image";
      
      private static const FB_FALLBACK_ASSET_ID:String = "FacebookFallbackPicture";
      
      private static const REMOTE_FALLBACK_ASSET_ID:String = "MobileTransparentBackground";
      
      private var uiAtlases:Vector.<TextureAtlas>;
      
      private var textureCache:Dictionary;
      
      private var imageTypeCache:Object;
      
      private var remoteAssetsTextureCache:Vector.<Object>;
      
      private var remoteAssetsBitmapCache:Dictionary;
      
      protected var scale:Number = 1;
      
      private const FACEBOOK_PICTURE_POOL_SIZE:int = 25;
      
      private var _fbPicPoolSize:int = 0;
      
      private var documentConfiguration:WomDocumentConfiguration;
      
      public function MobileWomDefaultAssetRepository(param1:WomDocumentConfiguration)
      {
         super(Starling.current.stage);
         this.initialize();
         this.documentConfiguration = param1;
      }
      
      protected static function textEditorFactory() : TextFieldTextEditor
      {
         return new MobileWomTextFieldTextEditor();
      }
      
      protected static function textRendererFactory() : ITextRenderer
      {
         return new MPBitmapFontTextRenderer();
      }
      
      protected static function mobileWomTabFactory() : Button
      {
         return new MobileWomTabButton();
      }
      
      protected static function textAreaEditorFactory() : ITextEditorViewPort
      {
         return new TextFieldTextEditorViewPort();
      }
      
      private static function mobileListInitializer(param1:MPList) : void
      {
         var _loc2_:Quad = new Quad(100,100,16777215);
         _loc2_.alpha = 0;
         param1.backgroundSkin = _loc2_;
      }
      
      private static function mobileWomTabBarInitializer(param1:MobileWomTabBar) : void
      {
         param1.tabFactory = mobileWomTabFactory;
         param1.height = 53;
         param1.gap = 3;
      }
      
      public static function fixEventAssetName(param1:String) : String
      {
         var _loc2_:String = null;
         var _loc3_:String = Environment.hiRes ? "HD" : "SD";
         if(param1.indexOf("Map") > -1)
         {
            _loc2_ = param1;
         }
         else
         {
            _loc2_ = "M" + param1 + _loc3_;
         }
         trace("fixedName: " + _loc2_);
         return _loc2_;
      }
      
      public function initialize() : void
      {
         var _loc2_:* = null;
         var _loc1_:TextureAtlas = null;
         remoteAssetsTextureCache = new Vector.<Object>();
         remoteAssetsBitmapCache = new Dictionary();
         scale = Starling.contentScaleFactor;
         uiAtlases = new Vector.<TextureAtlas>();
         var _loc3_:StarlingAssetManager = Environment.starlingAssetManager;
         var _loc4_:StarlingAtlasManager = AtlasManager.INSTANCE as StarlingAtlasManager;
         for each(_loc2_ in new <String>["Ui","UiExtras1","UiExtras2","UiExtras3","Canvas1","Canvas2","Canvas3","Canvas4","Canvas5"])
         {
            _loc1_ = _loc3_.getTextureAtlas(_loc2_);
            uiAtlases.push(_loc1_);
            _loc4_.addTextureAtlas(_loc1_,_loc3_.getHitData(_loc2_));
         }
         MobileWomTextFormats.init();
         cacheAll();
         configureComponents();
      }
      
      private function configureComponents() : void
      {
         FeathersControl.defaultTextRendererFactory = textRendererFactory;
         FeathersControl.defaultTextEditorFactory = textEditorFactory;
         this.setInitializerForClassAndSubclasses(MobileWomButton,mobileWomButtonInitializer);
         this.setInitializerForClass(MobileWomMenuButton,mobileWomMenuButtonInitializer);
         this.setInitializerForClass(MPRigidButton,rigidButtonInitializer);
         this.setInitializerForClassAndSubclasses(MobileWomProgressBar,mobileProgressBarInitializer);
         this.setInitializerForClass(MobileWomTextInput,mobileWomTextInputInitializer);
         this.setInitializerForClass(MobileWomTabButton,mobileWomTabButtonInitializer);
         this.setInitializerForClass(MobileWomTabBar,mobileWomTabBarInitializer);
         this.setInitializerForClassAndSubclasses(MPList,mobileListInitializer);
         this.setInitializerForClass(MobileManualAuthenticationItemRenderer,mobileCellRendererInitializer);
         this.setInitializerForClass(MobileWomCheckBox,mobileWomCheckBoxInitializer);
         this.setInitializerForClass(MobileWomToggleSwitch,mobileWomToggleSwitchInitializer);
         this.setInitializerForClass(Button,toggleButtonInitializer,"feathers-toggle-switch-thumb");
         this.setInitializerForClass(Button,toggleSwitchOnTrackInitializer,"feathers-toggle-switch-on-track");
         this.setInitializerForClass(Button,toggleSwitchOffTrackInitializer,"feathers-toggle-switch-off-track");
         this.setInitializerForClass(MobileWomTextArea,mobileWomTextAreaInitializer);
         this.setInitializerForClass(MPPickerList,pickerListInitializer);
      }
      
      private function toggleSwitchOnTrackInitializer(param1:Button) : void
      {
         param1.defaultSkin = getDisplayObject("ButtonToggleOn");
      }
      
      private function toggleSwitchOffTrackInitializer(param1:Button) : void
      {
         param1.defaultSkin = getDisplayObject("ButtonToggleOff");
      }
      
      private function toggleButtonInitializer(param1:Button) : void
      {
         param1.defaultSkin = getDisplayObject("ButtonToggleCircle");
         param1.downSkin = getDisplayObject("ButtonToggleCircleHover");
      }
      
      private function mobileWomToggleSwitchInitializer(param1:MobileWomToggleSwitch) : void
      {
         param1.trackLayoutMode = "onOff";
         param1.defaultLabelProperties.textFormat = getCaptionTextFormat(21);
         param1.defaultLabelProperties.embedFonts = true;
         param1.paddingLeft = -7;
         param1.paddingRight = -7;
         var _temp_1:* = param1;
         var _loc2_:String = "m.ui.toggle.on";
         _temp_1.onText = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         var _temp_2:* = param1;
         var _loc3_:String = "m.ui.toggle.off";
         _temp_2.offText = peak.i18n.PText.INSTANCE.getText0(_loc3_);
      }
      
      private function mobileWomCheckBoxInitializer(param1:MobileWomCheckBox) : void
      {
         var _loc3_:Texture = getTexture("FormSelectbox");
         var _loc5_:Texture = getTexture("FormSelectboxSelected");
         var _loc4_:Texture = getTexture("FormSelectboxSelectedDisabled");
         var _loc2_:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
         _loc2_.defaultValue = _loc3_;
         _loc2_.defaultSelectedValue = _loc5_;
         _loc2_.setValueForState(_loc3_,"down",false);
         _loc2_.setValueForState(_loc3_,"down",true);
         _loc2_.setValueForState(_loc3_,"disabled",false);
         _loc2_.setValueForState(_loc4_,"disabled",true);
         param1.stateToIconFunction = _loc2_.updateValue;
         param1.defaultLabelProperties.textFormat = getCaptionTextFormat(23);
         param1.defaultLabelProperties.embedFonts = true;
         param1.disabledLabelProperties.textFormat = getCaptionTextFormat(23);
         param1.disabledLabelProperties.embedFonts = true;
         param1.selectedDisabledLabelProperties.textFormat = getCaptionTextFormat(23);
         param1.selectedDisabledLabelProperties.embedFonts = true;
         param1.gap = 0;
         param1.minTouchWidth = 50;
         param1.minTouchHeight = 47;
      }
      
      private function pickerListInitializer(param1:MPPickerList) : void
      {
         param1.popUpContentManager = new DropDownPopUpContentManager();
         var _loc2_:VerticalLayout = new VerticalLayout();
         _loc2_.verticalAlign = "bottom";
         _loc2_.horizontalAlign = "justify";
         _loc2_.useVirtualLayout = true;
         _loc2_.gap = 0;
         _loc2_.paddingTop = _loc2_.paddingRight = _loc2_.paddingBottom = _loc2_.paddingLeft = 0;
         param1.listProperties.layout = _loc2_;
         param1.listProperties.backgroundSkin = new Scale9Image(getTexture("MobileBeigeBackground"));
      }
      
      private function mobileCellRendererInitializer(param1:MobileManualAuthenticationItemRenderer) : void
      {
         var _loc2_:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
         _loc2_.defaultValue = getTexture("MobileBeigeBackground");
         _loc2_.defaultSelectedValue = getTexture("MobileBeigeBackground");
         param1.stateToSkinFunction = _loc2_.updateValue;
         param1.defaultLabelProperties.textFormat = getCaptionTextFormat(23);
         param1.defaultLabelProperties.embedFonts = true;
         param1.horizontalAlign = "left";
      }
      
      private function mobileWomTabButtonInitializer(param1:MobileWomTabButton) : void
      {
         param1.defaultSkin = new Scale3Image(getTexture("TabPassiveSkin"));
         param1.defaultSelectedSkin = new Scale3Image(getTexture("TabSelectedSkin"));
         param1.defaultLabelProperties.textFormat = getCaptionTextFormat(30);
         param1.defaultLabelProperties.embedFonts = true;
         param1.defaultSelectedLabelProperties.textFormat = getCaptionTextFormat(30);
         param1.defaultSelectedLabelProperties.embedFonts = true;
         param1.padding = 23;
         param1.height = 53;
         param1.gap = 6;
      }
      
      private function mobileWomTextInputInitializer(param1:MobileWomTextInput) : void
      {
         var _loc2_:Scale3Image = new Scale3Image(getTexture("MobileTextInputSkin"));
         param1.textEditorFactory = textEditorFactory;
         param1.promptFactory = textRendererFactory;
         param1.backgroundSkin = _loc2_;
         param1.backgroundDisabledSkin = _loc2_;
         param1.backgroundFocusedSkin = _loc2_;
         param1.paddingTop = 13;
         param1.paddingBottom = 6;
         param1.paddingLeft = param1.paddingRight = 11;
         param1.textEditorProperties.textFormat = MobileWomTextFormats.WOM_58;
         param1.textEditorProperties.embedFonts = true;
         param1.promptProperties.textFormat = getWomTextFormat(29);
         param1.promptProperties.embedFonts = true;
      }
      
      private function mobileProgressBarInitializer(param1:MobileWomProgressBar) : void
      {
         param1.backgroundSkin = getDisplayObject(param1.backgroundSkinId);
         var _loc2_:DisplayObject = getDisplayObject(param1.fillSkinId);
         _loc2_.width = 16;
         _loc2_.height = 22;
         param1.fillSkin = _loc2_;
         param1.padding = param1.fillPadding;
         param1.defaultLabelProperties.textFormat = param1.textFormat;
         param1.defaultLabelProperties.embedFonts = true;
      }
      
      private function rigidButtonInitializer(param1:MPRigidButton) : void
      {
         var _loc4_:String = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(param1.isRemoteAsset)
         {
            _loc4_ = MobileWomDefaultAssetRepository.fixEventAssetName(param1.normalSkinId);
            _loc2_ = 54;
            _loc3_ = 54;
            param1.defaultSkin = getRemoteDisplayObject(_loc4_,_loc2_,_loc3_);
            _loc4_ = MobileWomDefaultAssetRepository.fixEventAssetName(param1.tapSkinId);
            param1.downSkin = getRemoteDisplayObject(_loc4_,_loc2_,_loc3_);
         }
         else
         {
            param1.defaultSkin = param1.upSkin = getDisplayObject(param1.normalSkinId);
            param1.downSkin = getDisplayObject(param1.tapSkinId);
         }
         param1.defaultLabelProperties.smoothing = "trilinear";
      }
      
      private function mobileWomMenuButtonInitializer(param1:MobileWomMenuButton) : void
      {
         mobileWomButtonInitializer(param1);
         param1.paddingLeft = 4;
      }
      
      private function mobileWomButtonInitializer(param1:MobileWomButton) : void
      {
         var _loc5_:String = "Button";
         var _loc3_:String = _loc5_ + param1.style + param1.color + param1.size + "Normal";
         var _loc4_:String = _loc5_ + param1.style + param1.color + param1.size + "Tap";
         var _loc2_:String = param1.selectedSkinId ? param1.selectedSkinId : _loc4_;
         var _loc7_:String = param1.disabledSkinId ? param1.disabledSkinId : _loc5_ + "Gray" + param1.size + "Tap";
         param1.paddingLeft = 8;
         var _loc6_:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
         _loc6_.defaultValue = getTexture(_loc3_);
         _loc6_.defaultSelectedValue = getTexture(_loc2_);
         _loc6_.setValueForState(getTexture(_loc4_),"down",false);
         _loc6_.setValueForState(getTexture(_loc7_),"disabled",false);
         _loc6_.setValueForState(getTexture(_loc7_),"disabled",true);
         param1.stateToSkinFunction = _loc6_.updateValue;
         param1.defaultLabelProperties.textFormat = param1.buttonTextFormat;
         param1.defaultLabelProperties.embedFonts = true;
         param1.defaultLabelProperties.smoothing = "trilinear";
      }
      
      private function mobileWomTextAreaInitializer(param1:MobileWomTextArea) : void
      {
         var _loc2_:Scale9Image = new Scale9Image(getTexture("MobileTextAreaSkin"));
         param1.textEditorFactory = textAreaEditorFactory;
         param1.backgroundSkin = _loc2_;
         param1.backgroundDisabledSkin = _loc2_;
         param1.backgroundFocusedSkin = _loc2_;
         param1.paddingTop = 13;
         param1.paddingBottom = 6;
         param1.paddingLeft = param1.paddingRight = 11;
         param1.textEditorProperties.textFormat = MobileWomTextFormats.WOM_58;
         param1.textEditorProperties.embedFonts = true;
      }
      
      private function cacheAll() : void
      {
         imageTypeCache = new Dictionary();
         textureCache = new Dictionary();
         registerScale9Texture("MobileWindowBackground","BackgroundBorderedDark",new Rectangle(39,41,2,2));
         registerScale9Texture("BackgroundTransparentProtectionPanel","BackgroundTransparentProtection",new Rectangle(19,15,2,2));
         registerScale9Texture("BackgroundTransparentPanel","BackgroundTransparent",new Rectangle(14,21,2,2));
         registerScale9Texture("BackgroundYellowPanel","BackgroundTransparentYellow",new Rectangle(14,21,2,2));
         registerScale9Texture("BackgroundRedWarningPanel","BackgroundRedWarning",new Rectangle(5,5,2,2));
         registerScale3Texture("FullScreenHeaderBackground","BackgroundFullTop");
         registerScale3Texture("MapListBackground","BackgroundMapList");
         registerMobileColoredButtonAssets("Transparent","Blue","Large");
         registerMobileColoredButtonAssets("Transparent","Blue","Medium");
         registerMobileColoredButtonAssets("Transparent","Blue","Small");
         registerMobileColoredButtonAssets("Transparent","Red","Large");
         registerMobileColoredButtonAssets("Transparent","Red","Medium");
         registerMobileColoredButtonAssets("Transparent","Red","Small");
         registerMobileColoredButtonAssets("Transparent","White","Small");
         registerMobileColoredButtonAssets("","DarkBlue","Large");
         registerMobileColoredButtonAssets("","DarkBlue","Medium","Large");
         registerScale3Texture("ButtonWarMercSelected","ButtonMercWarSelected");
         var _loc3_:Array = ["Beige","Blue","Gray","Green","Red","Yellow"];
         var _loc1_:Array = ["Large","Medium","Small"];
         for each(var _loc2_ in _loc3_)
         {
            for each(var _loc4_ in _loc1_)
            {
               registerMobileColoredButtonAssets("",_loc2_,_loc4_);
            }
         }
         registerScale3Texture("ProgressBarResourceBackground","ResourceProgressbarBase");
         registerScale3Texture("ProgressBarFullSkin","ResourceProgressbarFull");
         registerScale3Texture("ProgressBarMightSkin","ResourceProgressbarMight");
         registerScale3Texture("ProgressBarLumberSkin","ResourceProgressbarLumber");
         registerScale3Texture("ProgressBarStoneSkin","ResourceProgressbarStone");
         registerScale3Texture("ProgressBarIronSkin","ResourceProgressbarIron");
         registerScale3Texture("ProgressBarExperienceSkin","ResourceProgressbarExperience");
         registerScale9Texture("ProgressBarBackground","ProgressbarBase",new Rectangle(9,15,1,1));
         registerScale9Texture("ProgressBarBlueSkin","ProgressbarBlue",new Rectangle(7,14,1,1));
         registerScale9Texture("ProgressBarGreenSkin","ProgressbarGreen",new Rectangle(7,14,1,1));
         registerScale9Texture("ProgressBarYellowSkin","ProgressbarYellow",new Rectangle(7,14,1,1));
         registerScale9Texture("MobileTextAreaSkin","FormTextArea",new Rectangle(19,17,2,2));
         registerScale3Texture("MobileTextInputSkin","FormTextInput");
         registerScale9Texture("MobileDarkBackground","BackgroundInnerDark",new Rectangle(19,17,2,2));
         registerScale9Texture("MobileBeigeBackground","BackgroundRowBeige",new Rectangle(19,17,2,2));
         registerScale9Texture("MobileBrownBackground","BackgroundRowBrown",new Rectangle(19,17,2,2));
         registerScale9Texture("MobileGrayBackground","BackgroundRowGray",new Rectangle(19,17,2,2));
         registerScale9Texture("MobileYellowBackground","BackgroundRowYellow",new Rectangle(19,17,2,2));
         registerScale9Texture("MobileGreenBackground","BackgroundRowGreen",new Rectangle(19,17,2,2));
         registerScale9Texture("MobileRedBackground","BackgroundRowRed",new Rectangle(19,17,2,2));
         registerScale9Texture("MobileInnerBeigeBackground","BackgroundInnerLight",new Rectangle(19,17,2,2));
         registerScale9Texture("MobileTransparentBackground","BackgroundTransparent",new Rectangle(19,17,2,2));
         registerScale3Texture("ListHeaderPassiveBackground","SortPassiveBackground");
         registerScale3Texture("ListHeaderActiveBackground","SortActiveBackground",1,1);
         registerScale3Texture("ListHeaderSideBackground","SortSideBackground",11,1);
         registerScale3Texture("TabPassiveSkin","TabPassiveSide");
         registerScale3Texture("TabSelectedSkin","TabSelectedSide");
         registerScale3Texture("MercSlotBackground","ButtonMercSlot");
         registerScale3Texture("MercEmptyBackground","ButtonMercEmpty");
         registerScale3Texture("MobileTopSellerAsset","TopSellerRibbon");
         registerScale3Texture("BeigeLargeBackground","ButtonBeigeLarge");
      }
      
      private function registerMobileColoredButtonAssets(param1:String, param2:String, param3:String, param4:String = null) : void
      {
         imageTypeCache["Button" + param1 + param2 + param3 + "Normal"] = "feathers.display.Scale3Image";
         imageTypeCache["Button" + param1 + param2 + param3 + "Tap"] = "feathers.display.Scale3Image";
         registerScale3Texture("Button" + param1 + param2 + param3 + "Normal","Button" + param1 + param2 + (param4 ? param4 : param3));
         registerScale3Texture("Button" + param1 + param2 + param3 + "Tap","Button" + param1 + param2 + (param4 ? param4 : param3) + "Hover");
      }
      
      private function registerScale3Texture(param1:String, param2:String, param3:int = -1, param4:int = -1, param5:String = "horizontal") : void
      {
         var _loc6_:Number = NaN;
         if(param3 == -1)
         {
            _loc6_ = (getTexture(param2) as Texture).width;
            param3 = int(_loc6_ > 3 ? (_loc6_ >> 1) - 1 : _loc6_ >> 1);
            param4 = _loc6_ > 3 ? 2 : 1;
         }
         textureCache[param1] = new Scale3Textures(getTexture(param2),param3,param4,param5);
         imageTypeCache[param1] = "feathers.display.Scale3Image";
      }
      
      private function registerScale9Texture(param1:String, param2:String, param3:Rectangle) : void
      {
         textureCache[param1] = new Scale9Textures(getTexture(param2),param3);
         imageTypeCache[param1] = "feathers.display.Scale9Image";
      }
      
      public function getDisplayObject(param1:String) : DisplayObject
      {
         var _loc2_:Class = null;
         try
         {
            if(param1 in textureCache)
            {
               if(param1 in imageTypeCache)
               {
                  _loc2_ = getDefinitionByName(imageTypeCache[param1]) as Class;
                  return new _loc2_(textureCache[param1]);
               }
               return new InflatedBoundsImage(textureCache[param1]);
            }
            textureCache[param1] = getTexture(param1);
            return new InflatedBoundsImage(textureCache[param1]);
         }
         catch(e:Error)
         {
            log(WomLoggerContexts.GAME,"Error getting display object : " + param1);
         }
         return new Scale9Image(textureCache["MobileBeigeBackground"]);
      }
      
      public function getTexture(param1:String) : *
      {
         var _loc2_:Texture = null;
         if(param1 in textureCache)
         {
            return textureCache[param1];
         }
         for each(var _loc3_ in uiAtlases)
         {
            _loc2_ = _loc3_.getTexture(param1);
            if(_loc2_ != null)
            {
               textureCache[param1] = _loc2_;
               break;
            }
         }
         return _loc2_;
      }
      
      private function checkRemoteFallbackDisplayObject(param1:String, param2:String) : DisplayObject
      {
         if(param1 == null)
         {
            return getDisplayObject(param2);
         }
         return null;
      }
      
      public function getRemoteDisplayObject(param1:String, param2:Number, param3:Number, param4:String = null) : DisplayObject
      {
         var _loc6_:DisplayObject = checkRemoteFallbackDisplayObject(param1,"MobileTransparentBackground");
         if(_loc6_ != null)
         {
            _loc6_.width = param2;
            _loc6_.height = param3;
            return _loc6_;
         }
         var _loc5_:String = param4 != null ? param4 : documentConfiguration.remoteAssetUrlPrefix + param1;
         _loc6_ = lookupRemoteAssetTextureInCache(param1);
         if(_loc6_ == null)
         {
            if(param1 in remoteAssetsBitmapCache)
            {
               _loc6_ = new MobileRemoteDisplayObjectContainer(param1,_loc5_,getDisplayObject("MobileTransparentBackground"),param2,param3,remoteAssetsBitmapCache[param1]);
            }
            else
            {
               _loc6_ = new MobileRemoteDisplayObjectContainer(param1,_loc5_,getDisplayObject("MobileTransparentBackground"),param2,param3);
               _loc6_.addEventListener("change",passParameters(onRemoteDisplayObjectLoadComplete,false));
            }
         }
         else
         {
            _loc6_ = new MobileRemoteDisplayObjectContainer(param1,_loc5_,_loc6_ as Image,param2,param3,param1 in remoteAssetsBitmapCache ? remoteAssetsBitmapCache[param1] : null);
         }
         return _loc6_;
      }
      
      public function getFacebookPicture(param1:String, param2:Number = NaN, param3:Number = NaN, param4:String = null) : DisplayObject
      {
         var _loc5_:DisplayObject = checkRemoteFallbackDisplayObject(param1,"FacebookFallbackPicture");
         if(_loc5_ != null)
         {
            _loc5_.width = isNaN(param2) ? 67 : param2;
            _loc5_.height = isNaN(param3) ? 67 : param3;
            return _loc5_;
         }
         _loc5_ = lookupRemoteAssetTextureInCache(param1);
         if(_loc5_ == null)
         {
            if(param1 in remoteAssetsBitmapCache)
            {
               _loc5_ = new MobileFacebookPicture(param1,getDisplayObject("FacebookFallbackPicture"),param2,param3,remoteAssetsBitmapCache[param1],param4);
            }
            else
            {
               _loc5_ = new MobileFacebookPicture(param1,getDisplayObject("FacebookFallbackPicture"),param2,param3,null,param4);
               _loc5_.addEventListener("change",passParameters(onRemoteDisplayObjectLoadComplete,true));
            }
         }
         else
         {
            _loc5_ = new MobileFacebookPicture(param1,_loc5_ as Image,param2,param3,param1 in remoteAssetsBitmapCache ? remoteAssetsBitmapCache[param1] : null,param4);
         }
         return _loc5_;
      }
      
      private function onRemoteDisplayObjectLoadComplete(param1:Event, param2:Boolean) : void
      {
         var _loc3_:Object = null;
         var _loc4_:MobileRemoteDisplayObjectContainer = param1.target as MobileRemoteDisplayObjectContainer;
         remoteAssetsTextureCache.push({
            "pic":_loc4_.displayObject,
            "id":_loc4_.assetId
         });
         remoteAssetsBitmapCache[_loc4_.assetId] = _loc4_.bitmap;
         if(param2)
         {
            if(_fbPicPoolSize < 25)
            {
               _fbPicPoolSize = _fbPicPoolSize + 1;
            }
            else
            {
               _loc3_ = remoteAssetsTextureCache.splice(0,1)[0];
               if(_loc3_.pic is Image)
               {
                  trace("PicToBeDisposed texture size : ",(_loc3_.pic as Image).texture.width,(_loc3_.pic as Image).texture.height);
               }
            }
         }
      }
      
      private function lookupRemoteAssetTextureInCache(param1:String) : Image
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < remoteAssetsTextureCache.length)
         {
            if(remoteAssetsTextureCache[_loc2_].id == param1)
            {
               return remoteAssetsTextureCache[_loc2_].pic;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function getMobileAvatar(param1:String) : DisplayObject
      {
         var _loc2_:String = "GuestAvatar" + param1;
         return getDisplayObject(_loc2_);
      }
      
      public function getAvatarByProfile(param1:Profile, param2:Number = NaN, param3:Number = NaN) : DisplayObject
      {
         var _loc7_:DisplayObject = null;
         var _loc6_:String = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         if(param1.isNpc)
         {
            if(param1.npcClan == "NPC-6")
            {
               _loc6_ = documentConfiguration.eventAvatarImageName;
               _loc4_ = 54;
               _loc5_ = 51;
               _loc7_ = getRemoteDisplayObject(_loc6_,_loc4_,_loc5_);
            }
            else
            {
               _loc7_ = getDisplayObject(Profile.getAvatarAssetIdByProfile(param1));
            }
         }
         else if(!param1.platformId && param1.avatar)
         {
            _loc7_ = getMobileAvatar(param1.mobileAvatarIndex);
         }
         else
         {
            if(param1.platformId)
            {
               return getFacebookPicture(param1.platformId,param2,param3,param1.invitableFriendPictureUrl);
            }
            _loc7_ = getDisplayObject("FacebookFallbackPicture");
         }
         _loc7_.scaleX = _loc7_.scaleY = Math.max(isNaN(param2) ? 67 : param2,isNaN(param3) ? 67 : param3) / Math.max(_loc7_.width,_loc7_.height);
         return _loc7_;
      }
   }
}


package wom.model.resource
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.LoaderInfo;
   import flash.geom.Point;
   import flash.media.Sound;
   import flash.utils.getDefinitionByName;
   import flash.utils.getTimer;
   import peak.logging.LoggerContexts;
   import peak.logging.log;
   import peak.resource.DefaultAssetRepository;
   import peak.resource.asset.core.BitmapAsset;
   import peak.resource.asset.core.BitmapAssetReference;
   import peak.resource.asset.core.RemoteBitmapAsset;
   import peak.resource.asset.core.RemoteSoundAsset;
   import peak.resource.asset.core.SoundAsset;
   import peak.resource.asset.core.SoundAssetReference;
   import peak.resource.asset.display.AssetDisplayObject;
   import wom.model.configuration.WomDocumentConfiguration;
   import wom.model.game.Profile;
   import wom.model.resource.asset.RoundedFacebookPicture;
   
   [Inject]
   public class WomDefaultAssetRepository extends DefaultAssetRepository implements WomAssetRepository
   {
      
      private static const FB_ASSET_PREFIX:String = "fbpicture";
      
      private static const FB_FALLBACK_ASSET_NAME:String = "FacebookFallbackPicture";
      
      private static const FACEBOOK_PICTURE_URL_PATTERN:String = "https://graph.facebook.com/v2.2/_/picture";
      
      private static const FlagBuildMenuBlank:Class = FlagBuildMenuBlank_png$3525c4d11a2721ad859cc355761921bc237629743;
      
      private static const FlagBuildMenuEmpty:Class = §FlagBuildMenuEmpty_png$17e175a8f5c137fdb6c7742760eccb36-988282480§;
      
      private static const FlagBuildMenuIcon1:Class = FlagBuildMenuIcon1_png$5c0ea144aa219b53822aab3e7688e8f51224372048;
      
      private static const FlagBuildMenuIcon10:Class = §FlagBuildMenuIcon10_png$fbca35e94182345bf458279e0e14f5f0-1416820762§;
      
      private static const FlagBuildMenuIcon11:Class = §FlagBuildMenuIcon11_png$e62e96e63cd52b25f20febc6875ec4b4-1415635353§;
      
      private static const FlagBuildMenuIcon12:Class = §FlagBuildMenuIcon12_png$4dc67f83269e8b84dfc6dfa7c9b3c9d8-1411287328§;
      
      private static const FlagBuildMenuIcon2:Class = FlagBuildMenuIcon2_png$55112c07661edf7b862c90f7e3e1da571221347281;
      
      private static const FlagBuildMenuIcon3:Class = FlagBuildMenuIcon3_png$8b9018b0ed9b10c4579098c9a47411861222532690;
      
      private static const FlagBuildMenuIcon4:Class = FlagBuildMenuIcon4_png$b5346abf28ffe05a340c58e5b755c53e1210103507;
      
      private static const FlagBuildMenuIcon5:Class = FlagBuildMenuIcon5_png$d45035a19c210571023d86003f151a391211269484;
      
      private static const FlagBuildMenuIcon6:Class = FlagBuildMenuIcon6_png$ca259a46cdecce4021d2c309e3f259911208261101;
      
      private static const FlagBuildMenuIcon7:Class = FlagBuildMenuIcon7_png$17538c8b49f4471b79aeb2c7ae959f671209462894;
      
      private static const FlagBuildMenuIcon8:Class = FlagBuildMenuIcon8_png$96179b78df486f00f79277bf05c830c61209583855;
      
      private static const FlagBuildMenuIcon9:Class = FlagBuildMenuIcon9_png$4a02e4e479349746ffe3d4e8d131e90a1214980968;
      
      private static const MapPin:Class = §MapPin_png$1f24a665441a033d854bd6ad947f9c24-448344119§;
      
      private static const MapPinPass:Class = §MapPinPass_png$d376d12d19fb39130e1914897f89f1de-2053411462§;
      
      private static const Part14:Class = Part14_png$8313de1b6b3d7949a8dfe402f174a60e716772238;
      
      private static const Part15:Class = Part15_png$808b1878f86a3b99f49b3283c91481dd713779727;
      
      private static const Part16:Class = Part16_png$67a87e9745ec691fd67f765d427383c2714949256;
      
      private static const Part17:Class = Part17_png$4a5d584b2c4477c966e6cceec1f1f65e720329993;
      
      private static const Part18:Class = Part18_png$49b0f8c4558763e7c36eed72c365ac58720483722;
      
      private static const Part19:Class = Part19_png$1e8f96821d5b76b7b6908d69411d7752717458443;
      
      private static const Part20:Class = Part20_png$5449790a8e9c77be989af236dde3e5ae691898641;
      
      private static const Part21:Class = Part21_png$61cc9f921d868f3b580da01c66cbd425688906642;
      
      private static const Part24:Class = Part24_png$2bb0fcc61c8ea2b9a4fbe109aeeeaf01695348013;
      
      private static const Part25:Class = Part25_png$e379dbcb175e687a3f6cf139a35e6ac5692323246;
      
      private static const Part26:Class = Part26_png$a1023c1d4be48069405121a0fcabdcc7693508655;
      
      private static const Part27:Class = Part27_png$3f5d575f16d6ae9bf0ff330c7b07ad72693662376;
      
      private static const SignBlank:Class = §SignBlank_png$2d9595962b5194315e1a2fe3ac009411-556699133§;
      
      private static const SignEmpty:Class = §SignEmpty_png$d47b7f3aab36de49749bdd3777602968-1794932092§;
      
      private static const SignIcon1:Class = §SignIcon1_png$e2977b096b6ba4023c42a18ca31741a5-1458057294§;
      
      private static const SignIcon10:Class = §SignIcon10_png$30441db9884f6c2d8873b92cf2065354-1607509180§;
      
      private static const SignIcon11:Class = §SignIcon11_png$b4e47a159762da085eda0853a700c4fb-1607355451§;
      
      private static const SignIcon12:Class = §SignIcon12_png$f8f84c80fe08bc61ba5c75797609450d-1610380730§;
      
      private static const SignIcon2:Class = §SignIcon2_png$476d3861871471b00492d8aea1ba7d18-1452923341§;
      
      private static const SignIcon3:Class = §SignIcon3_png$49a0b0e1f7a41426f314a0407b8b9d17-1452786100§;
      
      private static const SignIcon4:Class = §SignIcon4_png$7c0c8b5bc6c9ae9f5abd66879ae66190-1451616563§;
      
      private static const SignIcon5:Class = §SignIcon5_png$2075ccd6c5b66a76b5c698d8830b9e03-1454612146§;
      
      private static const SignIcon6:Class = §SignIcon6_png$108eded29779bb04e99670813253b206-1453426225§;
      
      private static const SignIcon7:Class = §SignIcon7_png$10ae66c87570397cc6f694e59271a8b7-1465888696§;
      
      private static const SignIcon8:Class = §SignIcon8_png$bb9a3cdedc8f790daf21f398c0d76a89-1464686391§;
      
      private static const SignIcon9:Class = §SignIcon9_png$8b252499fbdc89285d4eeba274ffaabc-1467710646§;
      
      private static const FlagBlank:Class = FlagBlank_png$15364d705fc423c0be88c209561463ac1075681657;
      
      private static const FlagEmpty:Class = FlagEmpty_png$428c5d01e54e037968a79baf94174ea4390867426;
      
      private static const FlagIcon1:Class = FlagIcon1_png$0b2be4e4a204e7d508ca8d8598b092011596938024;
      
      private static const FlagIcon10:Class = FlagIcon10_png$9d059aa7c170122c07fab854e391c4e91325737774;
      
      private static const FlagIcon11:Class = FlagIcon11_png$cbc3fa67e41d0164986f8ed5dd167acd1326923695;
      
      private static const FlagIcon12:Class = FlagIcon12_png$3f6e30a7e98e0dba8a988fb8fb39f8fa1327044136;
      
      private static const FlagIcon2:Class = FlagIcon2_png$358635088c24f69d55ade3fbc933ef9a1597091753;
      
      private static const FlagIcon3:Class = FlagIcon3_png$c4cefa08d3d551678fe3eac6a44250d51594066474;
      
      private static const FlagIcon4:Class = FlagIcon4_png$f62f8a02d260395094d34e4b196e344e1595252395;
      
      private static const FlagIcon5:Class = FlagIcon5_png$7085e3d7bb74714aba348bfaafa9f6b81600645412;
      
      private static const FlagIcon6:Class = FlagIcon6_png$06845e0fe2c52d5810e4b92eb77e3c071600766373;
      
      private static const FlagIcon7:Class = FlagIcon7_png$19fa269432f4224f2bb5826bf7302c661601951782;
      
      private static const FlagIcon8:Class = FlagIcon8_png$2c4e302d4897fa4dfb4f84d90ec6a5771598697639;
      
      private static const FlagIcon9:Class = FlagIcon9_png$11e9df855686d0468c1e8bdb0b3b71621599867680;
      
      private static const GrassTile:Class = GrassTile_png$a4d7d092b7cc16f6333b5b5fe11b5a4e557707892;
      
      private static const ArchersArrow:Class = §ArchersArrow_png$88b9885f986bbe49599993738103ec38-597953267§;
      
      private static const Arrow1:Class = §Arrow1_png$a45b30f3f119b029fdbd21665a176589-2081741700§;
      
      private static const B32CannonBall:Class = B32CannonBall_png$b63f26ef3cd66cfd82162f5c80ecd2db161922407;
      
      private static const B33Animation:Class = B33Animation_png$e78e124dca9df8906df8f979e78696be1000330438;
      
      private static const BloodDrop:Class = BloodDrop_png$a00bb859e278ab276525bf1141ec85d3942270395;
      
      private static const Bloodstain:Class = §Bloodstain_png$8e38d318c0bba3153c2fad4bdc52844f-633356225§;
      
      private static const GatlingDart:Class = §GatlingDart_png$f3c88ed6055472852cb4111b0dd4d065-1175504431§;
      
      private static const GroundSwell1:Class = §GroundSwell1_png$a28c20b7d88a10ef34395e2954afc204-1375708205§;
      
      private static const GroundSwell2:Class = §GroundSwell2_png$f0e85c325bed43a3bae435b9532326ad-1374506388§;
      
      private static const GroundSwell3:Class = §GroundSwell3_png$3d0170c01059ae8e5201d4902d52e79c-1369142547§;
      
      private static const GroundSwell4:Class = §GroundSwell4_png$e38a08e4fc095fdbabf6d7f256e08a81-1367939730§;
      
      private static const HealBall:Class = HealBall_png$ee8bc4bedf3cd733e33fb94bd66425141057856611;
      
      private static const LightRay:Class = LightRay_png$9ec85ca334e102adabe2cddeb3c06dc7633148816;
      
      private static const LightSource:Class = LightSource_png$b57ab0d186aad657a9e819f58205cabc1441032115;
      
      private static const Soil1:Class = Soil1_png$40850393d19be0d7e8918ed94d293dfc29999308;
      
      private static const Soil2:Class = Soil2_png$c8d0c0c8bd87cc5d81ab015101a6967b31185741;
      
      private static const Soil3:Class = Soil3_png$d06db42d73ac0629b372fc64332d29de19542990;
      
      private static const Soil4:Class = Soil4_png$a3890fde17cf43ead691991b0849c2a420712015;
      
      private static const U34Ball:Class = §U34Ball_png$236c763261044dec1c6886c535f297e0-1115612625§;
      
      private static const WomkongStone:Class = §WomkongStone_png$8a982d43005af7896cc5415de53b04b2-404304969§;
      
      private static const AcidRainDrop:Class = AcidRainDrop_png$11adab0762c4e0fcc4947391f26a19151602713666;
      
      private static const AcidRainFoam2:Class = §AcidRainFoam2_png$0b20a1b580abb4a4de3f8fa351279c81-1259188296§;
      
      private static const IceShardCracks:Class = IceShardCracks_png$aa9b8e6beaed3cd5bd0524bb647ce4cd1754570230;
      
      private static const IceShardDrop:Class = IceShardDrop_png$40dc0f7046b0b242449cbf2c2291f9532081731708;
      
      private static const Lumber1:Class = Lumber1_png$3631242a35465ab400a0b6087246e11053682114;
      
      private static const Lumber2:Class = Lumber2_png$7bc12fc28c4e2b8836d6cf67c66b132d50689603;
      
      private static const Lumber3:Class = Lumber3_png$c0f03e0a316ac7207d7ab78a8094337151859164;
      
      private static const LumberWShadow1:Class = LumberWShadow1_png$f0bd5ac3a9b1ada2a534dc693b2767e31735159391;
      
      private static const LumberWShadow2:Class = LumberWShadow2_png$14a6a3ae7d2d436f99172da8a53699c21736328920;
      
      private static const LumberWShadow3:Class = LumberWShadow3_png$23ecab5faa699f67c1e2c7510fa47ad71732268377;
      
      private static const Stone1:Class = §Stone1_png$084093435eadd82b31ffa49a48970ca0-1200479114§;
      
      private static const StoneCrater:Class = StoneCrater_png$7fd70e0a4985a13757f6b706cfa03dd41659310864;
      
      private static const StonePart1:Class = StonePart1_png$5477818101d557a0a3f7a327028678aa1680507211;
      
      private static const StonePart2:Class = StonePart2_png$e13ad4654e890f048008fcb351822d4e1681693124;
      
      private static const StonePart3:Class = StonePart3_png$4041cccf8e1c1837625dc6552d0e8d371678700613;
      
      private static const StonePart4:Class = StonePart4_png$5a5b8fc23ec06a9f147c98ab7f7f2df31678821574;
      
      private static const BackgroundQuickAttack:Class = §BackgroundQuickAttack_png$b834970b913ff9e293c09c56e241bb28-1836787108§;
      
      private static const CampaignIcon:Class = CampaignIcon_png$b8996939e25106ab71625e295a493d4d1750009498;
      
      private static const IconHome:Class = IconHome_png$c778cd42fdcf5bd7b25f911ef0182e6f296806377;
      
      private static const IconHomeHover:Class = §IconHomeHover_png$c2552429a567a44673f9be67f27be2b1-1460493215§;
      
      private static const IconList:Class = §IconList_png$4a688524419b66bfed91eb76fbce1a13-2065652824§;
      
      private static const IconListHover:Class = IconListHover_png$fcf2ea63c4a4f89e0a3e5607409d8f43256289538;
      
      private static const IconQuickAttack:Class = IconQuickAttack_png$3f39c7045b07a9d651f3c4069d1b5c3a110177961;
      
      private static const IconQuickAttackHover:Class = §IconQuickAttackHover_png$a40c92fbda215fda712df9fecbeadf11-891755103§;
      
      private static const Map1VisualAvatarBackground:Class = §Map1VisualAvatarBackground_png$c7005f789c0552e6edfc0a85ae60544f-871654427§;
      
      private static const Map1VisualAvatarBackground1:Class = §Map1VisualAvatarBackground1_png$7f221a5e6a00b731361c018730a92ce0-1112534926§;
      
      private static const Map1VisualAvatarBackground2:Class = §Map1VisualAvatarBackground2_png$c3672a9d79548896207c7e36349b9bc9-1115526925§;
      
      private static const Map1VisualAvatarBackground3:Class = §Map1VisualAvatarBackground3_png$01232e97da3862144e11c7ab092046f3-1114356980§;
      
      private static const Map1VisualAvatarBackground4:Class = §Map1VisualAvatarBackground4_png$89fd76624820135b00fe374a89b7a85b-1108976755§;
      
      private static const Map1VisualAvatarBackground6:Class = §Map1VisualAvatarBackground6_png$1f23e1234cea4db262764451c61e60a2-1107654001§;
      
      private static const Part1:Class = §Part1_png$b8ccf802f0b6888d6f73e0ff91903509-658854421§;
      
      private static const Part10:Class = Part10_png$c1eebde0cc6e991defd37f25b087570d64304691;
      
      private static const Part11:Class = Part11_png$51fc010bee2ad0db7f8db7610a9e264452891212;
      
      private static const Part12:Class = Part12_png$306d43c9142f13bcd82e85223c150a2353044941;
      
      private static const Part13:Class = Part13_png$c9bcc29a3163e74a7d45f5bb084303f554227278;
      
      private static const Part2:Class = §Part2_png$73dfe0f80ca8cf8c19cc880d5e637112-661879708§;
      
      private static const Part3:Class = §Part3_png$384b7de794b1c34bd5953c76530feab4-660693787§;
      
      private static const Part4:Class = §Part4_png$737af2f1f7e9448273ab2aeccab63b64-656345242§;
      
      private static const Part5:Class = §Part5_png$3bd74f7a71b4f5101153743970c9601e-655175705§;
      
      private static const Part6:Class = §Part6_png$25dd6f273267ed40f0553cf7f9fdc2f8-658168224§;
      
      private static const Part7:Class = §Part7_png$4965405b9f3d9bc4d3cc9aab8ecef499-656982303§;
      
      private static const Part8:Class = §Part8_png$25c01fd564b34848d92b5cf83557f9fc-656864926§;
      
      private static const Part9:Class = §Part9_png$771c9c651830262b263b5d8f41ae0ec9-668245533§;
      
      private static const WorldMapIcon:Class = §WorldMapIcon_png$df088109c7a043feff59f579ae6d8cf0-757165188§;
      
      private static const StoreConstructionTabPatlangac:Class = §StoreConstructionTabPatlangac_png$b870dd9b8d5061b3b5e251fbc78efea3-1014083773§;
      
      private static const ColorMenuFrameLeft:Class = ColorMenuFrameLeft_png$28dd0371ba4f71557fa933c17776a46f1307722585;
      
      private static const DefaultArm:Class = DefaultArm_png$340276f827584ef595f181b17bd44ea21329962322;
      
      private static const DefaultToken:Class = DefaultToken_png$446747b7352bfc1708ba2c345fc0a3921536088119;
      
      private static const TokenColorA:Class = TokenColorA_png$4ed82990cc80fda5bfda08bb075711471445181702;
      
      private static const TokenColorB:Class = TokenColorB_png$916feeb1462f0ba674dc66746bf1b0ba1446351239;
      
      private static const ArmPattern10A:Class = ArmPattern10A_png$cb96e29da2ae310d049fba73d32f03e5365488756;
      
      private static const ArmPattern11A:Class = ArmPattern11A_png$3726c0569a5619d67b4ca4472a7e1e31327517083;
      
      private static const ArmPattern12A:Class = ArmPattern12A_png$14dbf6a1ac920e5d809ee33e47edaa3c310270778;
      
      private static const ArmPattern1A:Class = §ArmPattern1A_png$ed6b6955ef8de18ebb6cb4d16d09315d-543953060§;
      
      private static const ArmPattern2A:Class = §ArmPattern2A_png$9c9070ff530e6caa129de071995c1859-565410589§;
      
      private static const ArmPattern3A:Class = §ArmPattern3A_png$f6544de815efee821ff002ebe35987fe-600220670§;
      
      private static const ArmPattern4A:Class = §ArmPattern4A_png$46e79ab1f0de9cccf3bc909688d83470-621644383§;
      
      private static const ArmPattern5A:Class = §ArmPattern5A_png$30e01d0c8e38de26734d8ee636a80c00-659617088§;
      
      private static const ArmPattern6A:Class = §ArmPattern6A_png$e3606084b8029d6ec6dd21366bbc3503-686284185§;
      
      private static const ArmPattern7A:Class = §ArmPattern7A_png$4dbff8c33a250ecb9857129fc65da71a-707462266§;
      
      private static const ArmPattern8A:Class = §ArmPattern8A_png$1873e36ff37527ac7796b44539e44063-746482907§;
      
      private static const ArmPattern9A:Class = §ArmPattern9A_png$50dffffd6a126e232d1073e8ab5d3dea-763713468§;
      
      private static const ArmPatternBase:Class = ArmPatternBase_png$73d57d1d5e7198aeec90be38f12c6d27504211037;
      
      private static const PatternSymbol1:Class = §PatternSymbol1_png$5ddb6ac1eefbf578836ae595d05dbf3c-827845302§;
      
      private static const PatternSymbol10:Class = §PatternSymbol10_png$06dfaf1ca95a6aef8ffe6e784e091675-284143028§;
      
      private static const PatternSymbol11:Class = §PatternSymbol11_png$b525b503484e8e0bb20c3da93e388f8d-278746419§;
      
      private static const PatternSymbol12:Class = §PatternSymbol12_png$96a191780175c310dc0acea32902b584-277576370§;
      
      private static const PatternSymbol2:Class = §PatternSymbol2_png$cae0f907390822c9c2d23f323de2bbf2-826642997§;
      
      private static const PatternSymbol3:Class = §PatternSymbol3_png$1d731af67bbd337de63500e8b5323de1-829668284§;
      
      private static const PatternSymbol4:Class = §PatternSymbol4_png$2ff47dae65630bfaf4116f9672098c45-828482363§;
      
      private static const PatternSymbol5:Class = §PatternSymbol5_png$3d78f0c82ed047009a5dd686ccae4a32-824133818§;
      
      private static const PatternSymbol6:Class = §PatternSymbol6_png$4f71cdf841d956f8f743a031e5843bc3-822964281§;
      
      private static const PatternSymbol7:Class = §PatternSymbol7_png$8ba5bc37c88bcb84afba25eedf6676ea-825956800§;
      
      private static const PatternSymbol8:Class = §PatternSymbol8_png$ffa1fb897a1ff6630d2f71a0fa91d998-824770879§;
      
      private static const PatternSymbol9:Class = §PatternSymbol9_png$b389e8478ba9b8aeaf05f62ae6860072-824653502§;
      
      private static const CloseMainNormal:Class = §CloseMainNormal_png$805e1dff6076ad727ff87e57efec727f-71639991§;
      
      private static const CloseMainOver:Class = CloseMainOver_png$07a0bb34af105e2ac8743a71c6cd23e1206634622;
      
      private static const HiringQuartersCancel:Class = HiringQuartersCancel_png$a91245bf6696996dab60c5d6c20c940d1508835639;
      
      private static const HiringQuartersCancel2:Class = §HiringQuartersCancel2_png$3ba499bf705c933a0f008eda1fa815df-45081759§;
      
      private static const ArrowCursor:Class = §ArrowCursor_png$b8461508f072053aa0b96de8c189007c-667294062§;
      
      private static const ClearOutCursor:Class = §ClearOutCursor_png$565a674ab2512e5213a53a04ee98cc63-2034449662§;
      
      private static const DragCursor:Class = DragCursor_png$a60b6d5be5d0c52c7d81de6fd7a562722134191437;
      
      private static const EnterBuildingCursor:Class = §EnterBuildingCursor_png$356b26f1b7db02720a88e550badc9bf6-50268019§;
      
      private static const FortifyCursor:Class = FortifyCursor_png$7e415d8b71e800df2769654196994a491232264554;
      
      private static const HandCursor:Class = §HandCursor_png$a2a14ab87ec3655ba3461cd35c510fd4-922208720§;
      
      private static const HarvestAllCursor:Class = HarvestAllCursor_png$49e3ff02d86324cdb3201c8de896c0b81714053897;
      
      private static const HarvestCursor:Class = §HarvestCursor_png$e1ab6577e1672c38c5a05afeaa106a62-1731342222§;
      
      private static const HarvestGoldCursor:Class = §HarvestGoldCursor_png$224cc2e93906d298885417bfe01cf36a-1891116430§;
      
      private static const MoveCursor:Class = §MoveCursor_png$5dc28398e13a0a82469619b54c331a7d-2110185710§;
      
      private static const RecycleCursor:Class = RecycleCursor_png$539ff12a73648f28824d6cd8913c42d11449793444;
      
      private static const RemainingHelp1Cursor:Class = RemainingHelp1Cursor_png$e1f798d505f42982a194eb9ee9818ade1857193547;
      
      private static const RemainingHelp2Cursor:Class = §RemainingHelp2Cursor_png$7cc9201180004c77a20e9ab447299222-94407292§;
      
      private static const RemainingHelp3Cursor:Class = RemainingHelp3Cursor_png$f519361e8b7f402b23719f563d473a5c91758789;
      
      private static const RemainingHelp4Cursor:Class = §RemainingHelp4Cursor_png$1e2e34fa18bed5d96ed103d8cd33bad3-1872454138§;
      
      private static const RemainingHelp5Cursor:Class = RemainingHelp5Cursor_png$fe8cec4e612f7d139a8f37fbcedd4cc6989941063;
      
      private static const SpeedUpCursor:Class = §SpeedUpCursor_png$1249b8b8ee18e47bc72e6838680cca8f-2099731557§;
      
      private static const UpgradeCursor:Class = §UpgradeCursor_png$8a1c43e84afa6285896565cb6c54072b-1820432515§;
      
      private static const BPAnimationLight:Class = §BPAnimationLight_png$f25eba2d449af2953dd55a225218af69-2095703824§;
      
      private static const LightAnimationGraphic:Class = §LightAnimationGraphic_png$2ebcb4c1dfe4a1b03852b2a1a0ade076-1724567208§;
      
      private static const LightAnimationGraphicNew:Class = §LightAnimationGraphicNew_png$3540d6e2521492fbc441a73e98d53c6c-1643404530§;
      
      private static const Patlangac:Class = Patlangac_png$147258245f287e00bcebd7cddce3c26c642951233;
      
      private static const ShinyBackgroundLarge:Class = ShinyBackgroundLarge_png$e41f7e4c5c019e4db0c32f61eafd35e8184927462;
      
      private static const ShinyBackgroundLargeOver:Class = ShinyBackgroundLargeOver_png$2d9a5a66c855dbfe3d6e1014b74eb789257085266;
      
      private static const ShinyBackgroundSmall:Class = §ShinyBackgroundSmall_png$47f96cb473923c6d2b9bd75d6d306e2a-115879110§;
      
      private static const ShinyBackgroundSmallOver:Class = ShinyBackgroundSmallOver_png$a7faa31d5e6e09765c1be5d2599fbfbd1566183846;
      
      private static const BackgroundBoxDark:Class = BackgroundBoxDark_png$f3464f0618c363a9431d229bd16d41582000360060;
      
      private static const BackgroundBoxGreen:Class = §BackgroundBoxGreen_png$3628b730081eaabc27faea27c8556d57-1998430893§;
      
      private static const BackgroundBoxLight:Class = BackgroundBoxLight_png$ed97c9b9f61ee41d869787a8795ad4fd994674430;
      
      private static const Check:Class = §Check_png$76b90a80de23d48845c62a495c33623f-2095200855§;
      
      private static const FacebookFallbackPicture:Class = FacebookFallbackPicture_png$1cfdd2b8b28a88ccee78b385c6d80044999587903;
      
      private static const MainFrame:Class = MainFrame_png$aeb750345396240ea014a7a3d0f0c3e9938811485;
      
      private static const NumberBackground:Class = §NumberBackground_png$53534090313a0e29647d40aa0b2191de-547427716§;
      
      private static const Or:Class = Or_png$6922aa38a4b92b60527b4c539866c22d1492245872;
      
      private static const SpeechBubble:Class = §SpeechBubble_png$feb5aba9dadf498e679d3c1c51310b7d-880481237§;
      
      private static const ProgressBar15:Class = ProgressBar15_png$4be7fd0d625a218e56fde3f09fa23fb8437858505;
      
      private static const ProgressBar15Inside:Class = ProgressBar15Inside_png$28368b3562adf5eeaa7434af84901879393118317;
      
      private static const ProgressBar19:Class = ProgressBar19_png$4fd2fec242eeb1d539c524ad863f3989441537221;
      
      private static const ProgressBar19Inside:Class = §ProgressBar19Inside_png$7b93ecabcf0b50d2fb9a68f8848d1884-469939863§;
      
      private static const ProgressBar26:Class = ProgressBar26_png$d93e2abf5957dd24c0de5428bf5ede8f405020905;
      
      private static const ProgressBar26Inside:Class = §ProgressBar26Inside_png$cb3569ab0a3a1442e614e8f07ea709a5-1158096371§;
      
      private static const ProgressBar30:Class = ProgressBar30_png$6a88a22558646efd501fbda9447e4ef3390362994;
      
      private static const ProgressBar30Inside:Class = ProgressBar30Inside_png$1858a9bf88f14e87f6aff62f54dbdbb8806508374;
      
      private static const ProgressBar36:Class = ProgressBar36_png$eee7695059c946ac1bc568efc154d670378599432;
      
      private static const ProgressBar36Inside:Class = §ProgressBar36Inside_png$542cbc012e6b66e33db0ee32b4dc83a6-1296661268§;
      
      private static const ProgressBar65:Class = ProgressBar65_png$72431b02fb184231aaf3ba4a5f495254299988972;
      
      private static const ProgressBar65Inside:Class = ProgressBar65Inside_png$75160c7bec3b0825adb7b19e4ee0d6d3820443568;
      
      private static const TabBoxCorner:Class = TabBoxCorner_png$ef9335b74228722fc6022fdc79045288242031867;
      
      private static const TabBoxCorner1:Class = §TabBoxCorner1_png$ec7c1543470232b63cd036691c7ae607-1207009860§;
      
      private static const TabBoxSide:Class = TabBoxSide_png$a7750ed59ecaee841c80e6926bae98d91151326005;
      
      private static const TabBoxSide1:Class = TabBoxSide1_png$dbccce2b20a332fb60408dff3460fa81330743074;
      
      private static const TabButton:Class = §TabButton_png$247ea3b3ecd638bac98ed146f00b2c58-370657987§;
      
      private static const TabButtonHover:Class = TabButtonHover_png$9525c1b0405c67789705200d63328d551029384621;
      
      private static const ArrowStep:Class = §ArrowStep_png$d0eb43ce5e9d9e5bb400a9c99a965b6c-906287951§;
      
      private static const HiringQuarterArrow:Class = HiringQuarterArrow_png$24ce27525bc62ad31d6842b52549cc83847730512;
      
      private static const SlideArrow:Class = SlideArrow_png$1cd180ec7504ad3413b38e027d0d54731669052586;
      
      private static const SlideArrowOver:Class = §SlideArrowOver_png$2eb3257710e9220c236c83c45ddf70fa-1902640874§;
      
      private static const GreenSquareButton:Class = §GreenSquareButton_png$773edead46a69c1f5d5ea4b5bdd979c1-420751538§;
      
      private static const GreenSquareButtonBigHover:Class = §GreenSquareButtonBigHover_png$5a3843ed4fb424fb73f1ad5cf86c14ba-2013513102§;
      
      private static const GreenSquareButtonHover:Class = §GreenSquareButtonHover_png$ec59b73dda2ce1f0e39097c4438a27a6-1033362756§;
      
      private static const RedSquareButton:Class = RedSquareButton_png$d11df43e6c67ff3a898ef114f4bbb393409132700;
      
      private static const YellowSquareButton:Class = YellowSquareButton_png$3cb7840f35ee16514f7e8a6d62ead2de1575416165;
      
      private static const BlueButtonLarge:Class = §BlueButtonLarge_png$f3d52b59fa7e2f3ecb800c165f7f1012-1351218766§;
      
      private static const BlueButtonLargeOver:Class = BlueButtonLargeOver_png$5233f00718f1f77266dd7ea15f98cbda1735674430;
      
      private static const BlueButtonLargeSelected:Class = BlueButtonLargeSelected_png$a37c0842ceb9086817e775166e2f6ab81498651509;
      
      private static const BrownButtonLarge:Class = BrownButtonLarge_png$8faff001a600e8cf362ca66f3b942c47169765942;
      
      private static const BrownButtonLargeOver:Class = BrownButtonLargeOver_png$0a39868535c46956385ac1c0d5cfdb3e313412770;
      
      private static const BrownButtonLargeSelected:Class = BrownButtonLargeSelected_png$06343c2f68b49ca3224e0a2afa6abfbb1394523129;
      
      private static const GreenButtonLarge:Class = GreenButtonLarge_png$efd8eb9a5b21c327493cffe4fbec0fa01033580353;
      
      private static const GreenButtonLargeOver:Class = GreenButtonLargeOver_png$fda4f7728af277503bb91ce9959c1a9f1790148941;
      
      private static const GreenButtonLargeSelected:Class = GreenButtonLargeSelected_png$59f1555d43716b4c8988c1f3e501f08d1028472324;
      
      private static const OrangeButtonLarge:Class = §OrangeButtonLarge_png$5da1cddfba5f33c7ffc8b42e8497d9e6-1132628762§;
      
      private static const OrangeButtonLargeOver:Class = §OrangeButtonLargeOver_png$018ef58dc60246e3410f1f44fcf144f3-380469422§;
      
      private static const OrangeButtonLargeSelected:Class = §OrangeButtonLargeSelected_png$67e8fb9381ffe748aad46a649f735d1a-333491543§;
      
      private static const RedButtonLarge:Class = RedButtonLarge_png$e0c73187bf4bba39954434c49d7330511501514739;
      
      private static const RedButtonLargeOver:Class = §RedButtonLargeOver_png$2cead38574c9ebe13d7c6ea95042280a-684538625§;
      
      private static const RedButtonLargeSelected:Class = RedButtonLargeSelected_png$228b0d281de78c46a5c3c51a0066c16195390902;
      
      private static const BlueButtonMedium:Class = BlueButtonMedium_png$79db75108a97abc3611a79fb321c2a3c2119354164;
      
      private static const BlueButtonMediumOver:Class = BlueButtonMediumOver_png$8a7d92f3f2ada17ea05ed1bfe6d0adfb1419998368;
      
      private static const BlueButtonMediumSelected:Class = BlueButtonMediumSelected_png$027dacbd2c3f46ec1442723bc2bd3ae4239300863;
      
      private static const BrownButtonMedium:Class = §BrownButtonMedium_png$a6a0a03ca87ada9e2c69427da5c8e810-1878534256§;
      
      private static const BrownButtonMediumOver:Class = BrownButtonMediumOver_png$1fa933e6b18e2462e28b30d2e7a67cc71286744348;
      
      private static const BrownButtonMediumSelected:Class = §BrownButtonMediumSelected_png$6ed0c74d67a08a4b4c39d8f611557420-1872173221§;
      
      private static const GreenButtonMedium:Class = GreenButtonMedium_png$341756f7fd3c7c4cb948b340e16c2f24202580965;
      
      private static const GreenButtonMediumOver:Class = GreenButtonMediumOver_png$79c79cc24ff2d72cac23888c059dfd931929925585;
      
      private static const GreenButtonMediumSelected:Class = GreenButtonMediumSelected_png$b28e52652839d21b86b3fc4dd1e9bf955086888;
      
      private static const OrangeButtonMedium:Class = OrangeButtonMedium_png$b20244a92af8ed424f4f69d0e80779932099488256;
      
      private static const OrangeButtonMediumOver:Class = OrangeButtonMediumOver_png$16c64854b5e804fc2eb7a1d3b69af8911583628684;
      
      private static const OrangeButtonMediumSelected:Class = §OrangeButtonMediumSelected_png$52596f7b50c42606f2d4726d91ddded0-133838901§;
      
      private static const RedButtonMedium:Class = RedButtonMedium_png$3cb1fe02b58036ecc8a5ff30ec9285ff819733883;
      
      private static const RedButtonMediumOver:Class = §RedButtonMediumOver_png$ee3c41ad0a2e53c573d3072b300333a6-1238148505§;
      
      private static const RedButtonMediumSelected:Class = §RedButtonMediumSelected_png$c61e4a5688d5457c128138ba35bc87b1-462524866§;
      
      private static const BlueButtonMini:Class = BlueButtonMini_png$0043aa8d196d603180811ced8040b0901173238324;
      
      private static const BlueButtonMiniOver:Class = BlueButtonMiniOver_png$285a014087e51614754c6cba8bfe035a790700960;
      
      private static const BlueButtonMiniPressed:Class = BlueButtonMiniPressed_png$39397dd2fafa839a606cee7d71a90bbe360035116;
      
      private static const BlueButtonMiniSelected:Class = §BlueButtonMiniSelected_png$da142a7680ddfd6610bb0b115708c9fa-151801857§;
      
      private static const BrownButtonMini:Class = §BrownButtonMini_png$6856c19cf1ef69f5a1fd4e9ab0774713-1674244052§;
      
      private static const BrownButtonMiniOver:Class = BrownButtonMiniOver_png$37742014793bc3829e56a54052b91995632870296;
      
      private static const BrownButtonMiniSelected:Class = BrownButtonMiniSelected_png$2042d6ba1b5e75954f72243173044fa22018665943;
      
      private static const GreenButtonMini:Class = §GreenButtonMini_png$9ced70419e0c4602159197d3c8f9a138-1700462815§;
      
      private static const GreenButtonMiniOver:Class = GreenButtonMiniOver_png$e382c0579762483f7f4d961c5b73f8e01511678253;
      
      private static const GreenButtonMiniSelected:Class = GreenButtonMiniSelected_png$dea69ed29f543c5d3904df9738a923f0992784356;
      
      private static const OrangeButtonMini:Class = OrangeButtonMini_png$a46473c01b47aebf50ae3ad5eb04516d908963712;
      
      private static const OrangeButtonMiniOver:Class = §OrangeButtonMiniOver_png$3b8ff15ef2772fb2816a3c722f12a747-1841952500§;
      
      private static const OrangeButtonMiniSelected:Class = §OrangeButtonMiniSelected_png$0a0e46a9bcef750eedd6921ce217d009-1845538997§;
      
      private static const RedButtonMini:Class = RedButtonMini_png$4efc5917abd53af438ec75aa9fd1bd5a577585847;
      
      private static const RedButtonMiniOver:Class = §RedButtonMiniOver_png$6cd7aec37a47dda308497d7eda1cf498-458818141§;
      
      private static const RedButtonMiniSelected:Class = §RedButtonMiniSelected_png$210d333be24f455aaab837aaf9dfd121-1464302726§;
      
      private static const BlueButtonSmall:Class = §BlueButtonSmall_png$32850b11d974a2e7b02c254bfb5063b3-2073749030§;
      
      private static const BlueButtonSmallOver:Class = BlueButtonSmallOver_png$2b9bcc4c92f52feba47871f512b14cc41906693702;
      
      private static const BlueButtonSmallSelected:Class = BlueButtonSmallSelected_png$9e578e35adbdf573b84753bf2bac7c0a632132509;
      
      private static const BrownButtonSmall:Class = BrownButtonSmall_png$b09f42bf00a35eca6d3b814d4ca55ec2338098870;
      
      private static const BrownButtonSmallOver:Class = BrownButtonSmallOver_png$b581b8b23f8470c6485e6fc3eeb4c674512367906;
      
      private static const BrownButtonSmallSelected:Class = §BrownButtonSmallSelected_png$ad83d5b9c84d94a3810c90688b992bab-2144237447§;
      
      private static const BrownButtonSmallSelectedOld:Class = §BrownButtonSmallSelectedOld_png$bc5597eebe08237286123eb5dd6ad851-1055990076§;
      
      private static const GreenButtonSmall:Class = §GreenButtonSmall_png$cf00ed9bda33fbb59c4ee62729686836-945570367§;
      
      private static const GreenButtonSmallOver:Class = GreenButtonSmallOver_png$28451d3d64ee15c244994ae4d0e972e91453285325;
      
      private static const GreenButtonSmallSelected:Class = GreenButtonSmallSelected_png$3b578d2ef403919d5d469b559520b12e1785465988;
      
      private static const OrangeButtonSmall:Class = OrangeButtonSmall_png$2f0381285113e8dd0eb268b13df347f71993914382;
      
      private static const OrangeButtonSmallOver:Class = §OrangeButtonSmallOver_png$0a1c612ebe63adbc5d5eaac5e0d119b5-708199174§;
      
      private static const OrangeButtonSmallSelected:Class = §OrangeButtonSmallSelected_png$d18dcdc6ff41cd079fa1680294ba4e42-1605071311§;
      
      private static const RedButtonSmall:Class = §RedButtonSmall_png$70823c427056a7237dd3ddad93265097-1016332941§;
      
      private static const RedButtonSmallOver:Class = RedButtonSmallOver_png$7cb93010da630134f77a45a5ce6c40ab1174943359;
      
      private static const RedButtonSmallSelected:Class = RedButtonSmallSelected_png$83e2b57c4bf1ceb06efedef44a6db1cc1514257974;
      
      private static const Combobox:Class = §Combobox_png$28b9a016532574c5947614a9fe7c8f55-1115075276§;
      
      private static const ChatGreenBaloonBackground:Class = ChatGreenBaloonBackground_png$8d9da0bfb38b28a24c51fc4672317d741157463849;
      
      private static const ChatYellowBaloonBackground:Class = ChatYellowBaloonBackground_png$97f7dc9ee64e01012e7d5eeb0b3190ae1635602282;
      
      private static const Minus:Class = §Minus_png$f1bf6664bf769474ab8f7538e910abb6-319934742§;
      
      private static const MinusOver:Class = §MinusOver_png$afe2bdbe32afe05d741a572c4ea47921-1954834602§;
      
      private static const Plus:Class = §Plus_png$caf5f7f3796e6ea508ad6ece83b4ebb9-1200605898§;
      
      private static const PlusOver:Class = §PlusOver_png$a77e90c9c306a18bbfbbea10f08d8a87-2034264670§;
      
      private static const MainQuestPreviewComplete:Class = §MainQuestPreviewComplete_png$3af893a1e376c5807e0d553685d8fc8b-1826717526§;
      
      private static const MainQuestPreviewYellow:Class = MainQuestPreviewYellow_png$f684a4f53d340ee35c91dc8c8218e4121009819245;
      
      private static const QuestHintNormal:Class = QuestHintNormal_png$8f3b82fc566d0bd025de4f2b8c385889432142421;
      
      private static const QuestHintOver:Class = §QuestHintOver_png$cedc9018859e973f172cbc95dbdfdb34-1246390518§;
      
      private static const CheckBox:Class = §CheckBox_png$fd309e428a0c9b808de4c9cebde2dc3e-444495360§;
      
      private static const CheckBoxSelected:Class = CheckBoxSelected_png$bb8186fd94626692238360ccadc197032147232715;
      
      private static const RadioBtn:Class = RadioBtn_png$785aae0840a2ba9d9b237ea83a80e2402005303366;
      
      private static const RadioBtnSelected:Class = §RadioBtnSelected_png$82d750e0286ddb26397c3ac3f125cd4b-1364046327§;
      
      private static const RadioButton:Class = RadioButton_png$20b0bcdebb92f915f18352e836d26efe1474351958;
      
      private static const RadioButtonSelected:Class = §RadioButtonSelected_png$dd81efd2c43f6644d1fbbcb9f6880cce-765165287§;
      
      private static const Tick:Class = Tick_png$c446081755c0ae1aff890a753194a6c11314820618;
      
      private static const ScrollInside:Class = ScrollInside_png$c7aac784de87ee2139510611d4c8c268202877749;
      
      private static const ScrollSkeleton:Class = §ScrollSkeleton_png$65760f75fa305c311e8cb1d8b5a51ec1-1291330682§;
      
      private static const ScrollSkeletonBottom:Class = ScrollSkeletonBottom_png$4546bd37f98e129aaa31ca1aaa1c5805961050649;
      
      private static const ScrollSkeletonTop:Class = §ScrollSkeletonTop_png$abb98b920ae85a5d58f00a1990ba823e-1325902003§;
      
      private static const IconOffline:Class = IconOffline_png$d463dc18c6f470f8cccc31da0948a367293628182;
      
      private static const IconOnline:Class = §IconOnline_png$e716bc41ccd6bcae1ad8c6817198cd78-1237872994§;
      
      private static const ChatInput:Class = §ChatInput_png$71b9e351c4442c8bc9b9018e523f383d-320262138§;
      
      private static const TextArea:Class = TextArea_png$2122fdf4992c4ecaabab59817cfe68c1972915316;
      
      private static const AllianceBoostIconArmor:Class = AllianceBoostIconArmor_png$fb0d92ccdc74532fa0d71786a462118b1737855689;
      
      private static const AllianceBoostIconBarrackSpace:Class = §AllianceBoostIconBarrackSpace_png$a28c7cc629bea3e4385263fb6d12bfc3-985239744§;
      
      private static const AllianceBoostIconDamage:Class = §AllianceBoostIconDamage_png$2e1356457615964d8528a0d65318fd5f-1585025101§;
      
      private static const AllianceBoostIconTower:Class = §AllianceBoostIconTower_png$8d9e3bc2f1a6a9e64b4e728802868bed-1103863293§;
      
      private static const IconRank1:Class = §IconRank1_png$6c0b46f68f6f8735893c37578d752c51-868637670§;
      
      private static const IconRank2:Class = §IconRank2_png$de3c2ef4316e7d9f1808670d356ea8f7-871646053§;
      
      private static const IconRank3:Class = §IconRank3_png$f85637b3e2e620e9161f317ff61b135f-870476012§;
      
      private static const CeltMap:Class = CeltMap_png$2b09b20f44b0543013bc5a918153f0f01299172610;
      
      private static const PlagueMap:Class = §PlagueMap_png$9f305b6ce6c4eab7e26912ca340eda12-1388386294§;
      
      private static const GuestAvatar1:Class = §GuestAvatar1_png$31bb3f09dab38087ae91f43459f91c75-717696624§;
      
      private static const GuestAvatar2:Class = §GuestAvatar2_png$c8efb9328a2fcf4964bde75944a8ab65-720689135§;
      
      private static const GuestAvatar3:Class = §GuestAvatar3_png$e544799548f811074de02ab3f7e34b42-719519598§;
      
      private static const GuestAvatar4:Class = §GuestAvatar4_png$d5c085ad87871a327be0178639c4527a-714138861§;
      
      private static const GuestAvatar5:Class = §GuestAvatar5_png$97beee244e1e15caacbd32dac0e8ad1b-713985108§;
      
      private static const GuestAvatar6:Class = §GuestAvatar6_png$0461343a5b409d2589b3017dd7bf0765-717010387§;
      
      private static const DemonKingMap:Class = DemonKingMap_png$3bd666ea46fc0be3f2c6150c19dbcd3f1225949374;
      
      private static const IronHandMap:Class = IronHandMap_png$6f2385544ccefd2c5bd2c97545049dd3469784719;
      
      private static const RagingBullMap:Class = RagingBullMap_png$8e1a89d72e7c7fb144bba93bf298ba9d722192849;
      
      private static const ShriekingDragonMap:Class = ShriekingDragonMap_png$7704de4b2751600904824f84e035a9ca1014243357;
      
      private static const GermanicHunterAvatar:Class = GermanicHunterAvatar_png$4fa8e79ca8d60b69ebbb86ed5fe314531670311441;
      
      private static const TutorialDefenderIcon:Class = §TutorialDefenderIcon_png$5750d293ef94302836204f8df23b3be8-357173422§;
      
      private static const AllianceEventIcon:Class = AllianceEventIcon_png$bce10ee14a08a2f9cd1f77582c559f5f1733572736;
      
      private static const BPEventIcon:Class = §BPEventIcon_png$992807b376ba236da194ebd066e5ebe1-2095971911§;
      
      private static const EventCanvasStoreIcon:Class = §EventCanvasStoreIcon_png$f86423b00733642ed5767c4d62525139-2137070462§;
      
      private static const EventCeltIcon1:Class = EventCeltIcon1_png$7f7e61ffea633a57a70485d011135617824569046;
      
      private static const EventCeltIcon2:Class = EventCeltIcon2_png$eea18e673a2de94a76b7e14abab872ac825739095;
      
      private static const EventIcon1:Class = §EventIcon1_png$b09c5b665dbd27484fdbbdd64fa431b4-1570297304§;
      
      private static const EventIcon2:Class = §EventIcon2_png$a2367b602251d49c5959518e9e743e06-1570176343§;
      
      private static const EventPointIcon:Class = EventPointIcon_png$a64e6d9aac30d0573d9e7eab36ac8e45456962553;
      
      private static const IronEventIcon:Class = §IronEventIcon_png$33cc2870b8c35e6602c569509dd43fa3-1374998249§;
      
      private static const Cross:Class = §Cross_png$c6aa36b8cc4b381ab1d48beecfb628fd-480191086§;
      
      private static const FortifyIconBig:Class = §FortifyIconBig_png$fd4fce8a0921ab1289f6e1f01fadaff3-1119846622§;
      
      private static const FullscreenIcon:Class = FullscreenIcon_png$5f5ffd65df49c483f2f6ee87f51253171246890304;
      
      private static const Gold27:Class = Gold27_png$6fe9542578ca1249714888b500c071c4258204945;
      
      private static const GridIcon:Class = §GridIcon_png$6619cfc109c738b3f506c2527dc9a91e-1408040165§;
      
      private static const IconCancel:Class = IconCancel_png$04fd6fd939aac0acbeb9588274110df0772671175;
      
      private static const IconCancel2:Class = §IconCancel2_png$689fc239048856efc0774b9d869edccb-1664065199§;
      
      private static const IconGoldMini:Class = §IconGoldMini_png$7ffb0bf536625ab13fcb4fd3e49286e4-676872028§;
      
      private static const IconLockBig:Class = IconLockBig_png$0accd5cc56d083ad51817d8c97c7a3361112128822;
      
      private static const IconRefresh:Class = §IconRefresh_png$2b9da94b4cdeda1cf91498233bc58a75-1352812852§;
      
      private static const IconSearch:Class = §IconSearch_png$c80c8074285a52550914d1c13d243eb4-1994705163§;
      
      private static const LeaderBoardBordered:Class = §LeaderBoardBordered_png$a0afad35f54e5bc0df0d3e9119e43d6d-1212527382§;
      
      private static const LeaderBoardBronze:Class = §LeaderBoardBronze_png$85a6eea04d0772d0d9ca3114953b6aa9-872000327§;
      
      private static const LeaderBoardSilver:Class = §LeaderBoardSilver_png$cc3b7b587728af71db624623a215769b-1657870172§;
      
      private static const LoadingIcon:Class = §LoadingIcon_png$fd2832c47e4467848a0f87e1aed9f010-347846401§;
      
      private static const Lock:Class = §Lock_png$8717471b83e31373a1ff7f735bcd5948-115948433§;
      
      private static const MercenaryLevel41Px:Class = MercenaryLevel41Px_png$b18005b1c7374a8d569a481d2688ce3110537863;
      
      private static const TakePhotoIcon:Class = TakePhotoIcon_png$7ce2125e5cacf24a6d466890c3e9e8a31061569006;
      
      private static const Upgrade:Class = §Upgrade_png$62405027ab462690f46b66e5bde71492-266967882§;
      
      private static const GoldDouble:Class = §GoldDouble_png$158d65cf2be70b28e178857011639d95-1517025678§;
      
      private static const GoldFortune:Class = GoldFortune_png$9b010e48e722c51f9b0712c83c50e4441251596742;
      
      private static const HelpHarvest:Class = HelpHarvest_png$82effd9d6740c9db1d788ac47596f050154474205;
      
      private static const HelpMercenaries:Class = HelpMercenaries_png$00dd99b38f0ac131a26dea7acb3ce58e1053196912;
      
      private static const HelpTime:Class = §HelpTime_png$001581b9199dec6329fd6a0d5fcdb364-1013019017§;
      
      private static const IconMarksmanship:Class = §IconMarksmanship_png$8102dbd67277b5a4cd05577d30ed9117-1553221384§;
      
      private static const IconRangedDarts:Class = §IconRangedDarts_png$d904902e278669d6bafdb66177a0d98f-148722253§;
      
      private static const CatapultLumber32:Class = CatapultLumber32_png$a01203ad5f80324fea2ca6df1ed067f2483172913;
      
      private static const CatapultLumber45:Class = CatapultLumber45_png$89434150c03e433089793a8f3c75daae451904211;
      
      private static const CatapultMight32:Class = CatapultMight32_png$2ac01c0114ab5e494fb1eba404d16b811832028053;
      
      private static const CatapultMight45:Class = CatapultMight45_png$81e1f193f22d26264f3ea1ceda4ef26f1809180343;
      
      private static const CatapultStone32:Class = CatapultStone32_png$7d7643ba828c9c9e3a8a7dd3039f13b71487117419;
      
      private static const CatapultStone45:Class = CatapultStone45_png$748b84a6e587c8f68be1c79a5fa71fdc1464008453;
      
      private static const Clock45:Class = Clock45_png$08a0ea6ee8de6e7e245ed4442df409091650899750;
      
      private static const IconLootGainedBig:Class = IconLootGainedBig_png$43ecfd86decde8e8f8a73225a17fb9d1238358800;
      
      private static const Iron45:Class = Iron45_png$78b9edc8fdf05158d00c81bc26a7c34c160132648;
      
      private static const Lumber45:Class = §Lumber45_png$9f9eb5c586581b501160babf20bb6fd7-1569316565§;
      
      private static const Might45:Class = Might45_png$15e64db5882876c92ba0af3757512c77747365759;
      
      private static const RP41:Class = RP41_png$f6472d2863ec2a78e38ad88e2e95c130804603258;
      
      private static const Stone45:Class = Stone45_png$d97323e23df4dc9973fa9fc476872ea1406387661;
      
      private static const CollectedGold:Class = CollectedGold_png$c31c6f35d0bb54917c36fa90112d7637569259421;
      
      private static const CollectedIron:Class = §CollectedIron_png$6111f6db1ddf467d2093985eb23d1bb2-1378962059§;
      
      private static const CollectedLumber:Class = §CollectedLumber_png$b21da3ff79dd26ba72e03649dbf6eec7-668008656§;
      
      private static const CollectedMight:Class = CollectedMight_png$e240814c47bbf19f564e9730ce06c33c683193744;
      
      private static const CollectedPart:Class = CollectedPart_png$87387cc148ffc382f9eff1cf961e3ac11948242856;
      
      private static const CollectedResource:Class = §CollectedResource_png$05f29574c63292e96456ba35462f9ad2-1640947149§;
      
      private static const CollectedRp:Class = CollectedRp_png$09bf664a78b69d18578c7894dc052e7e307614051;
      
      private static const CollectedStone:Class = CollectedStone_png$11917a16b390ceb706b23a05535ec52f1202163430;
      
      private static const TournamentRewardIcon1:Class = TournamentRewardIcon1_png$a980373bda2d89048b680d19e9bb6c072014592029;
      
      private static const TournamentRewardIcon2:Class = TournamentRewardIcon2_png$36326b1dc147f7d671a99bb59e004edd2019955870;
      
      private static const TournamentRewardIcon3:Class = TournamentRewardIcon3_png$49b5fc70810f190a622a2d130f2fecb62020110111;
      
      private static const LikeBtn:Class = §LikeBtn_png$e3f6e686aad3f14ae4f2975809eeb348-914219028§;
      
      private static const CityLoadingHourglass:Class = CityLoadingHourglass_png$607e0f5fd2ca4d93fd5b057ba20a4e8a1446398877;
      
      private static const CityLoadingMap:Class = §CityLoadingMap_png$f5f08c1dde30582c9309963b85f0eab5-174939687§;
      
      private static const ChatArrowUp:Class = ChatArrowUp_png$9d5e13acf6738826b5fb6f8cb8affd83850791198;
      
      private static const ChatArrowUpOver:Class = §ChatArrowUpOver_png$cd880ad43de0ce25f7d60e9bc12ab111-1037760630§;
      
      private static const ChatBackgroundTopCorner:Class = §ChatBackgroundTopCorner_png$c57795e74ef964880e583fbdee12bd75-1437519482§;
      
      private static const ChatIcon:Class = ChatIcon_png$e8defedb8ff8c6c957a08ec38040c58013301453;
      
      private static const ChatTabButtonSelectedSide:Class = §ChatTabButtonSelectedSide_png$0af20a0a865b44be19e875be9f5ea03a-672630229§;
      
      private static const ChatTabButtonSide:Class = ChatTabButtonSide_png$596d80b949eeb0e9fa6d163eea9a4934682995168;
      
      private static const AddFriendPlus:Class = §AddFriendPlus_png$c0e7ccbb1d55cd6da9c7591b2696aae4-1108725797§;
      
      private static const AttackscomeinBar:Class = AttackscomeinBar_png$b4436c2b5490156fbc77ec490d179e291652976251;
      
      private static const AvatarBackground:Class = AvatarBackground_png$e3a8e85f3650974db891f0cce3b79623671332467;
      
      private static const AvatarBackgroundHover:Class = §AvatarBackgroundHover_png$234b5e4c29fc98109845de0ead3db1e0-2081148001§;
      
      private static const AvatarBackgroundSelected:Class = AvatarBackgroundSelected_png$ad964b2c9f6a22e8f0665898225b8f6199253558;
      
      private static const Back:Class = §Back_png$93f9db2e4a8259331c40cd6c8f7dd57f-381556365§;
      
      private static const BackHover:Class = BackHover_png$1223208df203d0f67c73ccdb81c6fdca744530591;
      
      private static const BlueMinusIcon:Class = BlueMinusIcon_png$74d9c36b994f19a14dcc47d1586c68121273708993;
      
      private static const BluePlusIcon:Class = BluePlusIcon_png$4d00f040dfd60396fa1c49fff5fe243b1494425673;
      
      private static const BuildDeselectIcon:Class = §BuildDeselectIcon_png$27aeeca0a8dc542874768dd2ccb96742-1693272210§;
      
      private static const BuildIcon:Class = BuildIcon_png$4961cb092c4812064cfbaaca94a572db280500233;
      
      private static const BuildIconHover:Class = §BuildIconHover_png$c38bd25529f6649e836b45223f168193-1629704255§;
      
      private static const BuildingProgress:Class = §BuildingProgress_png$f8d2795b4b9cc53e4a1640d737fd8b40-206403179§;
      
      private static const BuildingProgressBar:Class = BuildingProgressBar_png$d3847e244b0837a54321a599bfc14b412080594460;
      
      private static const ButtonWarDisable:Class = ButtonWarDisable_png$f8284f64578bafcdf9b2dc2cde119a5e2138249030;
      
      private static const ButtonWarNormal:Class = §ButtonWarNormal_png$18ccc239246b5779323607ad5c4278d2-1959626089§;
      
      private static const ButtonWarPaid:Class = ButtonWarPaid_png$15e93ddfd29358a9a388c8b0a5f52db11339229388;
      
      private static const CityLoadingCardBackground:Class = §CityLoadingCardBackground_png$385676453633c07ab8e5a746390cb773-1802539519§;
      
      private static const CombatResourceIcon:Class = CombatResourceIcon_png$fabe668468505ebea48b33a7c5dab31f1553066527;
      
      private static const CrownIcon:Class = §CrownIcon_png$70255d9f38b0ee8b9df7eb19ac08ff6e-1306878270§;
      
      private static const DeselectIcon:Class = §DeselectIcon_png$0ffcc81e9e40f740c41fd86dd6fd360b-2101160990§;
      
      private static const ELOEmpty:Class = §ELOEmpty_png$0865c5c892b812cc651ffe5336fc3d1e-525203439§;
      
      private static const ELONegative:Class = ELONegative_png$f26cc8482d59976189f725e775522414417299767;
      
      private static const ELOPositive:Class = ELOPositive_png$ae687cb049654a1ca9cc0a873876ee2d46547315;
      
      private static const EngageBtn:Class = §EngageBtn_png$fb746acd16e06e01900871d6faec8a9d-746229451§;
      
      private static const EngageBtnOver:Class = EngageBtnOver_png$1e34646727a233e015905e784e5c1cd21924200737;
      
      private static const ExperienceBar:Class = §ExperienceBar_png$c3b36b402b653df95ff90fc4fdb1e2e2-904226741§;
      
      private static const ExperienceProgressBar:Class = ExperienceProgressBar_png$f79784274379a89dcd9e9e485bc6bebd392513622;
      
      private static const ExperienceStar:Class = §ExperienceStar_png$ebdcb2ee915af9322d284cd2903085bb-1541050312§;
      
      private static const First:Class = §First_png$01a36088b0f72a803a1edd7aeffb594a-1096034142§;
      
      private static const FirstHover:Class = FirstHover_png$3d577ee0290f919172a5ad7e66859a5b1699417544;
      
      private static const FortifyDeselectIcon:Class = FortifyDeselectIcon_png$90ac4a220f729e3844819b185fbe829579701001;
      
      private static const FortifyIcon:Class = §FortifyIcon_png$a13e435cbce4805ab0414ff485fd4636-1822514140§;
      
      private static const FortifyIconHover:Class = FortifyIconHover_png$ca4041eebbaa18b3d62c66bc8f157ae42122466310;
      
      private static const FreeCoins:Class = §FreeCoins_png$04c64fd48f932bc6214178eaca3037e7-994588936§;
      
      private static const FreeCoinsHover:Class = §FreeCoinsHover_png$2833cf722040c7a2240751b2dd6176e2-794078670§;
      
      private static const FullScreen:Class = §FullScreen_png$d1b98f49d6116de7b9a186a71434735b-1121048513§;
      
      private static const FullScreenHover:Class = FullScreenHover_png$4b75b5813801721330a57e2059b6445e2039972691;
      
      private static const GetWomkong:Class = §GetWomkong_png$220577ba98dbb5f632aca845a6815a3d-249196456§;
      
      private static const GetWomkongHover:Class = §GetWomkongHover_png$426265b181b8347cdbd9d50a9f5b1886-192627630§;
      
      private static const Gold:Class = §Gold_png$fd609a520aa137a7faf9a8a891bc7c7d-293879692§;
      
      private static const GoldBackgroundSide:Class = GoldBackgroundSide_png$752bb9437cd3adb5d8873f0605ef4ece1504604145;
      
      private static const GreenPlusIcon:Class = GreenPlusIcon_png$21049a1bb0d8c7191aed8815fc5cf7411471328728;
      
      private static const GreenPlusIconBig:Class = GreenPlusIconBig_png$768213d2df976f36cfd223a568213dc5370073454;
      
      private static const IconVideo:Class = §IconVideo_png$d085fb1b336661090f48b66ab3f2ed03-1948884468§;
      
      private static const IconVideoHover:Class = IconVideoHover_png$99f2cea4d758734bd3d0d0dc6a9315981817321790;
      
      private static const Iron:Class = Iron_png$157348608fc5ee03296e275928ea3c3a1515733484;
      
      private static const IronProgressBar:Class = IronProgressBar_png$7c386e8ff959bc919d8259910a4c7b662096197488;
      
      private static const Lumber:Class = Lumber_png$a5c3ba6aaa90838e4487276a40bb088e1934707055;
      
      private static const LumberProgressBar:Class = §LumberProgressBar_png$0a013eb864f27d483679d36671e32f8a-327759979§;
      
      private static const MainframeStashNewGift:Class = §MainframeStashNewGift_png$81ee36e19f3a23a059bc5495be372be6-1408833887§;
      
      private static const MenuBarRight:Class = MenuBarRight_png$62c75b72ee1a63b26dc626a8088444d61218936684;
      
      private static const MenuBarRightShadow:Class = §MenuBarRightShadow_png$4896639dfda5f1fabe6f1f92167c7eff-410854932§;
      
      private static const Might:Class = §Might_png$7b7f16d347ed68030ddc98b5d5650873-370865639§;
      
      private static const MightProgressBar:Class = §MightProgressBar_png$23cb837adb1eae1f35ce5ede100241fc-87460309§;
      
      private static const MoveDeselectIcon:Class = §MoveDeselectIcon_png$9d09e37c653973a8ace249b6e59fb9ed-1863288237§;
      
      private static const MoveIcon:Class = §MoveIcon_png$a3ed64c43457653b459558d072409bc2-58494962§;
      
      private static const MoveIconHover:Class = §MoveIconHover_png$6ffcc3bd960d475e00542bb78847677a-1767521796§;
      
      private static const MusicOff:Class = §MusicOff_png$003d086fc4a50856ae703accf6bda115-1335188178§;
      
      private static const MusicOn:Class = §MusicOn_png$12be3d018112a1d82f16919ec63e8a0b-354813650§;
      
      private static const NotificationCircleIcon:Class = NotificationCircleIcon_png$6fdc6451ddbe4390c4d5748d8b9ab3b2198068480;
      
      private static const PanelBottomSide:Class = §PanelBottomSide_png$7f1fa1a8db5418cb5b382341207faf6d-118464888§;
      
      private static const PanelTopLine:Class = PanelTopLine_png$1ad8d6c73e4c1751ab9d6bdd8f2d345b249271761;
      
      private static const PanelTopSide:Class = PanelTopSide_png$5f4be90a8275b3eeb422810af20f2c151211322828;
      
      private static const ProgressBar5:Class = §ProgressBar5_png$a0914a6f98f8fe72a7d86509aa9e8bdc-1428689173§;
      
      private static const ProgressBarFull:Class = ProgressBarFull_png$7af2172e78045e856641898ec7df1d891897379103;
      
      private static const ProgressBarLine10:Class = ProgressBarLine10_png$bbc0b23fcf976ed0770704b43f7c49b0834141403;
      
      private static const QuestTooltipYellow:Class = QuestTooltipYellow_png$88adec59b56f3043caeb6a9888fe026c2119488353;
      
      private static const RecruitProgress:Class = §RecruitProgress_png$6c1933c73a134c2acb7c2fad5303c1d0-244422459§;
      
      private static const RedAttentionIcon:Class = RedAttentionIcon_png$447762a60f4910f8bba8c3811ff8977f452881330;
      
      private static const ReinforceButtonProgressBar:Class = ReinforceButtonProgressBar_png$b36bc7a72e2f06ad1198d2194adc2aca383166933;
      
      private static const ResourceBar:Class = ResourceBar_png$a34e1c40551832454bc9b1933c8482481670676207;
      
      private static const Rp:Class = Rp_png$dc80a1c6d538db08b826eaaecfed7188138632730;
      
      private static const SelectIcon:Class = §SelectIcon_png$aedd30030840306aceb3a586f555c3e6-568957087§;
      
      private static const SelectIconHover:Class = SelectIconHover_png$e9e254771e42797e35822e06a704352d270021097;
      
      private static const SelectTooltipIcon:Class = SelectTooltipIcon_png$fdbf1e19008e1d0c3adfa1853c35b8e21731575154;
      
      private static const SelectTooltipIconHover:Class = SelectTooltipIconHover_png$5f46568d2833bc15ef5845ed9081df754422008;
      
      private static const SellDeselectIcon:Class = §SellDeselectIcon_png$b6ad6e10374564706ca4e780e498be38-2066880276§;
      
      private static const SellIcon:Class = §SellIcon_png$6b3d652d8a3ee6e236ed5d26c7d8bc5e-590938225§;
      
      private static const SellIconHover:Class = §SellIconHover_png$6634aee20250c695667819ad0acd2076-663950461§;
      
      private static const Settings:Class = Settings_png$8c5415f62e5e35b55339667b989119451138726071;
      
      private static const SettingsBackgroundCorner:Class = §SettingsBackgroundCorner_png$b1ff759a0c8fb0a594c4e45965d65fa9-2066968334§;
      
      private static const SettingsHover:Class = §SettingsHover_png$605d5b29bcef23a20e1f40dab47603fc-146353701§;
      
      private static const ShopIcon:Class = ShopIcon_png$54a2a80cc52a260951064121c1a3d486811279915;
      
      private static const ShopIcon50Discount:Class = ShopIcon50Discount_png$7707928779d940eda942c37cfee5f36b220870191;
      
      private static const ShopIcon50DiscountHover:Class = §ShopIcon50DiscountHover_png$f65a0fe6f89033dd02d6328bf45150d9-659062941§;
      
      private static const ShopIconHover:Class = §ShopIconHover_png$ad8e90b094801eba48066a92279d8815-1641026841§;
      
      private static const SoundOff:Class = §SoundOff_png$d19a1b6cdf558cc4e4377cef26bf1a84-1446884492§;
      
      private static const SoundOn:Class = §SoundOn_png$b1c1ae60bad81668d1365121bbc966f0-2107751040§;
      
      private static const SpecialOfferIcon:Class = SpecialOfferIcon_png$7c1283335b55e05e6cd7f993032d7b341464276952;
      
      private static const SpecialOfferIconHover:Class = SpecialOfferIconHover_png$23a4020f74efbe33493b8c8cedf3b86f321623762;
      
      private static const SplashOff:Class = SplashOff_png$53bddcb36d0a6e725b71060cbe662d2c788235530;
      
      private static const SplashOn:Class = SplashOn_png$b777d8e64ac6b974c1b69eb490a29bb5952047026;
      
      private static const SpyHoverIcon:Class = §SpyHoverIcon_png$0d911f16abe58654b48923457ea3eb84-1381076835§;
      
      private static const SpyIcon:Class = SpyIcon_png$476c553dee20831eb17516d9cd748a821591396895;
      
      private static const StashIcon:Class = §StashIcon_png$2cfe96e3786b04879bdf52f6af13e9ec-911711488§;
      
      private static const StashIconHover:Class = StashIconHover_png$3eb1c6394ea28de99fd4177f8cd0a988835643562;
      
      private static const Stone:Class = Stone_png$970d5ffd28e0e589994c7577d889a15e142632815;
      
      private static const StoneProgressBar:Class = §StoneProgressBar_png$802e649e4dc0dbcf83e785578a41e510-2060654187§;
      
      private static const UnderProtectionBackgroundSide:Class = §UnderProtectionBackgroundSide_png$bce4759069c5735a4c81827455b663e7-1898519720§;
      
      private static const UpgradeIcon:Class = §UpgradeIcon_png$f2da35d881a960e72e89af52a413087b-1052907137§;
      
      private static const UpgradeIconHover:Class = UpgradeIconHover_png$107587915987ef6dd711eaf0e2c7561f1472100883;
      
      private static const UpgradeIconHoverOver2:Class = UpgradeIconHoverOver2_png$a4499ce8f6ec8901e99ba87eed0940c3960608281;
      
      private static const WarIcon:Class = WarIcon_png$d33efcbce01f3a6034bdeaf2b9e6a3f31229269811;
      
      private static const WarIconDisabled:Class = WarIconDisabled_png$3b56388d0b9587097a3bbf2f823227a3141286487;
      
      private static const WarIconHover:Class = WarIconHover_png$b71db7aeeeaf4172e4b617b759e17cd91308494047;
      
      private static const WhiteFlag:Class = WhiteFlag_png$362b5cb1fc413be1d8600a0ebd5ac39e19942463;
      
      private static const WorkerBarSide:Class = WorkerBarSide_png$a9163583b97187227f6e13868325dbe81376847782;
      
      private static const ZoomIn:Class = ZoomIn_png$a0068f37bd7cc7ce3396dda4c90d753d1252130236;
      
      private static const ZoomInHover:Class = §ZoomInHover_png$db6a34cf5c233a76971631c64c6800c0-2091304562§;
      
      private static const ButtonEndAttack:Class = §ButtonEndAttack_png$2ff0374fcb93f46a5ebff4b941376987-1211876513§;
      
      private static const IconGreenPlus:Class = §IconGreenPlus_png$f1fe8390d0ca10fa8dfa7c9e8f7beffd-1840030102§;
      
      private static const LumberSalvo:Class = §LumberSalvo_png$6ac19b9f0e21eb051681dd615809e83e-1539450462§;
      
      private static const LumberSalvoLarge:Class = LumberSalvoLarge_png$3b288657d66f7dd40fff2ea94adf59331349812815;
      
      private static const LumberSalvoMedium:Class = §LumberSalvoMedium_png$3ab20eeced22e019ee6fdf69b873436e-1247391601§;
      
      private static const LumberSalvoSmall:Class = §LumberSalvoSmall_png$c37e2f2bdd9ea4f87d12ee8ec5121f3c-565797245§;
      
      private static const LumberSalvoXlarge:Class = LumberSalvoXlarge_png$7dde29085dcf56938c2c0ab1f5ffeb021551987549;
      
      private static const MightyBoost:Class = MightyBoost_png$86bfc7647f7f384932ff99f5e0d79f931385682415;
      
      private static const MightyBoostLarge:Class = §MightyBoostLarge_png$58a0f8846042ef9eea6fe512895e0603-830496990§;
      
      private static const MightyBoostMedium:Class = §MightyBoostMedium_png$5de31e26b20210f7ea06e8f87f45d4c1-1753601804§;
      
      private static const MightyBoostSmall:Class = §MightyBoostSmall_png$f2fef4793d389b541f3071acd3cc2267-1136530570§;
      
      private static const MightyBoostXlarge:Class = §MightyBoostXlarge_png$41879ef27a75a085b858efead7b5e56a-1113273526§;
      
      private static const StoneBomb:Class = StoneBomb_png$68f9f0fa2678ac7e3f83b975aeadd2ec140612165;
      
      private static const StoneBombLarge:Class = §StoneBombLarge_png$0ee6f12d539768ea1d8bb73e940ef73b-26947964§;
      
      private static const StoneBombMedium:Class = §StoneBombMedium_png$bc81ec0774885f8b831f7351cd924a52-373387822§;
      
      private static const StoneBombSmall:Class = StoneBombSmall_png$6c54a2f5dd0faecdf4d6c3cac05b69931819728600;
      
      private static const StoneBombXlarge:Class = §StoneBombXlarge_png$1ff78996c5df44257ff26b74724bf101-258364256§;
      
      private static const TimerBackgroundSide:Class = §TimerBackgroundSide_png$6b7c5c509ad2391a516502e581d6c67c-1408423648§;
      
      private static const TimerNumberBackground:Class = §TimerNumberBackground_png$4bfc7b0483b47a674b73e08bf9a2ba0a-1006092462§;
      
      private static const VictoryMeterBase:Class = VictoryMeterBase_png$51cb84d880dafacaded2fd05c0e244cb16523248;
      
      private static const VictoryMeterBlack:Class = VictoryMeterBlack_png$57a3126058b6bf31c355a6117b6819b1362513606;
      
      private static const VictoryMeterGreen:Class = §VictoryMeterGreen_png$ae9ce55339e9cccf05d6dbac7035b3b7-912156222§;
      
      private static const VictoryMeterIndicator:Class = §VictoryMeterIndicator_png$221b99a34d13311854269a71e79a0944-1645836586§;
      
      private static const VictoryMeterIndicatorRed:Class = §VictoryMeterIndicatorRed_png$cf31774d23281dfa734cfd52b8c90418-455396575§;
      
      private static const VictoryMeterIndicatorWhite:Class = VictoryMeterIndicatorWhite_png$e45e465c8ac3d41dd60a66c61b0a4c8c325410697;
      
      private static const VictoryMeterRed:Class = VictoryMeterRed_png$807f8506158a35fdcb1626774c93a87c1386914640;
      
      private static const VictoryMeterYellowBackgroundCorner:Class = VictoryMeterYellowBackgroundCorner_png$1513342cb6de0256de4bea19ce0a08dc1349041134;
      
      private static const DefenceViewBar:Class = DefenceViewBar_png$36ed963c46dfee9759efe769b7edb18d1738733315;
      
      private static const DefenceViewLine:Class = §DefenceViewLine_png$16130cbe9d053686b95dc7e747ee3121-988900478§;
      
      private static const HelpRPOff:Class = §HelpRPOff_png$76af07b21c7ae0f8ee6f10331443a7f7-2082166125§;
      
      private static const HelpRPOn:Class = §HelpRPOn_png$5064a41403e06a7b875497c99a3ac41a-474057463§;
      
      private static const HelpScreenHomeIcon:Class = HelpScreenHomeIcon_png$f99f3c16fd55f625b82a88409682d2431380816672;
      
      private static const HelpScreenHomeIconHover:Class = §HelpScreenHomeIconHover_png$1aae8eea9d34e63c45fe05b74f5e1415-2062561142§;
      
      private static const BombsTooltipIcon:Class = §BombsTooltipIcon_png$8f1f4215f1965691f7feb9a45187b6a7-406092369§;
      
      private static const MercTooltipHead:Class = §MercTooltipHead_png$c8a0d6234beaa122651b5b54a8f5af93-1633068300§;
      
      private static const ResourceBasketTooltip:Class = §ResourceBasketTooltip_png$f05fd05d72308f8a73692a6bcfbf21e7-569190239§;
      
      private static const SwordTooltipIcon:Class = §SwordTooltipIcon_png$c264a1fb6b5554cfb8c254e12880a36e-1676429509§;
      
      private static const TooltipsBackground:Class = §TooltipsBackground_png$cf872fb7c78e96706c1a53555d64492b-593032518§;
      
      private static const TooltipsBottomPin:Class = §TooltipsBottomPin_png$7e90de208a6f719cf1c193789cbe257c-1721889228§;
      
      private static const TooltipsInner:Class = TooltipsInner_png$c7ee0d631c7b4e1c301c561e6955e79a1410068904;
      
      private static const TooltipsLeftPin:Class = §TooltipsLeftPin_png$40cc7ed26ca698a378fae2fb420431df-1371805040§;
      
      private static const TooltipsRightPin:Class = TooltipsRightPin_png$f76509d89df041146a2b4e1128b1d4e5257752109;
      
      private static const TooltipsTopPin:Class = §TooltipsTopPin_png$ff9be1a2fe38977e97f3db48b64ce135-1782379004§;
      
      private static const Map1ListOffline:Class = §Map1ListOffline_png$59f94f06e90197bc7f9aef4d9b55c4ae-1801546495§;
      
      private static const Map1ListOnline:Class = Map1ListOnline_png$f907eb1bcb7bf18ce43af5ae9608f38a920608563;
      
      private static const Map1NCLIcon:Class = Map1NCLIcon_png$ca9ea6656cc782fb36bd056ce99d1c69734992660;
      
      private static const MapFilterArrowDown:Class = MapFilterArrowDown_png$9914d7001efcc47485fd2d04bb5e2c9f1217770172;
      
      private static const MapFilterArrowUp:Class = MapFilterArrowUp_png$0d81a7f6767778b7842ba65352883521441779301;
      
      private static const MapFilterDropdown:Class = §MapFilterDropdown_png$a5cdf28e889c36cd54fd7aeb937e16ed-1604983314§;
      
      private static const MapFilterNoArrow:Class = MapFilterNoArrow_png$945f49856d8304e3cf31481e7e6ff2551289322529;
      
      private static const MapOffline:Class = §MapOffline_png$679d05fb2333c01bf1283c63dc35ebe7-1256540564§;
      
      private static const MapOnline:Class = MapOnline_png$4fca7bcd34641f8ed1730fcd978d5a6a2009796608;
      
      private static const Level:Class = §Level_png$629fb958c255e427f56dd101f2a484b1-602661649§;
      
      private static const ListIcon:Class = ListIcon_png$40346f6e3a95a24680fb1b070157683e971922626;
      
      private static const LowLevel:Class = §LowLevel_png$50217dc686f8787991422b1f5c197a0b-1660577493§;
      
      private static const Map1ResourceBarIcon:Class = §Map1ResourceBarIcon_png$0cc8953add276f0ebebab227b5024a56-2084637820§;
      
      private static const Map1VisualMenu2:Class = Map1VisualMenu2_png$321dbc0e1c46336e34b6f9e9fe0ac1fd528273553;
      
      private static const Map1VisualMenu3:Class = Map1VisualMenu3_png$ae9fda955a88167a7bcc375fb5e5cb81525282066;
      
      private static const Map1VisualMenu4:Class = Map1VisualMenu4_png$95001c20e5accaeca1a52ce985c9095d525403027;
      
      private static const TruceActive:Class = TruceActive_png$4990b04fe494816b4ae214b056725224733546514;
      
      private static const TruceNone:Class = §TruceNone_png$7665bc85fe21044f5e4647ded50af9a3-27975780§;
      
      private static const UnderProtectionActive:Class = UnderProtectionActive_png$5e8f8aa0ee5cf4f5f6a31d12953b3f6a1060961690;
      
      private static const UnderProtectionNone:Class = §UnderProtectionNone_png$361ef68069a8ad2119394837d504aed9-931560188§;
      
      private static const LoadingBackground:Class = §LoadingBackground_jpg$ad9a276bf9233286417adc5565f266fa-217646190§;
      
      private static const LoadingProgressLight:Class = LoadingProgressLight_png$426833004e296c513f0ff46758feec76137655426;
      
      private static const LoadingProgressShadow:Class = LoadingProgressShadow_png$3900e81497202cfefdae710cd45ea94a861012018;
      
      private static const LoadingProgressTrack:Class = LoadingProgressTrack_png$9fef652a77101c23f4599fd264e3a3f193702863;
      
      private static const PeakGamesLogo:Class = §PeakGamesLogo_png$247a0b7b93be298a7544a09361719e8b-453263314§;
      
      private static const TutorialArrowBottom:Class = TutorialArrowBottom_png$63826fc84d936301a318b07722c32eca657753622;
      
      private static const TutorialArrowLeft:Class = §TutorialArrowLeft_png$f2cf74407b1cbbbe4a6ef1838fabab66-237165702§;
      
      private static const TutorialArrowRight:Class = TutorialArrowRight_png$15f6c9f8c6efc3b7735b9b409b7932f525927983;
      
      private static const TutorialArrowTop:Class = TutorialArrowTop_png$c6b5ccf2d7668c5ec54be8f2b8380e651182913360;
      
      private static const TutorialBack:Class = §TutorialBack_png$4ba50a615994d1af53410375e047339e-237290437§;
      
      private static const TutorialPose1:Class = TutorialPose1_png$824c4be82b3c4d516e4f7de33a9dc7ad1354866570;
      
      private static const TutorialPose2:Class = TutorialPose2_png$ecb1dd9fb86c599f641f117978ddc09b1356068363;
      
      private static const TutorialPose3:Class = TutorialPose3_png$29f81547f8d4b457b83af19d293d50751344654980;
      
      private static const TutorialPose6:Class = TutorialPose6_png$0320d606c718c731bd9c13326b3446a21342703623;
      
      private static const TutorialPose7:Class = TutorialPose7_png$f619d55e62aed048c3e419c12cdc21861343905920;
      
      private static const TutorialPose8:Class = TutorialPose8_png$65479b1c2e01381ce1a399454240007d1349286657;
      
      private static const ScoreBack:Class = §ScoreBack_png$b8f43e5d0be6e2707a3a70928b980988-1961830232§;
      
      private static const BeastCaveEvolution2Green:Class = §BeastCaveEvolution2Green_png$bdf47c3eec5142aa471cc2c63d01b615-1395521628§;
      
      private static const BeastCaveEvolutionBigNormal:Class = §BeastCaveEvolutionBigNormal_png$ed13b0dd8c498c9019b500b9ffc21ed9-1106922070§;
      
      private static const BeastCaveEvolutionBigSelected:Class = §BeastCaveEvolutionBigSelected_png$89834db1b5b2ca2280bb2c66e1733117-1419507498§;
      
      private static const BeastCaveEvolutionLoadOver:Class = BeastCaveEvolutionLoadOver_png$24f30b5af2de8cc8e93a0c6c0908e9011659033661;
      
      private static const BeastCaveEvolutionNormal:Class = BeastCaveEvolutionNormal_png$7d99614fb63db6bbfc8d8aeade57e67f701892530;
      
      private static const BeastCaveEvolutionSmallNormal:Class = BeastCaveEvolutionSmallNormal_png$a914fc98f239bdc377a24661e409659b692163425;
      
      private static const BeastCaveEvolutionSmallSelected:Class = BeastCaveEvolutionSmallSelected_png$b07ef1b871c14fb884ce5065cb4b61561445002349;
      
      private static const BeastKeeperCageChain:Class = BeastKeeperCageChain_png$c008f0ea69e6bfd48a2b8043adc0c6611386429330;
      
      private static const CantBuildIcon:Class = §CantBuildIcon_png$8f97936b915353ee56d20f90954c9f33-1272739293§;
      
      private static const CantBuildTooltip:Class = CantBuildTooltip_png$c9b57fb26fc1b706deef44087d5ec10c304512239;
      
      private static const CentralHiringBigProgressBar:Class = §CentralHiringBigProgressBar_png$41378d91cd3a10ba2de92f0e38048aa9-860741891§;
      
      private static const CentralHiringBigProgressBarInside:Class = CentralHiringBigProgressBarInside_png$1ac0fd4b743292baa2876fc0736e1dc81382568705;
      
      private static const CentralHiringLine:Class = §CentralHiringLine_png$62f511461de67db456a0ebb4162f3423-1722225325§;
      
      private static const CentralHiringNumber:Class = CentralHiringNumber_png$b96899ac9cf93f6fdc25ecf68b40756b170806968;
      
      private static const HiringQuartersClick:Class = §HiringQuartersClick_png$93eb93b76d4f433daa803504749b1483-1004748519§;
      
      private static const HiringQuartersHover:Class = HiringQuartersHover_png$9f22c3d506c6c47ec6f90a85fb0c18c2328718149;
      
      private static const CenterCrossIcon:Class = §CenterCrossIcon_png$812f6553e69fc06b0eb4dda337608374-316628890§;
      
      private static const CityPlannerBuildingNameBackgroundSide:Class = §CityPlannerBuildingNameBackgroundSide_png$6ee7c0356e237bcc0c1cd9eddfcb85a1-1759076387§;
      
      private static const CityPlannerFullScreen:Class = CityPlannerFullScreen_png$2431ad5447635c8536783865b15e3d542030712388;
      
      private static const CityPlannerFullScreenOver:Class = CityPlannerFullScreenOver_png$3bf3fd2eb5ca494abc16f2a0b58e0e24868523568;
      
      private static const CityPlannerLevelBg:Class = §CityPlannerLevelBg_png$31607c275ae351a9d1742a7bef7a21c4-926304962§;
      
      private static const CityPlannerZoomBar:Class = §CityPlannerZoomBar_png$c77445fe7c18d99e60b01e9cba703a9c-1609331195§;
      
      private static const CityPlannerZoomBarCursor:Class = CityPlannerZoomBarCursor_png$66c4a04cdd17556362516dabcd2f806b1319713907;
      
      private static const CityPlannerZoomIn:Class = §CityPlannerZoomIn_png$b325c38e5c5516b8425de63dfbf50426-24393399§;
      
      private static const CityPlannerZoomInOver:Class = CityPlannerZoomInOver_png$407127b168fe946dec22d533f494554d1528100789;
      
      private static const CityPlannerZoomOut:Class = §CityPlannerZoomOut_png$f72cd20bcfd14aee6d89b27f1355bd6b-1912217528§;
      
      private static const CityPlannerZoomOutOver:Class = §CityPlannerZoomOutOver_png$b3759eb58e521404ebeb89cf9d9c7eef-135186892§;
      
      private static const AllyWatchPostAvatar:Class = §AllyWatchPostAvatar_png$0e9225c28bba7b30faea0137c04458d0-575933364§;
      
      private static const AncientTelescopeAvatar:Class = §AncientTelescopeAvatar_png$756e688cca1657ac20ba576dea047c5e-786702499§;
      
      private static const ArchersTowerAvatar:Class = §ArchersTowerAvatar_png$71b3b97f23ce48c35ad61d9da554de64-1831012844§;
      
      private static const ArenaAvatar:Class = §ArenaAvatar_png$044edf8acb785f45b5ab2b098f81c0aa-1084293540§;
      
      private static const AssemblyAreaAvatar:Class = §AssemblyAreaAvatar_png$5562af50f33fffe7a5474189b45b19b1-1964675426§;
      
      private static const BeastCannonTowerAvatar:Class = §BeastCannonTowerAvatar_png$98f3c89e681f864276cd0f00c4bfde77-1010733280§;
      
      private static const BeastCaveAvatar:Class = §BeastCaveAvatar_png$fa4c675508a4364421e5c451aab9ba71-639645031§;
      
      private static const BeastKeeperAvatar:Class = §BeastKeeperAvatar_png$4e05f0b002f44c4553dfe686b80bb094-91252042§;
      
      private static const BlacksmithAvatar:Class = BlacksmithAvatar_png$a4b64d8858288eb4d5bd1d0cd5e38a881183850351;
      
      private static const BombardTowerAvatar:Class = BombardTowerAvatar_png$a377d49ea59272fdd58f9a03a7d467261628442971;
      
      private static const BuriedSpikesAvatar:Class = BuriedSpikesAvatar_png$b6e0d3cc95ce1401bf18e678ff5f71f41918820793;
      
      private static const BurningMirrorsAvatar:Class = BurningMirrorsAvatar_png$047f173195903662c1fae39afb2b72b91699879724;
      
      private static const CatapultAvatar:Class = CatapultAvatar_png$5f391f809193377129c8d40076735f17658724571;
      
      private static const CentralHiringAvatar:Class = CentralHiringAvatar_png$76d86029dbb72313e1e9bbc137bc36c3921140355;
      
      private static const CityBazaarAvatar:Class = §CityBazaarAvatar_png$3fc45b07f1b9fa7cb5947fcaebeebba0-1849646419§;
      
      private static const CityCenterAvatar:Class = CityCenterAvatar_png$4b4d31d4ad8736fa40f446ed098b99ac740724243;
      
      private static const CityPlannerAvatar:Class = §CityPlannerAvatar_png$63dc217c5919206fe92e9219141eea95-398754436§;
      
      private static const ConsularPostAvatar:Class = ConsularPostAvatar_png$876dd0cbdf0cdf7c92fe2c8f0dd4b30e679497716;
      
      private static const DecorationAvatar:Class = §DecorationAvatar_png$c516b804bcf2ea2ffbcdbc964266ddd0-1463201501§;
      
      private static const ExecutionalGuillotineAvatar:Class = §ExecutionalGuillotineAvatar_png$f22b50143fef282921ebfe1fa3a5b9f9-444675040§;
      
      private static const FireArrowTowerAvatar:Class = FireArrowTowerAvatar_png$a5c4b310e8223592c142dc98cd802d991324709721;
      
      private static const FiretrapAvatar:Class = §FiretrapAvatar_png$a035ac6e41f3ed117aa84b3df231d65d-1135933842§;
      
      private static const FlamerTowerAvatar:Class = §FlamerTowerAvatar_png$cbcc8babcc061418f287bb2f4c7f2da3-366556545§;
      
      private static const GatlingArrowTowerAvatar:Class = §GatlingArrowTowerAvatar_png$dc5b57fe21ef8b131010a9c7843652b2-128167947§;
      
      private static const HiringQuartersAvatar:Class = HiringQuartersAvatar_png$d0aec7bd37bcf0e2a99cc0024b269848328983067;
      
      private static const HouseofBrotherhoodAvatar:Class = §HouseofBrotherhoodAvatar_png$442628f3225dd6ef1667112deb34b0c3-327373656§;
      
      private static const IronSmelterAvatar:Class = §IronSmelterAvatar_png$7401389e07bb00229df63f7e8929305d-533160851§;
      
      private static const LumberBladeAvatar:Class = LumberBladeAvatar_png$30dafd01895e1ba261ea214dbd5f84e61983959514;
      
      private static const MercenaryBarracksAvatar:Class = MercenaryBarracksAvatar_png$16f513d2d4335df2767680cc1caf6f47430014884;
      
      private static const PigeonPostAvatar:Class = PigeonPostAvatar_png$8586f6f0f5b348898d853895326a8867258040057;
      
      private static const RecruitmentChamberAvatar:Class = RecruitmentChamberAvatar_png$910c9387b39da313433a7a1fb5235eff1927531245;
      
      private static const SkyTowerAvatar:Class = SkyTowerAvatar_png$dc18f500a5fc37550cda05e69f03145e75014315;
      
      private static const StatueofMightAvatar:Class = §StatueofMightAvatar_png$1eb072f16bda32a29c83bb3324f7f79e-1177798615§;
      
      private static const StockPileAvatar:Class = §StockPileAvatar_png$a0a1680eecbdaf34069717edec930591-980350467§;
      
      private static const StoneGrinderAvatar:Class = StoneGrinderAvatar_png$16a2c37407947ecc6e99358da37e1a05995121879;
      
      private static const TrainingChamberAvatar:Class = §TrainingChamberAvatar_png$141e01b22d68883b408ac8a295ea72e5-406718815§;
      
      private static const TuskHornAvatar:Class = TuskHornAvatar_png$3b5faadb690aff6de6c0799c3efe15e72085173879;
      
      private static const WallAvatar:Class = §WallAvatar_png$05388a1c6aa4d088c52bc0663391cf2b-722257403§;
      
      private static const WatchPostAvatar:Class = WatchPostAvatar_png$f1f801c14e633955ded72252bdf71bc52038828500;
      
      private static const EventBigProgressBarBaseLeft:Class = EventBigProgressBarBaseLeft_png$170b0ba9f0309fd0de772e1106e091271532199133;
      
      private static const EventBigProgressBarLineLeft:Class = EventBigProgressBarLineLeft_png$06d94d6883cd99ba20e7d5c1f5b969a2205150968;
      
      private static const EventItemBackground1Corner:Class = EventItemBackground1Corner_png$ddd0b5e223bb4670f0fe73f8fda47b541053019876;
      
      private static const EventItemBackground2Corner:Class = EventItemBackground2Corner_png$796adbf63b570fcad96bd419eff40bf01240251429;
      
      private static const EventItemBackground3Corner:Class = §EventItemBackground3Corner_png$b1d62786e82f03f25ce9e92498e6def2-729191578§;
      
      private static const EventProgressBarSeperator:Class = EventProgressBarSeperator_png$6ecf55ae5ef5f64f71b4ba913bd63bbb1307847170;
      
      private static const FreeGiftPanelRadioButtonNormal:Class = §FreeGiftPanelRadioButtonNormal_png$75d2e79ac60f9a1ed751a38cd750122a-1404011337§;
      
      private static const FreeGiftPanelRadioButtonSelected:Class = §FreeGiftPanelRadioButtonSelected_png$f070ca61c6ffe0d461f43ea0dc7400e3-1025923805§;
      
      private static const GetGoldPay:Class = GetGoldPay_png$df8a844ff45260ef68e81d6677c50db11744618911;
      
      private static const GetGoldsIcon:Class = §GetGoldsIcon_png$50d0620394b6ad0f3f4400d38c2ef31f-1477377381§;
      
      private static const GetGoldsLogos:Class = GetGoldsLogos_png$b1dbe9aaf3e2264eb23479276200cfeb1404832876;
      
      private static const MobilePaymentIcon:Class = MobilePaymentIcon_png$6a7d6c8e615218688d75803169e705d9600532158;
      
      private static const OtherPaymentIcon:Class = OtherPaymentIcon_png$8b2777acd663b5161b773859c8f6f7a21982494748;
      
      private static const BlueButtonBase:Class = §BlueButtonBase_png$8125ae0dfddff633082f70215fc4fff9-1907855549§;
      
      private static const BlueButtonProgress:Class = BlueButtonProgress_png$c96ffab1535fd56cc42430bc1ca27d211733827495;
      
      private static const InboxFullClose:Class = InboxFullClose_png$3f8334a8a3ceb3f39129be3032f7f8df1899341353;
      
      private static const InviteFriendsAPIVisualSearchIcon:Class = §InviteFriendsAPIVisualSearchIcon_png$b403436824744cf0866e1f759121649f-683874284§;
      
      private static const InviteFriendsAPIVisualSearchLeft:Class = InviteFriendsAPIVisualSearchLeft_png$f7be93c8738a69a97674914a7f31edfc1688575402;
      
      private static const InviteFriendsAPIVisualSearchRight:Class = InviteFriendsAPIVisualSearchRight_png$eac68f17a478b7bad26de822f3080cdc1025355519;
      
      private static const InviteFriendsAPIVisualWhiteBackround:Class = §InviteFriendsAPIVisualWhiteBackround_png$f7d2a0472afc12fe6d2afa02f332510e-1346348999§;
      
      private static const IconLocked:Class = IconLocked_png$fbb309659c11f138d7ae973d12fc0613317962455;
      
      private static const QuestLeftBackground:Class = §QuestLeftBackground_png$69edb7aac90f06c393573d3dae6791bf-1392026220§;
      
      private static const QuestPanelLine:Class = §QuestPanelLine_png$e86006f7e945c4b010a758bad6a47a27-1572594041§;
      
      private static const QuestTooltipBar:Class = §QuestTooltipBar_png$8a9f57a7ea6d5e147828206b8c2687b3-356400993§;
      
      private static const RecruitmentChamber1LockBar:Class = §RecruitmentChamber1LockBar_png$dd592fc4297cb47cf0c9045183a59bff-539370579§;
      
      private static const RecruitmentChamber1LockBarOver:Class = §RecruitmentChamber1LockBarOver_png$784272a977ee4b24dd85c35ae39f31cf-235620455§;
      
      private static const RecruitmentChamber1LockedHover:Class = §RecruitmentChamber1LockedHover_png$3a3ea12c02358220fe0aa976962ef5a9-789013497§;
      
      private static const RecruitmentChamber1LockedNormal:Class = §RecruitmentChamber1LockedNormal_png$ed3a3e704e3e527f6e477bc2b3f6c731-1149115390§;
      
      private static const RecruitmentChamber1LockedSelected:Class = RecruitmentChamber1LockedSelected_png$3ce78b0855d413a96ebdfae6879855c9425592142;
      
      private static const RecruitmentChamber1UnLockedHover:Class = §RecruitmentChamber1UnLockedHover_png$e37a2f6f9d4718ac397712eadbcd5d70-1326644802§;
      
      private static const RecruitmentChamber1UnLockedNormal:Class = §RecruitmentChamber1UnLockedNormal_png$0a950b3e4ab79cc6d2e90b33e3bcbecb-563163701§;
      
      private static const RecruitmentChamber1UnLockedSelected:Class = RecruitmentChamber1UnLockedSelected_png$bf93419b53933f39d392300e838da3141599473591;
      
      private static const RecruitmentChamber1UnLockingHover:Class = RecruitmentChamber1UnLockingHover_png$ceef343a396188765f51f7460366f8c51048329175;
      
      private static const RecruitmentChamber1UnLockingNormal:Class = RecruitmentChamber1UnLockingNormal_png$977a59d5adcdf10c9cded73cbd57e5cb1052675250;
      
      private static const RecruitmentChamber1UnLockingSelected:Class = RecruitmentChamber1UnLockingSelected_png$c141183af2c39836e54e31fffae4e615351009278;
      
      private static const RecruitmentChamberBarracksIcon:Class = RecruitmentChamberBarracksIcon_png$2f12912a954234c792f8d7bf3f0fb3fc550957472;
      
      private static const RecruitmentChamberLockIcon:Class = RecruitmentChamberLockIcon_png$02e090f1267abcebb6bde84886493f751208096514;
      
      private static const RecruitmentChamberLockIconBig:Class = RecruitmentChamberLockIconBig_png$b7a29b39945847916636ded85e69ffcb497650276;
      
      private static const RecruitmentChamberSelected:Class = §RecruitmentChamberSelected_png$aed0eb0875dfae0a690578864deb36ce-944759191§;
      
      private static const RecruitmentChamberTimeIconSmall:Class = RecruitmentChamberTimeIconSmall_png$cc71806b38f0e05f0260cef9a00752dc1805258049;
      
      private static const RecruitmentChambe2ProgressBarInside:Class = RecruitmentChambe2ProgressBarInside_png$ca50231bc0ecac6cae299898a622fb1a878699139;
      
      private static const RecruitmentChamber2ProgressBar:Class = RecruitmentChamber2ProgressBar_png$ea8002713a931ab5911867bd27e264be423700369;
      
      private static const RecruitmentChamberCheckIcon:Class = RecruitmentChamberCheckIcon_png$3024a113b31b4b50c0111708e34f9d6f1206726434;
      
      private static const SendGift:Class = §SendGift_png$b988acf5f46beab8d01a1beffe888293-1569631076§;
      
      private static const StaffCityCenterEmpty:Class = StaffCityCenterEmpty_png$c0e5bf3fc74bfd83862acea83510685b1971034184;
      
      private static const StaffCityCenterWithGold:Class = §StaffCityCenterWithGold_png$c88cb437c7f3e3ab0e28f539e1a77d2e-874739127§;
      
      private static const UpgradeBtnIcon:Class = UpgradeBtnIcon_png$f938018d5f7c6079b10e47951f6f31b4424933116;
      
      private static const IconFreeSpin:Class = IconFreeSpin_png$887a458f6cb235533b735384d03e0a46600409002;
      
      private static const IconGoldPack:Class = IconGoldPack_png$0d2938c35fb04818a7bf56347ded20d71007593341;
      
      private static const IconRPPack:Class = §IconRPPack_png$2dcec812655faf931b2bc2e6530fac4e-155794845§;
      
      private static const TavernIndicator:Class = TavernIndicator_png$a2bbfa56213849acb3ce03e117f807ba605670658;
      
      private static const TavernSelectedSlice:Class = §TavernSelectedSlice_png$62463b84d326ffee0c0926e7c1df4f40-1199628870§;
      
      private static const TavernWheelSlice:Class = TavernWheelSlice_png$069cd4b59d84ebb1b87adb1f48c49c33612757474;
      
      private static const NextBtn:Class = §NextBtn_png$195a85f70aebcb00c69db173cd3cabde-1245196480§;
      
      private static const NextBtnOver:Class = NextBtnOver_png$c6d9abcd87710d7df7a51f12775f8a681726156;
      
      private static const PrevBtn:Class = PrevBtn_png$5919de3ce2afe00387e8c796aeef7bd3355601536;
      
      private static const PrevBtnOver:Class = §PrevBtnOver_png$d5581e020c530d521dec6d12aad2cc8f-1731824116§;
      
      private static const TuskHorn1:Class = §TuskHorn1_png$77527aa79f0d7c8527a9304cc94a6557-856648772§;
      
      private static const TuskHorn1Over:Class = TuskHorn1Over_png$a9ed2c17ab5ed81ffabfa795b712cd37944148264;
      
      private static const TuskHorn2:Class = §TuskHorn2_png$625e174d78ca60413069cbe9082a6867-859641283§;
      
      private static const TuskHorn2Over:Class = TuskHorn2Over_png$ed1a72c435439056e4738578da09681c1132674601;
      
      private static const TuskHorn3:Class = §TuskHorn3_png$b7c338a69c6ea344dc59e7219a4a5ed7-858471746§;
      
      private static const TuskHorn3Over:Class = §TuskHorn3Over_png$a1e7464b8bdfa605f1abf3cfe115c92a-271605462§;
      
      private static const TuskHornCenter:Class = TuskHornCenter_png$216bc461fa5c1d26a9b2d8047498d1082021871584;
      
      private static const BlueSparkle:Class = §BlueSparkle_png$c4fc7a27570c4e0f12a46970c7b06590-144390651§;
      
      private const embeddedassets:Object = {
         "FlagBuildMenuBlank":FlagBuildMenuBlank,
         "FlagBuildMenuEmpty":FlagBuildMenuEmpty,
         "FlagBuildMenuIcon1":FlagBuildMenuIcon1,
         "FlagBuildMenuIcon10":FlagBuildMenuIcon10,
         "FlagBuildMenuIcon11":FlagBuildMenuIcon11,
         "FlagBuildMenuIcon12":FlagBuildMenuIcon12,
         "FlagBuildMenuIcon2":FlagBuildMenuIcon2,
         "FlagBuildMenuIcon3":FlagBuildMenuIcon3,
         "FlagBuildMenuIcon4":FlagBuildMenuIcon4,
         "FlagBuildMenuIcon5":FlagBuildMenuIcon5,
         "FlagBuildMenuIcon6":FlagBuildMenuIcon6,
         "FlagBuildMenuIcon7":FlagBuildMenuIcon7,
         "FlagBuildMenuIcon8":FlagBuildMenuIcon8,
         "FlagBuildMenuIcon9":FlagBuildMenuIcon9,
         "MapPin":MapPin,
         "MapPinPass":MapPinPass,
         "Part14":Part14,
         "Part15":Part15,
         "Part16":Part16,
         "Part17":Part17,
         "Part18":Part18,
         "Part19":Part19,
         "Part20":Part20,
         "Part21":Part21,
         "Part24":Part24,
         "Part25":Part25,
         "Part26":Part26,
         "Part27":Part27,
         "SignBlank":SignBlank,
         "SignEmpty":SignEmpty,
         "SignIcon1":SignIcon1,
         "SignIcon10":SignIcon10,
         "SignIcon11":SignIcon11,
         "SignIcon12":SignIcon12,
         "SignIcon2":SignIcon2,
         "SignIcon3":SignIcon3,
         "SignIcon4":SignIcon4,
         "SignIcon5":SignIcon5,
         "SignIcon6":SignIcon6,
         "SignIcon7":SignIcon7,
         "SignIcon8":SignIcon8,
         "SignIcon9":SignIcon9,
         "FlagBlank":FlagBlank,
         "FlagEmpty":FlagEmpty,
         "FlagIcon1":FlagIcon1,
         "FlagIcon10":FlagIcon10,
         "FlagIcon11":FlagIcon11,
         "FlagIcon12":FlagIcon12,
         "FlagIcon2":FlagIcon2,
         "FlagIcon3":FlagIcon3,
         "FlagIcon4":FlagIcon4,
         "FlagIcon5":FlagIcon5,
         "FlagIcon6":FlagIcon6,
         "FlagIcon7":FlagIcon7,
         "FlagIcon8":FlagIcon8,
         "FlagIcon9":FlagIcon9,
         "GrassTile":GrassTile,
         "ArchersArrow":ArchersArrow,
         "Arrow1":Arrow1,
         "B32CannonBall":B32CannonBall,
         "B33Animation":B33Animation,
         "BloodDrop":BloodDrop,
         "Bloodstain":Bloodstain,
         "GatlingDart":GatlingDart,
         "GroundSwell1":GroundSwell1,
         "GroundSwell2":GroundSwell2,
         "GroundSwell3":GroundSwell3,
         "GroundSwell4":GroundSwell4,
         "HealBall":HealBall,
         "LightRay":LightRay,
         "LightSource":LightSource,
         "Soil1":Soil1,
         "Soil2":Soil2,
         "Soil3":Soil3,
         "Soil4":Soil4,
         "U34Ball":U34Ball,
         "WomkongStone":WomkongStone,
         "AcidRainDrop":AcidRainDrop,
         "AcidRainFoam2":AcidRainFoam2,
         "IceShardCracks":IceShardCracks,
         "IceShardDrop":IceShardDrop,
         "Lumber1":Lumber1,
         "Lumber2":Lumber2,
         "Lumber3":Lumber3,
         "LumberWShadow1":LumberWShadow1,
         "LumberWShadow2":LumberWShadow2,
         "LumberWShadow3":LumberWShadow3,
         "Stone1":Stone1,
         "StoneCrater":StoneCrater,
         "StonePart1":StonePart1,
         "StonePart2":StonePart2,
         "StonePart3":StonePart3,
         "StonePart4":StonePart4,
         "BackgroundQuickAttack":BackgroundQuickAttack,
         "CampaignIcon":CampaignIcon,
         "IconHome":IconHome,
         "IconHomeHover":IconHomeHover,
         "IconList":IconList,
         "IconListHover":IconListHover,
         "IconQuickAttack":IconQuickAttack,
         "IconQuickAttackHover":IconQuickAttackHover,
         "Map1VisualAvatarBackground":Map1VisualAvatarBackground,
         "Map1VisualAvatarBackground1":Map1VisualAvatarBackground1,
         "Map1VisualAvatarBackground2":Map1VisualAvatarBackground2,
         "Map1VisualAvatarBackground3":Map1VisualAvatarBackground3,
         "Map1VisualAvatarBackground4":Map1VisualAvatarBackground4,
         "Map1VisualAvatarBackground6":Map1VisualAvatarBackground6,
         "Part1":Part1,
         "Part10":Part10,
         "Part11":Part11,
         "Part12":Part12,
         "Part13":Part13,
         "Part2":Part2,
         "Part3":Part3,
         "Part4":Part4,
         "Part5":Part5,
         "Part6":Part6,
         "Part7":Part7,
         "Part8":Part8,
         "Part9":Part9,
         "WorldMapIcon":WorldMapIcon,
         "StoreConstructionTabPatlangac":StoreConstructionTabPatlangac,
         "ColorMenuFrameLeft":ColorMenuFrameLeft,
         "DefaultArm":DefaultArm,
         "DefaultToken":DefaultToken,
         "TokenColorA":TokenColorA,
         "TokenColorB":TokenColorB,
         "ArmPattern10A":ArmPattern10A,
         "ArmPattern11A":ArmPattern11A,
         "ArmPattern12A":ArmPattern12A,
         "ArmPattern1A":ArmPattern1A,
         "ArmPattern2A":ArmPattern2A,
         "ArmPattern3A":ArmPattern3A,
         "ArmPattern4A":ArmPattern4A,
         "ArmPattern5A":ArmPattern5A,
         "ArmPattern6A":ArmPattern6A,
         "ArmPattern7A":ArmPattern7A,
         "ArmPattern8A":ArmPattern8A,
         "ArmPattern9A":ArmPattern9A,
         "ArmPatternBase":ArmPatternBase,
         "PatternSymbol1":PatternSymbol1,
         "PatternSymbol10":PatternSymbol10,
         "PatternSymbol11":PatternSymbol11,
         "PatternSymbol12":PatternSymbol12,
         "PatternSymbol2":PatternSymbol2,
         "PatternSymbol3":PatternSymbol3,
         "PatternSymbol4":PatternSymbol4,
         "PatternSymbol5":PatternSymbol5,
         "PatternSymbol6":PatternSymbol6,
         "PatternSymbol7":PatternSymbol7,
         "PatternSymbol8":PatternSymbol8,
         "PatternSymbol9":PatternSymbol9,
         "CloseMainNormal":CloseMainNormal,
         "CloseMainOver":CloseMainOver,
         "HiringQuartersCancel":HiringQuartersCancel,
         "HiringQuartersCancel2":HiringQuartersCancel2,
         "ArrowCursor":ArrowCursor,
         "ClearOutCursor":ClearOutCursor,
         "DragCursor":DragCursor,
         "EnterBuildingCursor":EnterBuildingCursor,
         "FortifyCursor":FortifyCursor,
         "HandCursor":HandCursor,
         "HarvestAllCursor":HarvestAllCursor,
         "HarvestCursor":HarvestCursor,
         "HarvestGoldCursor":HarvestGoldCursor,
         "MoveCursor":MoveCursor,
         "RecycleCursor":RecycleCursor,
         "RemainingHelp1Cursor":RemainingHelp1Cursor,
         "RemainingHelp2Cursor":RemainingHelp2Cursor,
         "RemainingHelp3Cursor":RemainingHelp3Cursor,
         "RemainingHelp4Cursor":RemainingHelp4Cursor,
         "RemainingHelp5Cursor":RemainingHelp5Cursor,
         "SpeedUpCursor":SpeedUpCursor,
         "UpgradeCursor":UpgradeCursor,
         "BPAnimationLight":BPAnimationLight,
         "LightAnimationGraphic":LightAnimationGraphic,
         "LightAnimationGraphicNew":LightAnimationGraphicNew,
         "Patlangac":Patlangac,
         "ShinyBackgroundLarge":ShinyBackgroundLarge,
         "ShinyBackgroundLargeOver":ShinyBackgroundLargeOver,
         "ShinyBackgroundSmall":ShinyBackgroundSmall,
         "ShinyBackgroundSmallOver":ShinyBackgroundSmallOver,
         "BackgroundBoxDark":BackgroundBoxDark,
         "BackgroundBoxGreen":BackgroundBoxGreen,
         "BackgroundBoxLight":BackgroundBoxLight,
         "Check":Check,
         "FacebookFallbackPicture":FacebookFallbackPicture,
         "MainFrame":MainFrame,
         "NumberBackground":NumberBackground,
         "Or":Or,
         "SpeechBubble":SpeechBubble,
         "ProgressBar15":ProgressBar15,
         "ProgressBar15Inside":ProgressBar15Inside,
         "ProgressBar19":ProgressBar19,
         "ProgressBar19Inside":ProgressBar19Inside,
         "ProgressBar26":ProgressBar26,
         "ProgressBar26Inside":ProgressBar26Inside,
         "ProgressBar30":ProgressBar30,
         "ProgressBar30Inside":ProgressBar30Inside,
         "ProgressBar36":ProgressBar36,
         "ProgressBar36Inside":ProgressBar36Inside,
         "ProgressBar65":ProgressBar65,
         "ProgressBar65Inside":ProgressBar65Inside,
         "TabBoxCorner":TabBoxCorner,
         "TabBoxCorner1":TabBoxCorner1,
         "TabBoxSide":TabBoxSide,
         "TabBoxSide1":TabBoxSide1,
         "TabButton":TabButton,
         "TabButtonHover":TabButtonHover,
         "ArrowStep":ArrowStep,
         "HiringQuarterArrow":HiringQuarterArrow,
         "SlideArrow":SlideArrow,
         "SlideArrowOver":SlideArrowOver,
         "GreenSquareButton":GreenSquareButton,
         "GreenSquareButtonBigHover":GreenSquareButtonBigHover,
         "GreenSquareButtonHover":GreenSquareButtonHover,
         "RedSquareButton":RedSquareButton,
         "YellowSquareButton":YellowSquareButton,
         "BlueButtonLarge":BlueButtonLarge,
         "BlueButtonLargeOver":BlueButtonLargeOver,
         "BlueButtonLargeSelected":BlueButtonLargeSelected,
         "BrownButtonLarge":BrownButtonLarge,
         "BrownButtonLargeOver":BrownButtonLargeOver,
         "BrownButtonLargeSelected":BrownButtonLargeSelected,
         "GreenButtonLarge":GreenButtonLarge,
         "GreenButtonLargeOver":GreenButtonLargeOver,
         "GreenButtonLargeSelected":GreenButtonLargeSelected,
         "OrangeButtonLarge":OrangeButtonLarge,
         "OrangeButtonLargeOver":OrangeButtonLargeOver,
         "OrangeButtonLargeSelected":OrangeButtonLargeSelected,
         "RedButtonLarge":RedButtonLarge,
         "RedButtonLargeOver":RedButtonLargeOver,
         "RedButtonLargeSelected":RedButtonLargeSelected,
         "BlueButtonMedium":BlueButtonMedium,
         "BlueButtonMediumOver":BlueButtonMediumOver,
         "BlueButtonMediumSelected":BlueButtonMediumSelected,
         "BrownButtonMedium":BrownButtonMedium,
         "BrownButtonMediumOver":BrownButtonMediumOver,
         "BrownButtonMediumSelected":BrownButtonMediumSelected,
         "GreenButtonMedium":GreenButtonMedium,
         "GreenButtonMediumOver":GreenButtonMediumOver,
         "GreenButtonMediumSelected":GreenButtonMediumSelected,
         "OrangeButtonMedium":OrangeButtonMedium,
         "OrangeButtonMediumOver":OrangeButtonMediumOver,
         "OrangeButtonMediumSelected":OrangeButtonMediumSelected,
         "RedButtonMedium":RedButtonMedium,
         "RedButtonMediumOver":RedButtonMediumOver,
         "RedButtonMediumSelected":RedButtonMediumSelected,
         "BlueButtonMini":BlueButtonMini,
         "BlueButtonMiniOver":BlueButtonMiniOver,
         "BlueButtonMiniPressed":BlueButtonMiniPressed,
         "BlueButtonMiniSelected":BlueButtonMiniSelected,
         "BrownButtonMini":BrownButtonMini,
         "BrownButtonMiniOver":BrownButtonMiniOver,
         "BrownButtonMiniSelected":BrownButtonMiniSelected,
         "GreenButtonMini":GreenButtonMini,
         "GreenButtonMiniOver":GreenButtonMiniOver,
         "GreenButtonMiniSelected":GreenButtonMiniSelected,
         "OrangeButtonMini":OrangeButtonMini,
         "OrangeButtonMiniOver":OrangeButtonMiniOver,
         "OrangeButtonMiniSelected":OrangeButtonMiniSelected,
         "RedButtonMini":RedButtonMini,
         "RedButtonMiniOver":RedButtonMiniOver,
         "RedButtonMiniSelected":RedButtonMiniSelected,
         "BlueButtonSmall":BlueButtonSmall,
         "BlueButtonSmallOver":BlueButtonSmallOver,
         "BlueButtonSmallSelected":BlueButtonSmallSelected,
         "BrownButtonSmall":BrownButtonSmall,
         "BrownButtonSmallOver":BrownButtonSmallOver,
         "BrownButtonSmallSelected":BrownButtonSmallSelected,
         "BrownButtonSmallSelectedOld":BrownButtonSmallSelectedOld,
         "GreenButtonSmall":GreenButtonSmall,
         "GreenButtonSmallOver":GreenButtonSmallOver,
         "GreenButtonSmallSelected":GreenButtonSmallSelected,
         "OrangeButtonSmall":OrangeButtonSmall,
         "OrangeButtonSmallOver":OrangeButtonSmallOver,
         "OrangeButtonSmallSelected":OrangeButtonSmallSelected,
         "RedButtonSmall":RedButtonSmall,
         "RedButtonSmallOver":RedButtonSmallOver,
         "RedButtonSmallSelected":RedButtonSmallSelected,
         "Combobox":Combobox,
         "ChatGreenBaloonBackground":ChatGreenBaloonBackground,
         "ChatYellowBaloonBackground":ChatYellowBaloonBackground,
         "Minus":Minus,
         "MinusOver":MinusOver,
         "Plus":Plus,
         "PlusOver":PlusOver,
         "MainQuestPreviewComplete":MainQuestPreviewComplete,
         "MainQuestPreviewYellow":MainQuestPreviewYellow,
         "QuestHintNormal":QuestHintNormal,
         "QuestHintOver":QuestHintOver,
         "CheckBox":CheckBox,
         "CheckBoxSelected":CheckBoxSelected,
         "RadioBtn":RadioBtn,
         "RadioBtnSelected":RadioBtnSelected,
         "RadioButton":RadioButton,
         "RadioButtonSelected":RadioButtonSelected,
         "Tick":Tick,
         "ScrollInside":ScrollInside,
         "ScrollSkeleton":ScrollSkeleton,
         "ScrollSkeletonBottom":ScrollSkeletonBottom,
         "ScrollSkeletonTop":ScrollSkeletonTop,
         "IconOffline":IconOffline,
         "IconOnline":IconOnline,
         "ChatInput":ChatInput,
         "TextArea":TextArea,
         "AllianceBoostIconArmor":AllianceBoostIconArmor,
         "AllianceBoostIconBarrackSpace":AllianceBoostIconBarrackSpace,
         "AllianceBoostIconDamage":AllianceBoostIconDamage,
         "AllianceBoostIconTower":AllianceBoostIconTower,
         "IconRank1":IconRank1,
         "IconRank2":IconRank2,
         "IconRank3":IconRank3,
         "CeltMap":CeltMap,
         "PlagueMap":PlagueMap,
         "GuestAvatar1":GuestAvatar1,
         "GuestAvatar2":GuestAvatar2,
         "GuestAvatar3":GuestAvatar3,
         "GuestAvatar4":GuestAvatar4,
         "GuestAvatar5":GuestAvatar5,
         "GuestAvatar6":GuestAvatar6,
         "DemonKingMap":DemonKingMap,
         "IronHandMap":IronHandMap,
         "RagingBullMap":RagingBullMap,
         "ShriekingDragonMap":ShriekingDragonMap,
         "GermanicHunterAvatar":GermanicHunterAvatar,
         "TutorialDefenderIcon":TutorialDefenderIcon,
         "AllianceEventIcon":AllianceEventIcon,
         "BPEventIcon":BPEventIcon,
         "EventCanvasStoreIcon":EventCanvasStoreIcon,
         "EventCeltIcon1":EventCeltIcon1,
         "EventCeltIcon2":EventCeltIcon2,
         "EventIcon1":EventIcon1,
         "EventIcon2":EventIcon2,
         "EventPointIcon":EventPointIcon,
         "IronEventIcon":IronEventIcon,
         "Cross":Cross,
         "FortifyIconBig":FortifyIconBig,
         "FullscreenIcon":FullscreenIcon,
         "Gold27":Gold27,
         "GridIcon":GridIcon,
         "IconCancel":IconCancel,
         "IconCancel2":IconCancel2,
         "IconGoldMini":IconGoldMini,
         "IconLockBig":IconLockBig,
         "IconRefresh":IconRefresh,
         "IconSearch":IconSearch,
         "LeaderBoardBordered":LeaderBoardBordered,
         "LeaderBoardBronze":LeaderBoardBronze,
         "LeaderBoardSilver":LeaderBoardSilver,
         "LoadingIcon":LoadingIcon,
         "Lock":Lock,
         "MercenaryLevel41Px":MercenaryLevel41Px,
         "TakePhotoIcon":TakePhotoIcon,
         "Upgrade":Upgrade,
         "GoldDouble":GoldDouble,
         "GoldFortune":GoldFortune,
         "HelpHarvest":HelpHarvest,
         "HelpMercenaries":HelpMercenaries,
         "HelpTime":HelpTime,
         "IconMarksmanship":IconMarksmanship,
         "IconRangedDarts":IconRangedDarts,
         "CatapultLumber32":CatapultLumber32,
         "CatapultLumber45":CatapultLumber45,
         "CatapultMight32":CatapultMight32,
         "CatapultMight45":CatapultMight45,
         "CatapultStone32":CatapultStone32,
         "CatapultStone45":CatapultStone45,
         "Clock45":Clock45,
         "IconLootGainedBig":IconLootGainedBig,
         "Iron45":Iron45,
         "Lumber45":Lumber45,
         "Might45":Might45,
         "RP41":RP41,
         "Stone45":Stone45,
         "CollectedGold":CollectedGold,
         "CollectedIron":CollectedIron,
         "CollectedLumber":CollectedLumber,
         "CollectedMight":CollectedMight,
         "CollectedPart":CollectedPart,
         "CollectedResource":CollectedResource,
         "CollectedRp":CollectedRp,
         "CollectedStone":CollectedStone,
         "TournamentRewardIcon1":TournamentRewardIcon1,
         "TournamentRewardIcon2":TournamentRewardIcon2,
         "TournamentRewardIcon3":TournamentRewardIcon3,
         "LikeBtn":LikeBtn,
         "CityLoadingHourglass":CityLoadingHourglass,
         "CityLoadingMap":CityLoadingMap,
         "ChatArrowUp":ChatArrowUp,
         "ChatArrowUpOver":ChatArrowUpOver,
         "ChatBackgroundTopCorner":ChatBackgroundTopCorner,
         "ChatIcon":ChatIcon,
         "ChatTabButtonSelectedSide":ChatTabButtonSelectedSide,
         "ChatTabButtonSide":ChatTabButtonSide,
         "AddFriendPlus":AddFriendPlus,
         "AttackscomeinBar":AttackscomeinBar,
         "AvatarBackground":AvatarBackground,
         "AvatarBackgroundHover":AvatarBackgroundHover,
         "AvatarBackgroundSelected":AvatarBackgroundSelected,
         "Back":Back,
         "BackHover":BackHover,
         "BlueMinusIcon":BlueMinusIcon,
         "BluePlusIcon":BluePlusIcon,
         "BuildDeselectIcon":BuildDeselectIcon,
         "BuildIcon":BuildIcon,
         "BuildIconHover":BuildIconHover,
         "BuildingProgress":BuildingProgress,
         "BuildingProgressBar":BuildingProgressBar,
         "ButtonWarDisable":ButtonWarDisable,
         "ButtonWarNormal":ButtonWarNormal,
         "ButtonWarPaid":ButtonWarPaid,
         "CityLoadingCardBackground":CityLoadingCardBackground,
         "CombatResourceIcon":CombatResourceIcon,
         "CrownIcon":CrownIcon,
         "DeselectIcon":DeselectIcon,
         "ELOEmpty":ELOEmpty,
         "ELONegative":ELONegative,
         "ELOPositive":ELOPositive,
         "EngageBtn":EngageBtn,
         "EngageBtnOver":EngageBtnOver,
         "ExperienceBar":ExperienceBar,
         "ExperienceProgressBar":ExperienceProgressBar,
         "ExperienceStar":ExperienceStar,
         "First":First,
         "FirstHover":FirstHover,
         "FortifyDeselectIcon":FortifyDeselectIcon,
         "FortifyIcon":FortifyIcon,
         "FortifyIconHover":FortifyIconHover,
         "FreeCoins":FreeCoins,
         "FreeCoinsHover":FreeCoinsHover,
         "FullScreen":FullScreen,
         "FullScreenHover":FullScreenHover,
         "GetWomkong":GetWomkong,
         "GetWomkongHover":GetWomkongHover,
         "Gold":Gold,
         "GoldBackgroundSide":GoldBackgroundSide,
         "GreenPlusIcon":GreenPlusIcon,
         "GreenPlusIconBig":GreenPlusIconBig,
         "IconVideo":IconVideo,
         "IconVideoHover":IconVideoHover,
         "Iron":Iron,
         "IronProgressBar":IronProgressBar,
         "Lumber":Lumber,
         "LumberProgressBar":LumberProgressBar,
         "MainframeStashNewGift":MainframeStashNewGift,
         "MenuBarRight":MenuBarRight,
         "MenuBarRightShadow":MenuBarRightShadow,
         "Might":Might,
         "MightProgressBar":MightProgressBar,
         "MoveDeselectIcon":MoveDeselectIcon,
         "MoveIcon":MoveIcon,
         "MoveIconHover":MoveIconHover,
         "MusicOff":MusicOff,
         "MusicOn":MusicOn,
         "NotificationCircleIcon":NotificationCircleIcon,
         "PanelBottomSide":PanelBottomSide,
         "PanelTopLine":PanelTopLine,
         "PanelTopSide":PanelTopSide,
         "ProgressBar5":ProgressBar5,
         "ProgressBarFull":ProgressBarFull,
         "ProgressBarLine10":ProgressBarLine10,
         "QuestTooltipYellow":QuestTooltipYellow,
         "RecruitProgress":RecruitProgress,
         "RedAttentionIcon":RedAttentionIcon,
         "ReinforceButtonProgressBar":ReinforceButtonProgressBar,
         "ResourceBar":ResourceBar,
         "Rp":Rp,
         "SelectIcon":SelectIcon,
         "SelectIconHover":SelectIconHover,
         "SelectTooltipIcon":SelectTooltipIcon,
         "SelectTooltipIconHover":SelectTooltipIconHover,
         "SellDeselectIcon":SellDeselectIcon,
         "SellIcon":SellIcon,
         "SellIconHover":SellIconHover,
         "Settings":Settings,
         "SettingsBackgroundCorner":SettingsBackgroundCorner,
         "SettingsHover":SettingsHover,
         "ShopIcon":ShopIcon,
         "ShopIcon50Discount":ShopIcon50Discount,
         "ShopIcon50DiscountHover":ShopIcon50DiscountHover,
         "ShopIconHover":ShopIconHover,
         "SoundOff":SoundOff,
         "SoundOn":SoundOn,
         "SpecialOfferIcon":SpecialOfferIcon,
         "SpecialOfferIconHover":SpecialOfferIconHover,
         "SplashOff":SplashOff,
         "SplashOn":SplashOn,
         "SpyHoverIcon":SpyHoverIcon,
         "SpyIcon":SpyIcon,
         "StashIcon":StashIcon,
         "StashIconHover":StashIconHover,
         "Stone":Stone,
         "StoneProgressBar":StoneProgressBar,
         "UnderProtectionBackgroundSide":UnderProtectionBackgroundSide,
         "UpgradeIcon":UpgradeIcon,
         "UpgradeIconHover":UpgradeIconHover,
         "UpgradeIconHoverOver2":UpgradeIconHoverOver2,
         "WarIcon":WarIcon,
         "WarIconDisabled":WarIconDisabled,
         "WarIconHover":WarIconHover,
         "WhiteFlag":WhiteFlag,
         "WorkerBarSide":WorkerBarSide,
         "ZoomIn":ZoomIn,
         "ZoomInHover":ZoomInHover,
         "ButtonEndAttack":ButtonEndAttack,
         "IconGreenPlus":IconGreenPlus,
         "LumberSalvo":LumberSalvo,
         "LumberSalvoLarge":LumberSalvoLarge,
         "LumberSalvoMedium":LumberSalvoMedium,
         "LumberSalvoSmall":LumberSalvoSmall,
         "LumberSalvoXlarge":LumberSalvoXlarge,
         "MightyBoost":MightyBoost,
         "MightyBoostLarge":MightyBoostLarge,
         "MightyBoostMedium":MightyBoostMedium,
         "MightyBoostSmall":MightyBoostSmall,
         "MightyBoostXlarge":MightyBoostXlarge,
         "StoneBomb":StoneBomb,
         "StoneBombLarge":StoneBombLarge,
         "StoneBombMedium":StoneBombMedium,
         "StoneBombSmall":StoneBombSmall,
         "StoneBombXlarge":StoneBombXlarge,
         "TimerBackgroundSide":TimerBackgroundSide,
         "TimerNumberBackground":TimerNumberBackground,
         "VictoryMeterBase":VictoryMeterBase,
         "VictoryMeterBlack":VictoryMeterBlack,
         "VictoryMeterGreen":VictoryMeterGreen,
         "VictoryMeterIndicator":VictoryMeterIndicator,
         "VictoryMeterIndicatorRed":VictoryMeterIndicatorRed,
         "VictoryMeterIndicatorWhite":VictoryMeterIndicatorWhite,
         "VictoryMeterRed":VictoryMeterRed,
         "VictoryMeterYellowBackgroundCorner":VictoryMeterYellowBackgroundCorner,
         "DefenceViewBar":DefenceViewBar,
         "DefenceViewLine":DefenceViewLine,
         "HelpRPOff":HelpRPOff,
         "HelpRPOn":HelpRPOn,
         "HelpScreenHomeIcon":HelpScreenHomeIcon,
         "HelpScreenHomeIconHover":HelpScreenHomeIconHover,
         "BombsTooltipIcon":BombsTooltipIcon,
         "MercTooltipHead":MercTooltipHead,
         "ResourceBasketTooltip":ResourceBasketTooltip,
         "SwordTooltipIcon":SwordTooltipIcon,
         "TooltipsBackground":TooltipsBackground,
         "TooltipsBottomPin":TooltipsBottomPin,
         "TooltipsInner":TooltipsInner,
         "TooltipsLeftPin":TooltipsLeftPin,
         "TooltipsRightPin":TooltipsRightPin,
         "TooltipsTopPin":TooltipsTopPin,
         "Map1ListOffline":Map1ListOffline,
         "Map1ListOnline":Map1ListOnline,
         "Map1NCLIcon":Map1NCLIcon,
         "MapFilterArrowDown":MapFilterArrowDown,
         "MapFilterArrowUp":MapFilterArrowUp,
         "MapFilterDropdown":MapFilterDropdown,
         "MapFilterNoArrow":MapFilterNoArrow,
         "MapOffline":MapOffline,
         "MapOnline":MapOnline,
         "Level":Level,
         "ListIcon":ListIcon,
         "LowLevel":LowLevel,
         "Map1ResourceBarIcon":Map1ResourceBarIcon,
         "Map1VisualMenu2":Map1VisualMenu2,
         "Map1VisualMenu3":Map1VisualMenu3,
         "Map1VisualMenu4":Map1VisualMenu4,
         "TruceActive":TruceActive,
         "TruceNone":TruceNone,
         "UnderProtectionActive":UnderProtectionActive,
         "UnderProtectionNone":UnderProtectionNone,
         "LoadingBackground":LoadingBackground,
         "LoadingProgressLight":LoadingProgressLight,
         "LoadingProgressShadow":LoadingProgressShadow,
         "LoadingProgressTrack":LoadingProgressTrack,
         "PeakGamesLogo":PeakGamesLogo,
         "TutorialArrowBottom":TutorialArrowBottom,
         "TutorialArrowLeft":TutorialArrowLeft,
         "TutorialArrowRight":TutorialArrowRight,
         "TutorialArrowTop":TutorialArrowTop,
         "TutorialBack":TutorialBack,
         "TutorialPose1":TutorialPose1,
         "TutorialPose2":TutorialPose2,
         "TutorialPose3":TutorialPose3,
         "TutorialPose6":TutorialPose6,
         "TutorialPose7":TutorialPose7,
         "TutorialPose8":TutorialPose8,
         "ScoreBack":ScoreBack,
         "BeastCaveEvolution2Green":BeastCaveEvolution2Green,
         "BeastCaveEvolutionBigNormal":BeastCaveEvolutionBigNormal,
         "BeastCaveEvolutionBigSelected":BeastCaveEvolutionBigSelected,
         "BeastCaveEvolutionLoadOver":BeastCaveEvolutionLoadOver,
         "BeastCaveEvolutionNormal":BeastCaveEvolutionNormal,
         "BeastCaveEvolutionSmallNormal":BeastCaveEvolutionSmallNormal,
         "BeastCaveEvolutionSmallSelected":BeastCaveEvolutionSmallSelected,
         "BeastKeeperCageChain":BeastKeeperCageChain,
         "CantBuildIcon":CantBuildIcon,
         "CantBuildTooltip":CantBuildTooltip,
         "CentralHiringBigProgressBar":CentralHiringBigProgressBar,
         "CentralHiringBigProgressBarInside":CentralHiringBigProgressBarInside,
         "CentralHiringLine":CentralHiringLine,
         "CentralHiringNumber":CentralHiringNumber,
         "HiringQuartersClick":HiringQuartersClick,
         "HiringQuartersHover":HiringQuartersHover,
         "CenterCrossIcon":CenterCrossIcon,
         "CityPlannerBuildingNameBackgroundSide":CityPlannerBuildingNameBackgroundSide,
         "CityPlannerFullScreen":CityPlannerFullScreen,
         "CityPlannerFullScreenOver":CityPlannerFullScreenOver,
         "CityPlannerLevelBg":CityPlannerLevelBg,
         "CityPlannerZoomBar":CityPlannerZoomBar,
         "CityPlannerZoomBarCursor":CityPlannerZoomBarCursor,
         "CityPlannerZoomIn":CityPlannerZoomIn,
         "CityPlannerZoomInOver":CityPlannerZoomInOver,
         "CityPlannerZoomOut":CityPlannerZoomOut,
         "CityPlannerZoomOutOver":CityPlannerZoomOutOver,
         "AllyWatchPostAvatar":AllyWatchPostAvatar,
         "AncientTelescopeAvatar":AncientTelescopeAvatar,
         "ArchersTowerAvatar":ArchersTowerAvatar,
         "ArenaAvatar":ArenaAvatar,
         "AssemblyAreaAvatar":AssemblyAreaAvatar,
         "BeastCannonTowerAvatar":BeastCannonTowerAvatar,
         "BeastCaveAvatar":BeastCaveAvatar,
         "BeastKeeperAvatar":BeastKeeperAvatar,
         "BlacksmithAvatar":BlacksmithAvatar,
         "BombardTowerAvatar":BombardTowerAvatar,
         "BuriedSpikesAvatar":BuriedSpikesAvatar,
         "BurningMirrorsAvatar":BurningMirrorsAvatar,
         "CatapultAvatar":CatapultAvatar,
         "CentralHiringAvatar":CentralHiringAvatar,
         "CityBazaarAvatar":CityBazaarAvatar,
         "CityCenterAvatar":CityCenterAvatar,
         "CityPlannerAvatar":CityPlannerAvatar,
         "ConsularPostAvatar":ConsularPostAvatar,
         "DecorationAvatar":DecorationAvatar,
         "ExecutionalGuillotineAvatar":ExecutionalGuillotineAvatar,
         "FireArrowTowerAvatar":FireArrowTowerAvatar,
         "FiretrapAvatar":FiretrapAvatar,
         "FlamerTowerAvatar":FlamerTowerAvatar,
         "GatlingArrowTowerAvatar":GatlingArrowTowerAvatar,
         "HiringQuartersAvatar":HiringQuartersAvatar,
         "HouseofBrotherhoodAvatar":HouseofBrotherhoodAvatar,
         "IronSmelterAvatar":IronSmelterAvatar,
         "LumberBladeAvatar":LumberBladeAvatar,
         "MercenaryBarracksAvatar":MercenaryBarracksAvatar,
         "PigeonPostAvatar":PigeonPostAvatar,
         "RecruitmentChamberAvatar":RecruitmentChamberAvatar,
         "SkyTowerAvatar":SkyTowerAvatar,
         "StatueofMightAvatar":StatueofMightAvatar,
         "StockPileAvatar":StockPileAvatar,
         "StoneGrinderAvatar":StoneGrinderAvatar,
         "TrainingChamberAvatar":TrainingChamberAvatar,
         "TuskHornAvatar":TuskHornAvatar,
         "WallAvatar":WallAvatar,
         "WatchPostAvatar":WatchPostAvatar,
         "EventBigProgressBarBaseLeft":EventBigProgressBarBaseLeft,
         "EventBigProgressBarLineLeft":EventBigProgressBarLineLeft,
         "EventItemBackground1Corner":EventItemBackground1Corner,
         "EventItemBackground2Corner":EventItemBackground2Corner,
         "EventItemBackground3Corner":EventItemBackground3Corner,
         "EventProgressBarSeperator":EventProgressBarSeperator,
         "FreeGiftPanelRadioButtonNormal":FreeGiftPanelRadioButtonNormal,
         "FreeGiftPanelRadioButtonSelected":FreeGiftPanelRadioButtonSelected,
         "GetGoldPay":GetGoldPay,
         "GetGoldsIcon":GetGoldsIcon,
         "GetGoldsLogos":GetGoldsLogos,
         "MobilePaymentIcon":MobilePaymentIcon,
         "OtherPaymentIcon":OtherPaymentIcon,
         "BlueButtonBase":BlueButtonBase,
         "BlueButtonProgress":BlueButtonProgress,
         "InboxFullClose":InboxFullClose,
         "InviteFriendsAPIVisualSearchIcon":InviteFriendsAPIVisualSearchIcon,
         "InviteFriendsAPIVisualSearchLeft":InviteFriendsAPIVisualSearchLeft,
         "InviteFriendsAPIVisualSearchRight":InviteFriendsAPIVisualSearchRight,
         "InviteFriendsAPIVisualWhiteBackround":InviteFriendsAPIVisualWhiteBackround,
         "IconLocked":IconLocked,
         "QuestLeftBackground":QuestLeftBackground,
         "QuestPanelLine":QuestPanelLine,
         "QuestTooltipBar":QuestTooltipBar,
         "RecruitmentChamber1LockBar":RecruitmentChamber1LockBar,
         "RecruitmentChamber1LockBarOver":RecruitmentChamber1LockBarOver,
         "RecruitmentChamber1LockedHover":RecruitmentChamber1LockedHover,
         "RecruitmentChamber1LockedNormal":RecruitmentChamber1LockedNormal,
         "RecruitmentChamber1LockedSelected":RecruitmentChamber1LockedSelected,
         "RecruitmentChamber1UnLockedHover":RecruitmentChamber1UnLockedHover,
         "RecruitmentChamber1UnLockedNormal":RecruitmentChamber1UnLockedNormal,
         "RecruitmentChamber1UnLockedSelected":RecruitmentChamber1UnLockedSelected,
         "RecruitmentChamber1UnLockingHover":RecruitmentChamber1UnLockingHover,
         "RecruitmentChamber1UnLockingNormal":RecruitmentChamber1UnLockingNormal,
         "RecruitmentChamber1UnLockingSelected":RecruitmentChamber1UnLockingSelected,
         "RecruitmentChamberBarracksIcon":RecruitmentChamberBarracksIcon,
         "RecruitmentChamberLockIcon":RecruitmentChamberLockIcon,
         "RecruitmentChamberLockIconBig":RecruitmentChamberLockIconBig,
         "RecruitmentChamberSelected":RecruitmentChamberSelected,
         "RecruitmentChamberTimeIconSmall":RecruitmentChamberTimeIconSmall,
         "RecruitmentChambe2ProgressBarInside":RecruitmentChambe2ProgressBarInside,
         "RecruitmentChamber2ProgressBar":RecruitmentChamber2ProgressBar,
         "RecruitmentChamberCheckIcon":RecruitmentChamberCheckIcon,
         "SendGift":SendGift,
         "StaffCityCenterEmpty":StaffCityCenterEmpty,
         "StaffCityCenterWithGold":StaffCityCenterWithGold,
         "UpgradeBtnIcon":UpgradeBtnIcon,
         "IconFreeSpin":IconFreeSpin,
         "IconGoldPack":IconGoldPack,
         "IconRPPack":IconRPPack,
         "TavernIndicator":TavernIndicator,
         "TavernSelectedSlice":TavernSelectedSlice,
         "TavernWheelSlice":TavernWheelSlice,
         "NextBtn":NextBtn,
         "NextBtnOver":NextBtnOver,
         "PrevBtn":PrevBtn,
         "PrevBtnOver":PrevBtnOver,
         "TuskHorn1":TuskHorn1,
         "TuskHorn1Over":TuskHorn1Over,
         "TuskHorn2":TuskHorn2,
         "TuskHorn2Over":TuskHorn2Over,
         "TuskHorn3":TuskHorn3,
         "TuskHorn3Over":TuskHorn3Over,
         "TuskHornCenter":TuskHornCenter,
         "BlueSparkle":BlueSparkle
      };
      
      private const remoteassets:Object = {
         "AbandonedWagonBuildMenu":["139921",100,75],
         "AxeAndBlockBuildMenu":["123992",36,60],
         "BarrelBuildMenu":["114044",40,61],
         "BeehiveBuildMenu":["118279",52,75],
         "BirdhouseBuildMenu":["126044",34,78],
         "BlueFlowersBuildMenu":["164407",42,47],
         "CoffinBuildMenu":["158285",90,66],
         "DeadCrowBuildMenu":["159137",67,74],
         "FarmersForkBuildMenu":["125778",60,94],
         "FirepitBuildMenu":["131135",57,54],
         "HaybaleBuildMenu":["164838",72,61],
         "LambBuildMenu":["111506",101,81],
         "LanternBuildMenu":["156502",47,120],
         "Letter0BuildMenu":["120402",53,86],
         "Letter1BuildMenu":["124763",53,86],
         "Letter2BuildMenu":["150054",53,86],
         "Letter3BuildMenu":["112251",53,86],
         "Letter4BuildMenu":["138391",53,86],
         "Letter5BuildMenu":["19296",53,86],
         "Letter6BuildMenu":["14868",53,86],
         "Letter7BuildMenu":["137219",53,86],
         "Letter8BuildMenu":["18029",53,86],
         "Letter9BuildMenu":["147686",53,86],
         "LetterABuildMenu":["152555",53,91],
         "LetterBBuildMenu":["151413",53,91],
         "LetterCBuildMenu":["19361",53,91],
         "LetterCSBuildMenu":["115518",53,91],
         "LetterDBuildMenu":["15704",53,91],
         "LetterEBuildMenu":["155903",53,91],
         "LetterFBuildMenu":["113289",53,91],
         "LetterGBuildMenu":["160107",53,91],
         "LetterGSBuildMenu":["17569",53,91],
         "LetterHBuildMenu":["128888",53,91],
         "LetterIBuildMenu":["164086",53,91],
         "LetterISBuildMenu":["132489",53,91],
         "LetterJBuildMenu":["141207",53,91],
         "LetterKBuildMenu":["121098",53,91],
         "LetterLBuildMenu":["19833",53,91],
         "LetterMBuildMenu":["134387",53,91],
         "LetterNBuildMenu":["133061",53,91],
         "LetterOBuildMenu":["156536",53,91],
         "LetterOSBuildMenu":["131605",53,91],
         "LetterPBuildMenu":["112784",53,91],
         "LetterQBuildMenu":["125442",53,91],
         "LetterRBuildMenu":["130423",53,91],
         "LetterSBuildMenu":["151100",53,91],
         "LetterSSBuildMenu":["137856",53,91],
         "LetterTBuildMenu":["14457",53,91],
         "LetterUBuildMenu":["124332",53,91],
         "LetterUSBuildMenu":["160412",53,91],
         "LetterVBuildMenu":["122746",53,91],
         "LetterWBuildMenu":["157604",53,91],
         "LetterXBuildMenu":["154910",53,91],
         "LetterYBuildMenu":["150618",53,91],
         "LetterZBuildMenu":["18647",53,91],
         "PumpkinBuildMenu":["1114",55,45],
         "RamadanCannonBuildMenu":["15260",75,68],
         "RamadanDrumBuildMenu":["161658",65,66],
         "RedFlowersBuildMenu":["146265",60,42],
         "ScarecrowBuildMenu":["136009",74,92],
         "ThornsBuildMenu":["19680",59,76],
         "TombstoneBuildMenu":["15572",44,71],
         "TournamentReward1BuildMenu":["159500",62,94],
         "TournamentReward2BuildMenu":["1641",67,93],
         "TournamentReward3BuildMenu":["136001",65,83],
         "WoodenCartBuildMenu":["134187",68,57],
         "WoodpileBuildMenu":["125691",70,68],
         "FlagARGBuildMenu":["14413",62,108],
         "FlagAUSBuildMenu":["149903",62,108],
         "FlagAlgeriaBuildMenu":["124760",62,108],
         "FlagBELBuildMenu":["111794",62,108],
         "FlagBRABuildMenu":["151588",62,108],
         "FlagBahrainBuildMenu":["19572",62,108],
         "FlagCANBuildMenu":["114994",62,108],
         "FlagDENBuildMenu":["130313",62,108],
         "FlagEGYBuildMenu":["164538",62,108],
         "FlagENGBuildMenu":["121666",62,108],
         "FlagESPBuildMenu":["155581",62,108],
         "FlagEmiratesBuildMenu":["124020",62,108],
         "FlagFINBuildMenu":["1171",62,108],
         "FlagFRABuildMenu":["156791",62,108],
         "FlagGALBuildMenu":["141962",62,108],
         "FlagGERBuildMenu":["147862",62,108],
         "FlagHKGBuildMenu":["133985",62,108],
         "FlagINABuildMenu":["131081",62,108],
         "FlagINDBuildMenu":["112334",62,108],
         "FlagIRLBuildMenu":["125521",62,108],
         "FlagITABuildMenu":["128558",62,108],
         "FlagIraqBuildMenu":["134467",62,108],
         "FlagJordanBuildMenu":["144982",62,108],
         "FlagKSABuildMenu":["152211",62,108],
         "FlagKuwaitBuildMenu":["160330",62,108],
         "FlagLibyaBuildMenu":["126931",62,108],
         "FlagMASBuildMenu":["145155",62,108],
         "FlagMEXBuildMenu":["13147",62,108],
         "FlagMoroccoBuildMenu":["132495",62,108],
         "FlagNEDBuildMenu":["146263",62,108],
         "FlagNORBuildMenu":["124955",62,108],
         "FlagPHIBuildMenu":["146109",62,108],
         "FlagPIRATEBuildMenu":["14938",62,108],
         "FlagPOLBuildMenu":["1330",62,108],
         "FlagPORBuildMenu":["125991",62,108],
         "FlagPalestineBuildMenu":["145601",62,108],
         "FlagQatarBuildMenu":["160187",62,108],
         "FlagRUSBuildMenu":["163759",62,108],
         "FlagSCOBuildMenu":["156926",62,108],
         "FlagSINBuildMenu":["155298",62,108],
         "FlagSRBBuildMenu":["154957",62,108],
         "FlagSWEBuildMenu":["163852",62,108],
         "FlagTURBuildMenu":["133052",62,108],
         "FlagTunisBuildMenu":["131362",62,108],
         "FlagUSABuildMenu":["131852",62,108],
         "FlagWOMBuildMenu":["111301",62,108],
         "B29BuildMenu":["126779",104,88],
         "B30BuildMenu":["119867",101,100],
         "B31BuildMenu":["127432",51,114],
         "B32BuildMenu":["144507",75,99],
         "B33BuildMenu":["137199",71,96],
         "B34BuildMenu":["115927",56,103],
         "B35BuildMenu":["156522",64,100],
         "B36BuildMenu":["120664",61,98],
         "B37BuildMenu":["121709",115,109],
         "B38BuildMenu":["113892",118,109],
         "B39BuildMenu":["129225",76,66],
         "B40BuildMenu":["149381",79,53],
         "B41BuildMenu":["151007",58,72],
         "B45BuildMenu":["161484",68,104],
         "B16BuildMenu":["136800",103,96],
         "B17BuildMenu":["138327",95,70],
         "B18BuildMenu":["111570",93,74],
         "B19BuildMenu":["110234",104,73],
         "B20BuildMenu":["145565",93,105],
         "B21BuildMenu":["15306",73,112],
         "B22BuildMenu":["127989",102,71],
         "B23BuildMenu":["150967",99,86],
         "B24BuildMenu":["112343",59,91],
         "B25BuildMenu":["121599",44,101],
         "B26BuildMenu":["12045",71,105],
         "B27BuildMenu":["145013",101,107],
         "B28BuildMenu":["156166",88,98],
         "B42BuildMenu":["114494",99,91],
         "B43BuildMenu":["164031",104,72],
         "B44BuildMenu":["11155",90,97],
         "B88BuildMenu":["147408",94,91],
         "B11BuildMenu":["154210",104,108],
         "B12BuildMenu":["129921",96,101],
         "B13BuildMenu":["161005",76,96],
         "B14BuildMenu":["116333",87,79],
         "B15BuildMenu":["156186",87,117],
         "B10S1Silhouette":["152315",207,136],
         "B10S2Silhouette":["115176",210,157],
         "B10S3Silhouette":["125619",209,171],
         "B10S4Silhouette":["1939",219,176],
         "B10S5Silhouette":["14957",209,195],
         "B10S6Silhouette":["15976",203,194],
         "B10S7Silhouette":["127573",185,218],
         "B10S8Silhouette":["156889",185,277],
         "B11S1Silhouette":["119253",194,195],
         "B11S2Silhouette":["144015",184,208],
         "B11S3Silhouette":["150284",182,219],
         "B11S4Silhouette":["118604",207,199],
         "B12S1Silhouette":["159638",187,186],
         "B12S2Silhouette":["142084",197,200],
         "B12S3Silhouette":["114280",201,184],
         "B12S4Silhouette":["117830",203,197],
         "B13S1Silhouette":["157273",145,162],
         "B13S2Silhouette":["12830",171,263],
         "B13S3Silhouette":["118338",110,249],
         "B13S4Silhouette":["131035",107,242],
         "B14S1Silhouette":["125347",191,165],
         "B14S2Silhouette":["112732",185,172],
         "B14S3Silhouette":["140542",184,181],
         "B14S4Silhouette":["134094",164,212],
         "B15Silhouette":["118563",185,236],
         "B16Silhouette":["110304",202,181],
         "B17S1Silhouette":["141994",211,148],
         "B17S2Silhouette":["160355",226,190],
         "B17S3Silhouette":["164705",197,204],
         "B17S4Silhouette":["158736",188,252],
         "B18S1Silhouette":["145657",226,172],
         "B18S2Silhouette":["154047",218,164],
         "B18S3Silhouette":["118658",217,174],
         "B18S4Silhouette":["130300",206,165],
         "B19Silhouette":["128879",239,155],
         "B20S1Silhouette":["141930",199,203],
         "B20S2Silhouette":["130819",206,217],
         "B20S3Silhouette":["147927",181,211],
         "B21Silhouette":["155716",188,271],
         "B22S1Silhouette":["128017",251,168],
         "B22S2Silhouette":["122148",257,198],
         "B22S3Silhouette":["135239",251,218],
         "B22S4Silhouette":["140991",248,252],
         "B23Silhouette":["125340",221,188],
         "B24Silhouette":["164982",155,211],
         "B25Silhouette":["162828",113,228],
         "B26Silhouette":["158476",173,234],
         "B27Silhouette":["112809",214,216],
         "B28Silhouette":["164735",240,233],
         "B29Silhouette":["114648",213,170],
         "B30Silhouette":["117585",228,208],
         "B31Silhouette":["120812",131,267],
         "B32Silhouette":["121153",158,190],
         "B33Silhouette":["157787",173,217],
         "B34Silhouette":["152865",152,251],
         "B35Silhouette":["119551",117,179],
         "B36Silhouette":["142463",159,234],
         "B37Silhouette":["149731",232,214],
         "B38Silhouette":["126964",233,214],
         "B39Silhouette":["128468",203,165],
         "B40Silhouette":["17341",203,128],
         "B41S1Silhouette":["18767",145,180],
         "B41S2Silhouette":["110840",151,190],
         "B41S3Silhouette":["14229",186,220],
         "B41S4Silhouette":["112430",185,216],
         "B41S5Silhouette":["153598",186,215],
         "B42Silhouette":["137840",268,282],
         "B43Silhouette":["118384",240,163],
         "B44Silhouette":["117075",216,221],
         "B45Silhouette":["147604",138,210],
         "B97Silhouette":["126849",196,236],
         "B99Silhouette":["111384",188,187],
         "FortificationSilhouetteLargeS1":["19476",249,135],
         "FortificationSilhouetteLargeS2":["143313",241,150],
         "FortificationSilhouetteLargeS3":["149611",258,143],
         "FortificationSilhouetteLargeS4":["127048",258,148],
         "Map1VisualAvatarBackground5":["121992",83,142],
         "Part28":["126345",83,51],
         "Part29":["145380",34,29],
         "Part30":["140315",63,45],
         "Part31":["138429",42,20],
         "Part32":["134796",81,50],
         "Part33":["131932",93,44],
         "Part34":["139384",38,27],
         "Part35":["138160",73,42],
         "Part36":["144465",51,25],
         "Part37":["120622",118,53],
         "Part38":["125010",58,47],
         "Part39":["1203",24,24],
         "Part40":["144142",40,36],
         "Part41":["126309",97,52],
         "Part42":["137936",43,33],
         "Part43":["145217",61,37],
         "Part44":["1630",30,29],
         "Part45":["18054",48,39],
         "Part46":["12855",72,46],
         "Part47":["15259",46,36],
         "Part48":["140834",106,52],
         "Part49":["145719",34,24],
         "Part50":["153158",50,46],
         "Part51":["159828",42,29],
         "Part52":["158491",29,24],
         "Part53":["138042",120,99],
         "Part54":["149223",122,80],
         "Part55":["158346",107,116],
         "Part56":["157524",191,132],
         "Part57":["124106",163,83],
         "Part58":["145689",188,122],
         "B43BuildingDamagedRoofBack":["115465",58,72],
         "B43BuildingDestroyedRoof":["149624",56,64],
         "B43BuildingRoofBack":["145992",41,39],
         "B43BuildingBack":["157318",261,155],
         "B43BuildingDamagedBack":["116720",250,148],
         "B43BuildingDamagedFront":["161899",263,172],
         "B43BuildingDestroyed":["149117",244,141],
         "B43BuildingFront":["163063",263,172],
         "B38Building":["151441",186,143],
         "B38BuildingDamaged":["121851",166,112],
         "B38BuildingDestroyed":["129542",163,96],
         "B38Animation":["17318",1116,143],
         "B31Building":["135308",109,140],
         "B31BuildingDamaged":["137234",103,126],
         "B31BuildingDestroyed":["132189",102,55],
         "BeastCageBack":["135538",236,178],
         "BeastCageFront":["152511",236,178],
         "B45Building":["163451",130,124],
         "B45BuildingDamaged":["156758",124,111],
         "B45BuildingDestroyed":["110920",120,66],
         "B29BuildingBack":["132066",262,203],
         "B29BuildingDamagedBack":["137174",266,197],
         "B29BuildingDamagedFront":["146487",281,209],
         "B29BuildingDestroyed":["117966",281,152],
         "B29BuildingFrontWithoutFlame":["146187",281,209],
         "B29Animation":["120031",424,91],
         "B30Animation":["120031",424,91],
         "B30Building":["127911",207,178],
         "B30BuildingDamaged":["112558",208,170],
         "B30BuildingDestroyed":["126116",207,134],
         "B44Building":["128799",135,122],
         "B44BuildingDamaged":["157880",135,122],
         "B44BuildingDestroyed":["115680",135,70],
         "B32Animation":["136805",3104,69],
         "B32Building":["164082",93,72],
         "B32BuildingDamaged":["132803",101,72],
         "B32BuildingDestroyed":["140533",107,80],
         "B32Crater":["116019",42,39],
         "B32Explosion":["121879",912,55],
         "B39Building":["120734",47,26],
         "B39BuildingUsed":["19958",50,35],
         "B36Animation":["122400",3008,95],
         "B36Building":["18632",125,54],
         "B36BuildingDamaged":["144631",125,54],
         "B36BuildingDestroyed":["132006",173,71],
         "B23Building":["138621",138,92],
         "B23BuildingDamaged":["136355",140,90],
         "B23BuildingDestroyed":["12380",124,72],
         "B21Animation":["157334",532,38],
         "B21Building":["119981",169,169],
         "B21BuildingDamaged":["113887",134,151],
         "B21BuildingDestroyed":["121103",125,97],
         "B10S1Animation":["142963",899,123],
         "B10S1Building":["125043",195,121],
         "B10S1BuildingDamaged":["112810",203,114],
         "B10S1BuildingDestroyed":["13104",195,101],
         "B10S2Building":["157729",203,135],
         "B10S2BuildingDamaged":["157013",199,115],
         "B10S2BuildingDestroyed":["18399",174,92],
         "B10S3Building":["110592",202,149],
         "B10S3BuildingDamaged":["118343",199,130],
         "B10S3BuildingDestroyed":["121349",201,110],
         "B10S4Building":["145390",252,166],
         "B10S4BuildingDamaged":["151453",229,140],
         "B10S4BuildingDestroyed":["127902",207,106],
         "B10S5Building":["163716",222,188],
         "B10S5BuildingDamaged":["132679",205,168],
         "B10S5BuildingDestroyed":["158523",203,126],
         "B10S6Building":["18077",240,177],
         "B10S6BuildingDamaged":["139109",209,174],
         "B10S6BuildingDestroyed":["122741",191,124],
         "B10S7Animation":["127178",840,30],
         "B10S7Building":["140723",253,206],
         "B10S7BuildingDamaged":["116512",231,182],
         "B10S7BuildingDestroyed":["151445",216,163],
         "B10S8Building":["132496",258,270],
         "B10S8BuildingDamaged":["156444",270,210],
         "B10S8BuildingDestroyed":["147158",215,153],
         "CityExpansionSign":["1948",154,96],
         "B26Building":["17616",134,151],
         "B26BuildingDamaged":["132476",139,152],
         "B26BuildingDestroyed":["125187",127,95],
         "B27Animation":["154774",750,77],
         "B27Building":["115366",157,99],
         "B27BuildingDamaged":["117395",157,134],
         "B27BuildingDestroyed":["131936",159,102],
         "B34Building":["164848",137,133],
         "B34BuildingDamaged":["157606",135,117],
         "B34BuildingDestroyed":["141909",113,83],
         "B40Building":["146079",56,29],
         "B40BuildingUsed":["127922",56,29],
         "B33Building":["163001",136,117],
         "B33BuildingDamaged":["123636",133,117],
         "B33BuildingDestroyed":["126609",117,91],
         "B33BurnTrace":["131204",49,37],
         "B20BuildingDestroyed":["15403",191,93],
         "B20S1Animation":["136766",460,16],
         "B20S1Building":["18503",152,134],
         "B20S1BuildingDamaged":["113141",153,132],
         "B20S2Animation":["147083",882,29],
         "B20S2Building":["148746",177,148],
         "B20S2BuildingDamaged":["193",179,155],
         "B20S3Animation":["143273",920,16],
         "B20S3Building":["139651",229,189],
         "B20S3BuildingDamaged":["115500",225,197],
         "B42Building":["19832",149,121],
         "B42BuildingDamaged":["133761",146,115],
         "B42BuildingDestroyed":["137234",144,84],
         "B14BuildingDestroyed":["150182",105,75],
         "B14S1Animation":["133327",182,20],
         "B14S1Building":["138900",105,77],
         "B14S1BuildingDamaged":["139670",109,75],
         "B14S2Animation":["157513",273,29],
         "B14S2Building":["163088",98,76],
         "B14S2BuildingDamaged":["129142",100,71],
         "B14S3Animation":["144102",273,29],
         "B14S3Building":["162604",133,95],
         "B14S3BuildingDamaged":["124893",122,90],
         "B14S4Animation":["155608",208,40],
         "B14S4Building":["119486",136,128],
         "B14S4BuildingDamaged":["160836",123,111],
         "B11BuildingDestroyed":["137149",139,92],
         "B11S1Animation":["159905",1260,49],
         "B11S1Building":["126819",110,87],
         "B11S1BuildingDamaged":["152666",141,95],
         "B11S2Animation":["121112",315,47],
         "B11S2Building":["144295",118,109],
         "B11S2BuildingDamaged":["114986",134,107],
         "B11S3Animation":["146210",560,37],
         "B11S3Building":["163260",129,112],
         "B11S3BuildingDamaged":["126656",135,112],
         "B11S4Animation":["132995",1500,41],
         "B11S4Building":["145011",146,110],
         "B11S4BuildingDamaged":["14343",136,115],
         "B19BuildingBack":["141890",261,155],
         "B19BuildingDamagedBack":["131295",250,148],
         "B19BuildingDamagedFront":["161899",263,172],
         "B19BuildingDestroyed":["128712",244,141],
         "B19BuildingFront":["163063",263,172],
         "B28Animation":["12527",5820,49],
         "B28Building":["128635",157,136],
         "B28BuildingDamaged":["142272",157,129],
         "B28BuildingDestroyed":["120534",157,90],
         "B17BuildingDestroyed":["130148",139,77],
         "B17S1Building":["122490",149,95],
         "B17S1BuildingDamaged":["12070",156,89],
         "B17S2Building":["150505",151,115],
         "B17S2BuildingDamaged":["140673",151,91],
         "B17S3Building":["121285",149,140],
         "B17S3BuildingDamaged":["154604",154,108],
         "B17S4Building":["158779",154,184],
         "B17S4BuildingDamaged":["136805",154,131],
         "B35Animation":["134552",2880,57],
         "B35Building":["116615",114,86],
         "B35BuildingDamaged":["157539",106,83],
         "B35BuildingDestroyed":["161365",120,78],
         "B13BuildingDestroyed":["113112",147,102],
         "B13S1Animation":["115755",1122,38],
         "B13S1Building":["147765",116,75],
         "B13S1BuildingDamaged":["125056",125,67],
         "B13S2Animation":["117917",1947,75],
         "B13S2Building":["119103",137,92],
         "B13S2BuildingDamaged":["137470",131,125],
         "B13S3Animation":["143090",1947,75],
         "B13S3Building":["15844",175,115],
         "B13S3BuildingDamaged":["126710",171,128],
         "B13S4Animation":["132845",1485,68],
         "B13S4Building":["149906",160,125],
         "B13S4BuildingDamaged":["122989",175,166],
         "B15Animation":["122520",1378,37],
         "B15Building":["151570",116,131],
         "B15BuildingDamaged":["12542",120,103],
         "B15BuildingDestroyed":["146410",105,47],
         "B12BuildingDestroyed":["13076",125,49],
         "B12S1Animation":["127254",1920,52],
         "B12S1Building":["159868",111,89],
         "B12S1BuildingDamaged":["14688",103,69],
         "B12S2Animation":["114826",1960,48],
         "B12S2Building":["120607",118,99],
         "B12S2BuildingDamaged":["13942",126,75],
         "B12S3Animation":["122918",1720,50],
         "B12S3Building":["128414",128,98],
         "B12S3BuildingDamaged":["120866",143,82],
         "B12S4Animation":["110794",1760,44],
         "B12S4Building":["112454",128,110],
         "B12S4BuildingDamaged":["110686",120,76],
         "B18BuildingDestroyed":["19382",120,89],
         "B18S1Animation":["15582",1026,35],
         "B18S1Building":["1446",136,89],
         "B18S1BuildingDamaged":["130252",140,91],
         "B18S2Building":["128988",131,85],
         "B18S2BuildingDamaged":["151391",131,89],
         "B18S3Animation":["138447",999,31],
         "B18S3Building":["165212",135,90],
         "B18S3BuildingDamaged":["110607",151,93],
         "B18S4Animation":["128847",837,25],
         "B18S4Building":["118121",147,98],
         "B18S4BuildingDamaged":["14999",142,96],
         "B25BuildingBase":["116974",113,138],
         "B25BuildingDamaged":["150677",123,107],
         "B25BuildingDestroyed":["149467",105,76],
         "B25Animation":["150192",975,87],
         "B25Building":["13824",113,108],
         "B41Shadow":["116557",70,33],
         "B41ShadowDamaged":["117052",67,31],
         "B41ShadowDestroyed":["121961",53,28],
         "B41S1Building":["122447",48,58],
         "B41S1BuildingDamaged":["150506",48,58],
         "B41S1BuildingDestroyed":["111721",48,58],
         "B41S2Building":["17783",48,58],
         "B41S2BuildingDamaged":["131171",48,58],
         "B41S2BuildingDestroyed":["116145",48,58],
         "B41S3Building":["158662",48,58],
         "B41S3BuildingDamaged":["143231",48,58],
         "B41S3BuildingDestroyed":["141908",48,58],
         "B41S4Building":["156044",48,58],
         "B41S4BuildingDamaged":["15910",48,58],
         "B41S4BuildingDestroyed":["126221",48,58],
         "B41S5Building":["129900",48,58],
         "B41S5BuildingDamaged":["141443",48,58],
         "B41S5BuildingDestroyed":["154238",48,58],
         "B37Building":["158291",186,143],
         "B37BuildingDamaged":["116649",178,151],
         "B37BuildingDestroyed":["160187",164,95],
         "B37Animation":["130095",1116,143],
         "BoundBottom":["12171",1554,423],
         "BoundLeft":["1690",762,649],
         "BoundMiddle":["143637",272,117],
         "BoundRight":["119899",697,649],
         "BoundTop":["1488",929,299],
         "AbandonedWagon":["117440",62,41],
         "AxeAndBlock":["141948",21,24],
         "Barrel":["136527",29,27],
         "BlueFlowers":["12758",29,24],
         "Coffin":["156415",51,30],
         "DeadCrow":["159573",30,31],
         "FarmersFork":["19826",29,39],
         "Haybale":["153059",40,27],
         "Lamb":["124870",90,51],
         "Lantern":["117479",95,82],
         "Letter0":["152608",55,47],
         "Letter1":["12282",55,47],
         "Letter2":["110425",55,47],
         "Letter3":["145442",55,47],
         "Letter4":["18384",55,47],
         "Letter5":["142277",55,47],
         "Letter6":["164134",55,47],
         "Letter7":["143934",55,47],
         "Letter8":["153574",55,47],
         "Letter9":["149357",55,47],
         "LetterA":["1561",38,47],
         "LetterB":["122890",38,47],
         "LetterC":["144783",38,47],
         "LetterCS":["158784",38,47],
         "LetterD":["113059",38,47],
         "LetterE":["132744",38,47],
         "LetterF":["136404",38,47],
         "LetterG":["154477",38,47],
         "LetterGS":["119571",38,47],
         "LetterH":["123890",38,47],
         "LetterI":["140142",38,47],
         "LetterIS":["119426",38,47],
         "LetterJ":["127122",38,47],
         "LetterK":["116766",38,47],
         "LetterL":["118114",38,47],
         "LetterM":["132713",38,47],
         "LetterN":["154831",38,47],
         "LetterO":["136741",38,47],
         "LetterOS":["143540",38,47],
         "LetterP":["159295",38,47],
         "LetterQ":["136679",38,47],
         "LetterR":["125798",38,47],
         "LetterS":["19720",38,47],
         "LetterSS":["156362",38,47],
         "LetterT":["146370",38,47],
         "LetterU":["140650",38,47],
         "LetterUS":["114587",38,47],
         "LetterV":["159829",38,47],
         "LetterW":["139859",38,47],
         "LetterX":["132246",38,47],
         "LetterY":["11107",38,47],
         "LetterZ":["126449",38,47],
         "Pumpkin":["153669",85,50],
         "RamadanCannon":["146124",46,42],
         "RamadanDrum":["128019",45,39],
         "RedFlowers":["140571",46,23],
         "Scarecrow":["129828",111,90],
         "Thorns":["141228",41,39],
         "Tombstone":["127605",32,32],
         "TournamentBronze":["110767",107,106],
         "TournamentGold":["159168",124,125],
         "TournamentSilver":["15576",120,119],
         "WoodenCart":["116937",42,27],
         "Woodpile":["15375",42,31],
         "FlagFabricARG":["14459",23,50],
         "FlagFabricAUS":["119599",23,50],
         "FlagFabricAlgeria":["15040",23,50],
         "FlagFabricBEL":["19547",23,50],
         "FlagFabricBRA":["110227",23,50],
         "FlagFabricBahrain":["125179",23,50],
         "FlagFabricCAN":["161091",23,50],
         "FlagFabricDEN":["128054",23,50],
         "FlagFabricEGY":["161782",23,50],
         "FlagFabricENG":["110779",23,50],
         "FlagFabricESP":["17545",23,50],
         "FlagFabricEmirates":["164891",23,50],
         "FlagFabricFIN":["19273",23,50],
         "FlagFabricFRA":["131567",23,50],
         "FlagFabricGAL":["119516",23,50],
         "FlagFabricGER":["154622",23,50],
         "FlagFabricHKG":["131580",23,50],
         "FlagFabricINA":["126277",23,50],
         "FlagFabricIND":["129867",23,50],
         "FlagFabricIRL":["123805",23,50],
         "FlagFabricITA":["143863",23,50],
         "FlagFabricIraq":["149902",23,50],
         "FlagFabricJordan":["165339",23,50],
         "FlagFabricKSA":["117313",23,50],
         "FlagFabricKuwait":["129109",23,50],
         "FlagFabricLibya":["161323",23,50],
         "FlagFabricMAS":["127063",23,50],
         "FlagFabricMEX":["124130",23,50],
         "FlagFabricMorocco":["15099",23,50],
         "FlagFabricNED":["153830",23,50],
         "FlagFabricNOR":["129316",23,50],
         "FlagFabricPHI":["136504",23,50],
         "FlagFabricPIRATE":["130740",23,50],
         "FlagFabricPOL":["125531",23,50],
         "FlagFabricPOR":["117151",23,50],
         "FlagFabricPalestine":["165196",23,50],
         "FlagFabricQatar":["117893",23,50],
         "FlagFabricRUS":["150909",23,50],
         "FlagFabricSCO":["129596",23,50],
         "FlagFabricSIN":["157402",23,50],
         "FlagFabricSRB":["135901",23,50],
         "FlagFabricSWE":["152606",23,50],
         "FlagFabricTUR":["110289",23,50],
         "FlagFabricTunis":["123088",23,50],
         "FlagFabricUSA":["131447",23,50],
         "FlagFabricWOM":["113968",23,50],
         "FlagPole":["114704",62,91],
         "FlagARG":["148810",107,91],
         "FlagAUS":["122750",107,91],
         "FlagAlgeria":["140881",107,91],
         "FlagBEL":["163415",107,91],
         "FlagBRA":["15735",107,91],
         "FlagBahrain":["120612",107,91],
         "FlagCAN":["123199",107,91],
         "FlagDEN":["12426",107,91],
         "FlagEGY":["142450",107,91],
         "FlagENG":["121249",107,91],
         "FlagESP":["133889",107,91],
         "FlagEmirates":["114273",107,91],
         "FlagFIN":["132294",107,91],
         "FlagFRA":["16095",107,91],
         "FlagGAL":["116187",107,91],
         "FlagGER":["111401",107,91],
         "FlagHKG":["161063",107,91],
         "FlagINA":["112850",107,91],
         "FlagIND":["123403",107,91],
         "FlagIRL":["119962",107,91],
         "FlagITA":["162307",107,91],
         "FlagIraq":["137356",107,91],
         "FlagJordan":["130761",107,91],
         "FlagKSA":["116279",107,91],
         "FlagKuwait":["164028",107,91],
         "FlagLibya":["122552",107,91],
         "FlagMAS":["156872",107,91],
         "FlagMEX":["124111",107,91],
         "FlagMorocco":["134674",107,91],
         "FlagNED":["153257",107,91],
         "FlagNOR":["120603",107,91],
         "FlagPHI":["117911",107,91],
         "FlagPIRATE":["125284",107,91],
         "FlagPOL":["156773",107,91],
         "FlagPOR":["165528",107,91],
         "FlagPalestine":["134697",107,91],
         "FlagQatar":["154233",107,91],
         "FlagRUS":["153543",107,91],
         "FlagSCO":["128613",107,91],
         "FlagSIN":["137633",107,91],
         "FlagSRB":["157077",107,91],
         "FlagSWE":["152801",107,91],
         "FlagTUR":["161766",107,91],
         "FlagTunis":["139302",107,91],
         "FlagUSA":["141540",107,91],
         "FlagWOM":["115430",107,91],
         "FortificationLargeS1Back":["132347",367,114],
         "FortificationLargeS1Front":["160331",361,114],
         "FortificationLargeS2Back":["126466",356,135],
         "FortificationLargeS2Front":["145883",333,134],
         "FortificationLargeS3Back":["118012",376,134],
         "FortificationLargeS3Front":["120841",384,199],
         "FortificationLargeS4Back":["147609",365,130],
         "FortificationLargeS4Front":["126231",364,144],
         "FortificationMediumS1Back":["159553",175,62],
         "FortificationMediumS1Front":["119155",199,73],
         "FortificationMediumS2Back":["152102",187,79],
         "FortificationMediumS2Front":["164093",169,82],
         "FortificationMediumS3Back":["116408",190,78],
         "FortificationMediumS3Front":["145520",176,72],
         "FortificationMediumS4Back":["164966",189,77],
         "FortificationMediumS4Front":["148602",165,73],
         "FortificationSmallS1Back":["161835",159,54],
         "FortificationSmallS1Front":["157481",173,62],
         "FortificationSmallS2Back":["154433",171,83],
         "FortificationSmallS2Front":["126719",158,77],
         "FortificationSmallS3Back":["112822",182,75],
         "FortificationSmallS3Front":["113792",172,83],
         "FortificationSmallS4Back":["157336",189,77],
         "FortificationSmallS4Front":["158996",165,96],
         "BarracksFull":["144146",29,36],
         "BeastReady":["138735",30,36],
         "FinishBuildingIcon":["18162",31,39],
         "GoldFull":["160479",29,36],
         "IronFull":["19555",29,36],
         "LumberFull":["149865",29,36],
         "MightFull":["123661",29,36],
         "RPFull":["127470",31,36],
         "SpeedupIcon":["119077",31,39],
         "StoneFull":["147358",29,36],
         "ScaffoldLarge":["116417",463,349],
         "ScaffoldLargeBack":["14603",383,231],
         "ScaffoldMedium":["121274",194,189],
         "ScaffoldMediumBack":["129128",194,120],
         "ScaffoldSmall":["141372",219,228],
         "ScaffoldSmallBack":["18283",219,228],
         "DamagedSmoke":["135523",3264,100],
         "DestroyedSmoke":["123750",1147,132],
         "BuildingFloor":["138921",240,120],
         "GrassTileM":["158471",199,200],
         "Soil100":["126153",200,100],
         "Soil130":["115380",260,130],
         "Soil160":["157437",320,160],
         "Soil70":["148121",140,70],
         "Soil80":["158068",160,80],
         "Soil90":["148060",180,90],
         "Part06":["11796",441,262],
         "Part01":["117115",435,249],
         "Part02":["152336",435,236],
         "Part03":["152012",435,272],
         "Part04":["18203",435,250],
         "Part05":["135111",444,244],
         "Part07":["16205",435,253],
         "Part08":["125098",444,245],
         "U27MotionS1Motion":["154196",1120,1120],
         "U27MotionS2Motion":["110446",1216,1216],
         "U27MotionS3Motion":["149875",1312,1312],
         "U27MotionS4Motion":["119845",1408,1408],
         "U27MotionS5Motion":["158830",1504,1504],
         "U27MotionS6Motion":["118548",1600,1600],
         "DragonflyShadow":["15477",98,52],
         "U25MotionS1Motion":["126417",1120,1120],
         "U25MotionS2Motion":["117712",1216,1216],
         "U25MotionS3Motion":["164881",1312,1312],
         "U25MotionS4Motion":["11446",1408,1408],
         "U25MotionS5Motion":["11242",1504,1504],
         "U25MotionS6Motion":["158944",1600,1600],
         "U26MotionS1Motion":["137301",1120,1120],
         "U26MotionS2Motion":["110608",1216,1216],
         "U26MotionS3Motion":["123050",1312,1312],
         "U26MotionS4Motion":["158255",1408,1408],
         "U26MotionS5Motion":["114189",1504,1504],
         "U26MotionS6Motion":["161771",1600,1600],
         "U33MotionS1Motion":["112249",1120,1120],
         "U33MotionS2Motion":["155984",1216,1216],
         "U33MotionS3Motion":["126847",1312,1312],
         "U33MotionS4Motion":["122779",1408,1408],
         "U33MotionS5Motion":["134926",1504,1504],
         "U33MotionS6Motion":["118244",1600,1600],
         "HezarfenShadow":["148720",39,20],
         "U10Motion":["16251",512,512],
         "U11Motion":["117091",512,512],
         "U12Motion":["126084",512,512],
         "U13Motion":["141331",512,512],
         "U14Explosion":["158282",128,64],
         "U14Motion":["139268",512,512],
         "U15Motion":["150502",512,512],
         "U16Motion":["152695",512,512],
         "U17Motion":["155519",512,512],
         "U18Motion":["124308",512,512],
         "U19Motion":["142981",512,512],
         "U20Motion":["127404",512,512],
         "U21Motion":["1192",512,512],
         "U22Motion":["144063",512,512],
         "U23Motion":["119891",512,512],
         "U24Motion":["18538",512,512],
         "U28Motion":["141578",512,512],
         "U29Motion":["162730",114,117],
         "U30Motion":["146639",1120,1120],
         "U31Motion":["126978",512,512],
         "U32Motion":["14269",512,512],
         "U34Motion":["154174",114,117],
         "WorkerMotion":["129935",512,512],
         "BanditCountBackground":["131110",24,20],
         "HurlingStone1":["121630",100,100],
         "HurlingStone2":["164032",100,100],
         "HurlingStone3":["152567",100,100],
         "HurlingStone4":["134699",100,100],
         "LumberSalvo1":["125831",99,100],
         "LumberSalvo2":["138814",99,100],
         "LumberSalvo3":["1132",99,100],
         "LumberSalvo4":["155863",99,100],
         "MightyRage1":["128603",99,100],
         "MightyRage2":["128954",99,100],
         "MightyRage3":["14131",99,100],
         "MightyRage4":["112515",99,100],
         "AcidRainIcon":["152225",54,51],
         "AcidRainIconMedium":["142527",99,100],
         "AcidRainLarge":["155777",271,434],
         "AcidRainMedium":["153550",87,93],
         "AcidTowerIcon":["141298",54,51],
         "AcidTowerIconMedium":["17653",99,100],
         "AcidTowerLarge":["157220",413,424],
         "AcidTowerMedium":["158584",72,113],
         "CyclopIcon":["146069",54,51],
         "CyclopIconMedium":["18724",99,100],
         "CyclopLarge":["129666",499,334],
         "CyclopMedium":["136714",128,88],
         "HealAuraIcon":["15701",54,51],
         "HealAuraIconMedium":["150964",99,100],
         "HealAuraLarge":["122614",291,419],
         "HealAuraMedium":["123256",72,113],
         "IceShardIcon":["132444",54,51],
         "IceShardIconMedium":["157508",99,100],
         "IceShardLarge":["151003",319,464],
         "IceShardMedium":["142869",103,133],
         "LongBowmanIcon":["125345",54,51],
         "LongBowmanIconMedium":["124281",99,100],
         "LongbowmanLarge":["112482",318,504],
         "LongbowmanMedium":["127415",67,133],
         "SamuraiTeamIcon":["142609",54,51],
         "SamuraiTeamIconMedium":["116642",99,100],
         "SamuraiTeamLarge":["125964",418,456],
         "SamuraiTeamMedium":["115201",103,112],
         "SiegeTowerIcon":["136861",54,51],
         "SiegeTowerIconMedium":["110164",99,100],
         "SiegeTowerLarge":["160789",413,424],
         "SiegeTowerMedium":["11195",72,113],
         "WolfpackIcon":["153584",54,51],
         "WolfpackIconMedium":["144523",99,100],
         "WolfpackLarge":["13191",430,283],
         "WolfpackMedium":["122823",131,87],
         "VillagerV2Map":["159157",54,51],
         "MEventVillagerV2BackgroundBeforeHD":["147110",1527,978],
         "MEventVillagerV2BackgroundBeforeSD":["135637",764,489],
         "MEventVillagerV2BackgroundHD":["144182",1521,642],
         "MEventVillagerV2BackgroundSD":["117227",761,321],
         "MEventVillagerV2Icon1HD":["16689",108,108],
         "MEventVillagerV2Icon1SD":["135092",54,54],
         "MEventVillagerV2Icon2HD":["162692",108,108],
         "MEventVillagerV2Icon2SD":["149700",54,54],
         "EventVillagerV2Background":["115233",586,261],
         "EventVillagerV2BackgroundBefore":["142848",508,355],
         "EventVillagerV2BackgroundHowTo":["126211",188,398],
         "EventVillagerV2Icon1":["160779",64,64],
         "EventVillagerV2Icon2":["1390",65,65],
         "AfterBanditOutpostBackground":["159777",418,285],
         "BeforeBanditOutpostBackground":["153338",508,285],
         "CityLoadingYouLose":["15509",1167,287],
         "CityLoadingYouWin":["1439",1167,287],
         "TakeoverBanditOutpostBigImage":["123493",688,258],
         "BrickTile":["116382",80,80],
         "BrickTile52":["11212",52,52],
         "BronzeCoil":["144287",80,80],
         "BronzeCoil52":["114720",52,52],
         "ClayTile":["142305",80,80],
         "ClayTile52":["146588",52,52],
         "Cloth":["152502",80,80],
         "Cloth52":["117594",52,52],
         "GearShaft":["127890",80,80],
         "GearShaft52":["154002",52,52],
         "GrindingStone":["157920",80,80],
         "GrindingStone52":["12434",52,52],
         "Hammer":["125231",80,80],
         "Hammer52":["160977",52,52],
         "LightningRod":["116651",80,80],
         "LightningRod52":["134180",52,52],
         "Magnet":["142188",80,80],
         "Magnet52":["18263",52,52],
         "Nail":["125293",80,80],
         "Nail52":["147910",52,52],
         "Paint":["154903",80,80],
         "Paint52":["137165",52,52],
         "Pin":["113045",80,80],
         "Pin52":["156234",52,52],
         "Rope":["159099",80,80],
         "Rope52":["111436",52,52],
         "SafetyHat":["123868",80,80],
         "SafetyHat52":["125209",52,52],
         "Screw":["131898",80,80],
         "Screw52":["146957",52,52],
         "Shovel":["113642",80,80],
         "Shovel52":["135268",52,52],
         "Spud":["157019",80,80],
         "Spud52":["140187",52,52],
         "SteelBar":["130871",80,80],
         "SteelBar52":["120752",52,52],
         "StoneBlock":["14453",80,80],
         "StoneBlock52":["11565",52,52],
         "ToothedWheel":["15151",80,80],
         "ToothedWheel52":["163938",52,52],
         "Trolley":["123443",80,80],
         "Trolley52":["145206",52,52],
         "Tube":["141930",80,80],
         "Tube52":["152080",52,52],
         "Wire":["13139",80,80],
         "Wire52":["15132",52,52],
         "WoodenPlanks":["11169",80,80],
         "WoodenPlanks52":["111839",52,52],
         "CityPlannerFloor":["117708",100,100],
         "Q10":["159670",68,68],
         "Q100":["146306",68,68],
         "Q1000":["14918",68,68],
         "Q1100":["14918",68,68],
         "Q1200":["145354",68,68],
         "Q125":["111300",68,68],
         "Q1300":["163126",68,68],
         "Q1400":["126526",68,68],
         "Q1500":["125240",68,68],
         "Q1600":["149200",68,68],
         "Q1700":["151980",68,68],
         "Q1800":["134086",68,68],
         "Q1900":["125240",68,68],
         "Q20":["154485",68,68],
         "Q200":["160221",68,68],
         "Q2000":["18885",68,68],
         "Q2100":["148010",68,68],
         "Q2200":["164706",68,68],
         "Q2300":["111907",68,68],
         "Q2400":["18885",68,68],
         "Q2500":["134346",68,68],
         "Q2600":["159443",68,68],
         "Q2650":["159670",68,68],
         "Q2675":["164706",68,68],
         "Q2700":["158579",68,68],
         "Q2800":["18885",68,68],
         "Q2900":["138667",68,68],
         "Q30":["134147",68,68],
         "Q300":["149116",68,68],
         "Q3000":["148010",68,68],
         "Q3100":["145212",68,68],
         "Q3200":["164975",68,68],
         "Q3300":["126526",68,68],
         "Q3400":["18885",68,68],
         "Q350":["127300",68,68],
         "Q3500":["162990",68,68],
         "Q3600":["157144",68,68],
         "Q3800":["111796",68,68],
         "Q3900":["119390",68,68],
         "Q40":["137412",68,68],
         "Q400":["121796",68,68],
         "Q4000":["132581",68,68],
         "Q4050":["18885",68,68],
         "Q4100":["126526",68,68],
         "Q4200":["120535",68,68],
         "Q4300":["142741",68,68],
         "Q4400":["18885",68,68],
         "Q450":["143603",68,68],
         "Q4500":["142554",68,68],
         "Q4600":["142741",68,68],
         "Q4700":["140816",68,68],
         "Q4800":["136764",68,68],
         "Q4900":["123629",68,68],
         "Q50":["163117",68,68],
         "Q500":["18885",68,68],
         "Q5000":["131784",68,68],
         "Q5100":["133812",68,68],
         "Q5200":["128111",68,68],
         "Q5300":["145354",68,68],
         "Q5400":["139071",68,68],
         "Q5500":["136120",68,68],
         "Q5600":["13713",68,68],
         "Q5700":["145212",68,68],
         "Q5800":["128111",68,68],
         "Q5900":["145576",68,68],
         "Q60":["148082",68,68],
         "Q600":["142926",68,68],
         "Q6000":["13713",68,68],
         "Q6100":["149541",68,68],
         "Q6200":["145109",68,68],
         "Q70":["142741",68,68],
         "Q700":["126526",68,68],
         "Q80":["149498",68,68],
         "Q800":["119518",68,68],
         "Q850":["164706",68,68],
         "Q900":["125332",68,68],
         "Q1700P":["150467",255,248],
         "Q2100P":["127580",255,248],
         "Q2500P":["155002",255,248],
         "Q2600P":["110924",255,248],
         "Q300P":["136623",255,248],
         "Q4700P":["117365",255,248],
         "Q700P":["153161",255,248],
         "Q80P":["158296",255,248],
         "QResourcesP":["157965",255,248],
         "QF100":["161374",90,90],
         "QF1000":["129858",90,90],
         "QF1100":["129858",90,90],
         "QF1200":["15229",90,90],
         "QF125":["117985",90,90],
         "QF1300":["157791",90,90],
         "QF1400":["148177",90,90],
         "QF1500":["139527",90,90],
         "QF1600":["118816",90,90],
         "QF1700":["150148",90,90],
         "QF1800":["130763",90,90],
         "QF1900":["143787",90,90],
         "QF200":["151751",90,90],
         "QF2000":["143787",90,90],
         "QF2100":["155355",90,90],
         "QF2200":["14809",90,90],
         "QF2300":["164405",90,90],
         "QF2400":["141196",90,90],
         "QF2500":["135521",90,90],
         "QF2600":["148750",90,90],
         "QF2650":["154026",90,90],
         "QF2675":["14809",90,90],
         "QF2700":["146940",90,90],
         "QF2800":["145589",90,90],
         "QF2900":["110510",90,90],
         "QF300":["149774",90,90],
         "QF3000":["155355",90,90],
         "QF3100":["148958",90,90],
         "QF3200":["160957",90,90],
         "QF3300":["163811",90,90],
         "QF3400":["150800",90,90],
         "QF350":["156533",90,90],
         "QF3500":["152361",90,90],
         "QF3600":["116804",90,90],
         "QF3700":["112818",90,90],
         "QF3800":["139565",90,90],
         "QF3900":["147510",90,90],
         "QF40":["145096",90,90],
         "QF400":["134666",90,90],
         "QF4000":["119869",92,90],
         "QF4050":["146085",90,90],
         "QF4100":["163811",90,90],
         "QF4200":["142679",90,90],
         "QF4300":["149508",90,90],
         "QF4400":["146411",90,90],
         "QF450":["141441",90,90],
         "QF4500":["149823",90,90],
         "QF4600":["158991",90,90],
         "QF4700":["125585",90,90],
         "QF4800":["130870",90,90],
         "QF4900":["143383",90,90],
         "QF500":["146085",90,90],
         "QF5000":["155363",90,90],
         "QF5100":["153459",90,90],
         "QF5200":["132987",90,90],
         "QF5300":["147786",90,90],
         "QF5400":["154064",90,90],
         "QF5500":["149540",90,90],
         "QF5600":["156217",90,90],
         "QF5700":["146439",90,90],
         "QF5800":["11033",90,90],
         "QF5900":["143045",90,90],
         "QF600":["114357",90,90],
         "QF6000":["143372",90,90],
         "QF6100":["119940",90,90],
         "QF6200":["138277",90,90],
         "QF700":["148177",90,90],
         "QF80":["144729",90,90],
         "QF800":["14348",90,90],
         "QF850":["14809",90,90],
         "QF900":["129215",90,90],
         "QFTutorial100":["133828",90,90],
         "QFTutorial200":["126782",90,90],
         "QFTutorial300":["126782",90,90],
         "QFTutorial500":["128501",90,90],
         "QFTutorial600":["15542",90,90],
         "QFTutorial700":["158991",90,90],
         "QFTutorial800":["112229",90,90],
         "Cut1Hour":["158601",57,76],
         "Cut2Hours":["126931",70,81],
         "Cut30Min":["150948",59,79],
         "ExpressHiring":["132291",81,86],
         "FinishNow":["12681",81,82],
         "FreeFinish":["163123",55,76],
         "ProductionBoost1":["141123",80,74],
         "ProductionBoost2":["158987",80,76],
         "QuickHiring":["132469",76,82],
         "RepairAllBuildings":["155189",74,75],
         "SpeedyHiring":["129941",78,83],
         "SwiftHiring":["130660",77,82],
         "ExtraBarrackSpace1":["125393",90,73],
         "ExtraBarrackSpace2":["144579",90,73],
         "LouderHorn":["13184",77,64],
         "MercDamageBoost1":["145045",64,89],
         "MercDamageBoost2":["134455",83,89],
         "MercHealthBoost":["164382",80,76],
         "MercSpeedBoost":["146394",64,80],
         "ShieldDaily":["19105",71,77],
         "ShieldMonthly":["155043",69,77],
         "ShieldWeekly":["121069",65,77],
         "TowerDamageBoost":["127149",41,91],
         "CityExpansion":["13927",82,72],
         "ExtraWorker":["114648",80,77],
         "FasterUpgrade":["15821",76,71],
         "WallUpgrade1":["133215",75,86],
         "WallUpgrade2":["133923",76,87],
         "WallUpgrade3":["148876",77,86],
         "WallUpgrade4":["135950",77,86],
         "IronBoost":["156892",61,59],
         "IronFillUp":["118246",78,76],
         "IronTouchUp":["145836",61,50],
         "IronTouchUp52":["151793",52,52],
         "LumberBoost":["132882",68,63],
         "LumberFillUp":["132180",68,72],
         "LumberTouchUp":["140954",49,51],
         "LumberTouchUp52":["157379",52,52],
         "MightBoost":["117693",70,73],
         "MightFillUp":["115699",83,73],
         "MightTouchUp":["132847",41,46],
         "MightTouchUp52":["158433",52,52],
         "StockpileBoost":["120034",71,97],
         "StoneBoost":["131044",50,60],
         "StoneFillUp":["15836",69,63],
         "StoneTouchUp":["11102",37,42],
         "StoneTouchUp52":["155269",52,52],
         "TalkTrash1":["116714",184,304],
         "TalkTrash1Over":["129171",184,304],
         "TalkTrash2":["159631",184,304],
         "TalkTrash2Over":["159104",184,304],
         "TalkTrash3":["131629",184,304],
         "TalkTrash3Over":["122933",184,304],
         "LevelUpBaseDestroyedBackground":["142094",564,305],
         "LikeUsGold":["161583",80,38],
         "Treasury":["159772",354,113],
         "HelpNotifierIcon":["131613",57,52],
         "RequestFriendsIcon":["141743",42,40],
         "Damage":["122113",29,30],
         "Health":["138551",26,26],
         "LootIron":["124089",25,21],
         "LootLumber":["152512",24,25],
         "LootMight":["149092",24,25],
         "LootStone":["112190",22,22],
         "Target":["141814",25,29],
         "FriendsBarHelpIcon":["156737",24,24],
         "FriendsBarHelpIconBack":["152310",24,24],
         "FriendsBarLevelIcon":["158007",24,24],
         "AlreadyUnderAttackBackground":["146437",560,324],
         "PopupBackgroundMini":["136546",425,284],
         "BattleReportBackground":["163892",550,170],
         "BattleReportBackgroundDefeat":["17638",550,185],
         "BuildingsDestroyedIcon":["141636",102,54],
         "EloIconBad":["122847",121,120],
         "EloIconEmpty":["118158",121,120],
         "EloIconGood":["16415",121,120],
         "MercaneriesDeployedIcon":["153633",42,46],
         "TrophyIconMedium":["113673",44,44],
         "VSShieldSword":["117294",76,77],
         "BrokenChain":["17023",326,309],
         "CagedBeastBackground":["114862",659,300],
         "CityCenter4":["128791",111,94],
         "CityUnderattackBackground":["141727",418,285],
         "CityUnderattackBackgroundImage":["126646",560,280],
         "AllianceEventBackground":["133384",428,355],
         "DoubleArrow":["129478",18,14],
         "EventBackground":["16463",428,355],
         "EventBackground1":["130754",508,355],
         "EventBackground2":["125716",508,355],
         "EventBackground3":["11265",508,435],
         "EventBackground4":["162314",508,435],
         "EventBackgroundHowTo":["127047",188,398],
         "EventCeltBackground":["147839",586,261],
         "EventCeltBackgroundBefore":["165144",508,355],
         "EventCeltBackgroundHowTo":["117513",188,398],
         "EventPlagueBackground":["17844",586,261],
         "EventPopupBackground":["122446",508,285],
         "IronEventBackground":["130143",508,355],
         "VillagerBackground":["115233",586,261],
         "VillagerHowTo":["131347",193,398],
         "VillagerStartBackground":["142848",508,355],
         "ExecuteBeastQ":["142394",97,109],
         "ShinyColor1":["137285",122,157],
         "ShinyColor3":["140138",122,157],
         "HelpGirl":["144199",270,363],
         "DiscountPatlangac":["116940",108,108],
         "TopSellerBackground":["139499",514,47],
         "InviteFriendsImage":["13792",340,419],
         "League0Mini":["117699",20,21],
         "League0Small":["149088",64,66],
         "League1Medium":["156483",149,147],
         "League1Mini":["115300",24,25],
         "League1Small":["138777",68,67],
         "League2Medium":["162875",149,147],
         "League2Mini":["140902",24,25],
         "League2Small":["126864",68,67],
         "League3Medium":["143427",189,147],
         "League3Mini":["19911",30,25],
         "League3Small":["137200",86,67],
         "League4Medium":["128833",189,157],
         "League4Mini":["110692",28,26],
         "League4Small":["162612",86,72],
         "League5Medium":["137463",189,160],
         "League5Mini":["154418",28,26],
         "League5Small":["121351",86,73],
         "League6Medium":["113470",189,159],
         "League6Mini":["165521",28,25],
         "League6Small":["122598",86,73],
         "LeagueDropped":["17563",418,285],
         "LeagueReach":["116874",418,285],
         "LeagueRelegate":["139204",418,285],
         "SeasonEndNotr":["135603",418,285],
         "SeasonEndWin":["122910",418,285],
         "LevelUpImage":["157215",792,529],
         "LevelUpLevel":["142017",50,51],
         "CampaignPassFriendBackground":["148230",293,192],
         "GreenArrow":["131346",51,48],
         "PassFriendBackground":["11303",425,285],
         "RedArrow":["14439",51,48],
         "IndependenceBadge":["131099",101,100],
         "SpecialOfferIndependence":["146160",550,300],
         "TavernBackground":["159080",569,416],
         "TournamentEndBg":["128861",418,285],
         "TournamentGoldIcon":["113818",260,128],
         "TournamentReward1":["143026",102,156],
         "TournamentReward2":["140018",111,155],
         "TournamentReward3":["12115",109,139],
         "TuskHornSilhouette":["156418",163,355],
         "Bearwolf1":["132196",350,358],
         "Bearwolf2":["137502",347,331],
         "Bearwolf3":["14439",317,401],
         "Bearwolf4":["121895",311,386],
         "Bearwolf5":["148505",335,398],
         "Bearwolf6":["149469",328,357],
         "Dragonfly1":["160877",366,323],
         "Dragonfly2":["129493",380,323],
         "Dragonfly3":["116079",371,291],
         "Dragonfly4":["12438",379,294],
         "Dragonfly5":["163511",412,312],
         "Dragonfly6":["117739",442,318],
         "Mightosour1":["163545",361,291],
         "Mightosour2":["128941",334,359],
         "Mightosour3":["11772",366,352],
         "Mightosour4":["115144",317,328],
         "Mightosour5":["165118",389,327],
         "Mightosour6":["125793",344,325],
         "Womkong1":["145590",360,360],
         "Womkong2":["16211",360,360],
         "Womkong3":["163577",360,360],
         "Womkong4":["149446",360,360],
         "Womkong5":["124105",360,360],
         "Womkong6":["136833",360,360],
         "BearwolfPortrait1":["151374",54,51],
         "BearwolfPortrait2":["115161",54,51],
         "BearwolfPortrait3":["129764",54,51],
         "BearwolfPortrait4":["148172",54,51],
         "BearwolfPortrait5":["160971",54,51],
         "BearwolfPortrait6":["150437",54,51],
         "DragonflyPortrait1":["112653",54,51],
         "DragonflyPortrait2":["128590",54,51],
         "DragonflyPortrait3":["19872",54,51],
         "DragonflyPortrait4":["16768",54,51],
         "DragonflyPortrait5":["140359",54,51],
         "DragonflyPortrait6":["18986",54,51],
         "MightosourPortrait1":["11579",54,51],
         "MightosourPortrait2":["121565",54,51],
         "MightosourPortrait3":["156538",54,51],
         "MightosourPortrait4":["123421",54,51],
         "MightosourPortrait5":["126742",54,51],
         "MightosourPortrait6":["155199",54,51],
         "WomkongPortrait1":["155130",54,51],
         "WomkongPortrait2":["128113",54,51],
         "WomkongPortrait3":["16882",54,51],
         "WomkongPortrait4":["163354",54,51],
         "WomkongPortrait5":["148094",54,51],
         "WomkongPortrait6":["128709",54,51],
         "DemonKingClan":["125837",292,348],
         "IronHandClan":["163428",295,331],
         "RagingBullClan":["162045",270,332],
         "ShriekingDragonClan":["151753",239,337],
         "ClementineHurray":["19064",281,466],
         "ClementineMaybe":["143412",236,309],
         "PoseMedium1":["121088",384,349],
         "PoseMedium2":["14848",211,358],
         "PoseMedium3":["162111",264,349],
         "PoseMedium4":["116580",217,445],
         "PoseMedium5":["143001",245,345],
         "PoseMedium6":["157491",234,281],
         "PoseMedium7":["125676",244,344],
         "PoseMedium8":["137990",358,364],
         "PoseMedium9":["110802",183,211],
         "PoseSmall2":["116860",180,238],
         "PoseSmall3":["15038",220,233],
         "PoseSmall5":["140812",202,208],
         "FarmerGirl":["129181",305,620],
         "BedouinBruteQR":["1840",45,45],
         "GentleHealerQR":["146473",45,45],
         "HezarfenQR":["147365",45,45],
         "JanissaryQR":["146209",45,45],
         "KhamikazeeQR":["112322",45,45],
         "MongolianGargantuanQR":["122960",45,45],
         "NightRiderQR":["18424",45,45],
         "NubianGuardQR":["132721",45,45],
         "PainblowerQR":["149655",45,45],
         "PersianHashishinQR":["11335",45,45],
         "PersianSapperQR":["165106",45,45],
         "PharaohWarriorQR":["163883",45,45],
         "RavagerQR":["151575",45,45],
         "RocknGaulQR":["115049",45,45],
         "SneakPeakQR":["122952",45,45],
         "BedoinBruteFull":["155026",278,390],
         "BedoinBruteLarge":["139702",202,445],
         "BedoinBruteMedium":["131141",99,100],
         "BedoinBruteSmall":["149937",54,51],
         "GentleHealerFull":["17419",257,418],
         "GentleHealerLarge":["134036",202,445],
         "GentleHealerMedium":["14716",99,100],
         "GentleHealerSmall":["162384",54,51],
         "HezarfenFull":["148961",254,391],
         "HezarfenLarge":["114587",202,445],
         "HezarfenMedium":["146643",99,100],
         "HezarfenSmall":["130927",54,51],
         "JanissaryFull":["19147",261,346],
         "JanissaryLarge":["137060",202,445],
         "JanissaryMedium":["158092",99,100],
         "JanissarySmall":["146134",54,51],
         "KhamikazeeFull":["110615",285,387],
         "KhamikazeeLarge":["146614",202,445],
         "KhamikazeeMedium":["164968",99,100],
         "KhamikazeeSmall":["131038",54,51],
         "MongolianGargantuanFull":["144524",332,265],
         "MongolianGargantuanLarge":["113269",202,445],
         "MongolianGargantuanMedium":["19880",99,100],
         "MongolianGargantuanSmall":["132011",54,51],
         "NightRiderFull":["116198",226,392],
         "NightRiderLarge":["112144",202,445],
         "NightRiderMedium":["117730",99,100],
         "NightRiderSmall":["112893",54,51],
         "NubianGuardFull":["1524",354,350],
         "NubianGuardLarge":["153591",202,445],
         "NubianGuardMedium":["161286",99,100],
         "NubianGuardSmall":["142439",54,51],
         "PainblowerFull":["18820",180,392],
         "PainblowerLarge":["139537",202,445],
         "PainblowerMedium":["122734",99,100],
         "PainblowerSmall":["114221",54,51],
         "PersianHashishinFull":["123241",281,335],
         "PersianHashishinLarge":["123309",202,445],
         "PersianHashishinMedium":["18770",99,100],
         "PersianHashishinSmall":["136255",54,51],
         "PersianSapperFull":["161654",309,319],
         "PersianSapperLarge":["117986",202,445],
         "PersianSapperMedium":["153056",99,100],
         "PersianSapperSmall":["160436",54,51],
         "PharaohWarriorFull":["135542",280,392],
         "PharaohWarriorLarge":["125579",202,445],
         "PharaohWarriorMedium":["144706",99,100],
         "PharaohWarriorSmall":["156080",54,51],
         "RavagerFull":["115540",304,386],
         "RavagerLarge":["13904",202,445],
         "RavagerMedium":["161319",99,100],
         "RavagerSmall":["160555",54,51],
         "RocknGaulFull":["142525",307,258],
         "RocknGaulLarge":["19534",202,445],
         "RocknGaulMedium":["143276",99,100],
         "RocknGaulSmall":["130758",54,51],
         "SneakPeakFull":["120740",255,391],
         "SneakPeakLarge":["117223",202,445],
         "SneakPeakMedium":["14444",99,100],
         "SneakPeakSmall":["126757",54,51],
         "AcidTowerPopup":["120474",372,275],
         "BedoinBrutePopup":["139911",350,275],
         "BedoinBruteTrch":["125315",403,424],
         "CyclopPopup":["117668",350,275],
         "GentleHealerPopup":["136074",350,275],
         "GentleHealerTrch":["137636",403,424],
         "HezarfenPopup":["136978",350,275],
         "HezarfenTrch":["1838",403,424],
         "JanissaryPopup":["14842",350,275],
         "JanissaryTrch":["16612",403,424],
         "KhamikazeePopup":["113744",350,275],
         "KhamikazeeTrch":["157802",403,424],
         "LongbowmanPopup":["132660",350,275],
         "MongolianGargantuanPopup":["1279",350,275],
         "MongolianGargantuanTrch":["126755",403,424],
         "NightRiderPopup":["112694",350,275],
         "NightRiderTrch":["164973",403,424],
         "NubianGuardPopup":["154930",350,275],
         "NubianGuardTrch":["160043",403,424],
         "PainblowerPopup":["126817",350,275],
         "PainblowerTrch":["134600",403,424],
         "PersianHashishinPopup":["118240",350,275],
         "PersianHashishinTrch":["119459",403,424],
         "PersianSapperPopup":["112367",350,275],
         "PersianSapperTrch":["159303",403,424],
         "PharaohWarriorPopup":["117226",350,275],
         "PharaohWarriorTrch":["122701",403,424],
         "RavagerPopup":["157081",350,275],
         "RavagerTrch":["122771",403,424],
         "RocknGaulPopup":["131240",350,275],
         "RocknGaulTrch":["121455",403,424],
         "SamuraiTeamPopup":["140454",450,275],
         "SiegeTowerPopup":["121648",372,275],
         "SneakPeakPopup":["19909",350,275],
         "SneakPeakTrch":["1861",403,424],
         "WolfpackPopup":["143424",350,275],
         "PrincessHappy":["131511",595,842],
         "PrincessNoMoney":["119787",614,842],
         "PrincessNormal":["151519",595,842],
         "PrincessNormalPopUp":["165373",405,395],
         "WorkerAngry":["133391",330,475],
         "WorkerHappy":["137168",312,436],
         "WorkerListen":["133383",365,348],
         "WorkerNormal":["111430",331,410],
         "WorkerSad":["130178",315,308],
         "WorkerScared":["137796",353,397],
         "WorkerTired":["128945",305,358],
         "Ambient":["125237",0,0],
         "AttackTheme":["121880",0,0],
         "CityTheme":["165388",0,0],
         "DefenseTheme":["151161",0,0],
         "BuildingLevel10Destroy":["129301",0,0],
         "BuildingLevel1To2Damage":["151531",0,0],
         "BuildingLevel1To2Destroy":["132548",0,0],
         "BuildingLevel3To4Damage":["162705",0,0],
         "BuildingLevel3To4Destroy":["12700",0,0],
         "BuildingLevel5Damage":["164602",0,0],
         "BuildingLevel5To9Destroy":["139159",0,0],
         "CityCenterDestroy":["113587",0,0],
         "DamagedFire":["142454",0,0],
         "ArchersTowerAttack":["154504",0,0],
         "BombardTowerAttack1":["140836",0,0],
         "BombardTowerAttack2":["123524",0,0],
         "BurningMirrorsAttack":["18813",0,0],
         "BurriedSpikesAttack":["119668",0,0],
         "FlamerTowerAttack":["129443",0,0],
         "GatlingArrowTowerAttack":["163648",0,0],
         "SkyTowerAttack":["1115",0,0],
         "SfxHurlingStones":["12095",0,0],
         "SfxLumberSalvo":["158529",0,0],
         "SfxMightyRage":["143577",0,0],
         "Ottoman":["162160",0,0],
         "BeastAttack13":["149009",0,0],
         "BeastAttack46":["134654",0,0],
         "BeastMove13":["151673",0,0],
         "BeastMove46":["12519",0,0],
         "BedouinBruteAttack":["121715",0,0],
         "GentleHealerAttack":["142163",0,0],
         "HezarfenAttack":["159065",0,0],
         "JanissaryAttack":["17663",0,0],
         "KhamikazeeAttack":["163686",0,0],
         "MongolianGargantuanAttack":["19020",0,0],
         "NightRiderAttack":["11642",0,0],
         "NubianGuardAttack":["144520",0,0],
         "PainblowerAttack":["144880",0,0],
         "PersianHashishinAttack":["121212",0,0],
         "PersianSapperAttack":["125604",0,0],
         "PharaohWarriorAttack":["141251",0,0],
         "RavagerAttack":["162657",0,0],
         "RocknGaulAttack":["146684",0,0],
         "SneakPeakAttack":["111140",0,0],
         "BeastDeath":["131147",0,0],
         "GentleHealerDeath":["159382",0,0],
         "MercDeath1":["163293",0,0],
         "MercDeath2":["154667",0,0],
         "MercDeath3":["158522",0,0],
         "RocknGaulDeath":["134122",0,0],
         "SneakPeakDeath":["133516",0,0],
         "GentleHealerMovement":["17970",0,0],
         "HezarfenMovement":["16847",0,0],
         "MercMovement1":["13106",0,0],
         "MercMovement2":["132651",0,0],
         "NightRiderMovement":["122917",0,0],
         "WorkerMovement1":["162694",0,0],
         "WorkerMovement2":["15013",0,0],
         "AliBabaAttack":["151628",0,0],
         "BuildingRepair":["149202",0,0],
         "ClickSound":["119247",0,0],
         "CollectResource":["130877",0,0],
         "ConstructionStarted":["119356",0,0],
         "InsufficientGold":["127266",0,0],
         "LevelUp":["160450",0,0],
         "PurchaseSuccessful":["114204",0,0],
         "QuestCompleted":["134949",0,0],
         "UpgradeCompleted":["164747",0,0],
         "UseResources":["160657",0,0],
         "VictoryChant":["113158",0,0],
         "VictorySplashScreen":["123596",0,0],
         "WorkerGotGold":["136913",0,0]
      };
      
      private var remoteAssetUrlPrefix:String;
      
      private const ALLIANCE_FLAG:String = "FlagAlliance";
      
      private const ALLIANCE_BARRACKS_COA:String = "AllianceBarracksCOA";
      
      private var documentConfiguration:WomDocumentConfiguration;
      
      public function WomDefaultAssetRepository(param1:LoaderInfo, param2:WomDocumentConfiguration)
      {
         super();
         remoteAssetUrlPrefix = param2.remoteAssetUrlPrefix;
         cacheAll();
         this.documentConfiguration = param2;
      }
      
      private function cacheAll() : void
      {
         var _loc2_:* = undefined;
         var _loc3_:int = getTimer();
         for(var _loc1_ in this["embeddedassets"])
         {
            _loc2_ = new this["embeddedassets"][_loc1_]();
            if(_loc2_ is Bitmap)
            {
               registerBitmapAsset(_loc1_,new BitmapAsset((_loc2_ as Bitmap).bitmapData));
            }
            else if(_loc2_ is Sound)
            {
               registerSoundAsset(_loc1_,new SoundAsset(_loc2_ as Sound));
            }
         }
         log(LoggerContexts.INFRASTRUCTURE,"Cached all assets in " + (getTimer() - _loc3_) + " ms");
      }
      
      public function getBitmap(param1:String) : Bitmap
      {
         return new Bitmap(getBitmapData(param1));
      }
      
      public function getBitmapDataClone(param1:String) : BitmapData
      {
         return getBitmapData(param1).clone();
      }
      
      override public function getBitmapAssetReference(param1:String) : BitmapAssetReference
      {
         if(param1 in bitmapAssets)
         {
            return new BitmapAssetReference(bitmapAssets[param1]);
         }
         if(param1 && param1.indexOf("FlagAlliance") != -1)
         {
            return createAllianceFlag(param1);
         }
         if(param1 && param1.indexOf("AllianceBarracksCOA") != -1)
         {
            return createAllianceBarracksCOA(param1);
         }
         false && log(LoggerContexts.INFRASTRUCTURE,"Asset Remote: " + param1);
         var _loc2_:String = remoteAssetUrlPrefix + param1;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(param1 in this["remoteassets"])
         {
            _loc2_ += ".cache" + this["remoteassets"][param1][0] + "?n";
            _loc3_ = int(this["remoteassets"][param1][1]);
            _loc4_ = int(this["remoteassets"][param1][2]);
         }
         var _loc6_:RemoteBitmapAsset = new RemoteBitmapAsset(_loc2_,false,3,_loc3_,_loc4_);
         registerBitmapAsset(param1,_loc6_);
         return new BitmapAssetReference(_loc6_);
      }
      
      private function createAllianceFlag(param1:String) : BitmapAssetReference
      {
         var _loc7_:String = "";
         var _loc9_:String = "BuildMenu";
         var _loc8_:Boolean = false;
         var _loc11_:String = param1;
         if(_loc11_.indexOf(_loc9_) != -1)
         {
            _loc11_ = _loc11_.substr(0,_loc11_.indexOf(_loc9_));
            _loc7_ = _loc9_;
            _loc8_ = true;
         }
         var _loc13_:uint = uint(_loc11_.substring("FlagAlliance".length,_loc11_.indexOf("x")));
         var _loc6_:uint = uint(_loc11_.substring(_loc11_.indexOf("x") + 1,_loc11_.lastIndexOf("x")));
         var _loc14_:int = int(_loc11_.substring(_loc11_.lastIndexOf("x") + 1));
         var _loc2_:BitmapData = (bitmapAssets["Flag" + _loc7_ + "Blank"] as BitmapAsset).bitmapData;
         var _loc10_:BitmapData = (bitmapAssets["Flag" + _loc7_ + "Empty"] as BitmapAsset).bitmapData;
         var _loc3_:BitmapData = (bitmapAssets["Flag" + _loc7_ + "Icon" + _loc14_] as BitmapAsset).bitmapData;
         fillColor(_loc10_,_loc13_);
         fillColor(_loc3_,_loc6_);
         var _loc12_:Point = new Point(0,15);
         var _loc5_:BitmapData = new BitmapData(_loc2_.width,_loc2_.height,true,0);
         _loc5_.lock();
         _loc5_.copyPixels(_loc10_,_loc10_.rect,_loc12_,null,null,true);
         _loc5_.copyPixels(_loc3_,_loc3_.rect,_loc12_,_loc3_,null,true);
         _loc5_.copyPixels(_loc2_,_loc2_.rect,new Point(),null,null,true);
         _loc5_.unlock();
         var _loc4_:BitmapAsset = new BitmapAsset(_loc5_);
         registerBitmapAsset(param1,_loc4_);
         return new BitmapAssetReference(_loc4_);
      }
      
      private function createAllianceBarracksCOA(param1:String) : BitmapAssetReference
      {
         var _loc5_:String = param1;
         var _loc8_:uint = uint(_loc5_.substring("AllianceBarracksCOA".length,_loc5_.indexOf("x")));
         var _loc10_:uint = uint(_loc5_.substring(_loc5_.indexOf("x") + 1,_loc5_.lastIndexOf("x")));
         var _loc9_:int = int(_loc5_.substring(_loc5_.lastIndexOf("x") + 1));
         var _loc3_:BitmapData = (bitmapAssets["SignBlank"] as BitmapAsset).bitmapData;
         var _loc12_:BitmapData = (bitmapAssets["SignEmpty"] as BitmapAsset).bitmapData;
         var _loc2_:BitmapData = (bitmapAssets["SignIcon" + _loc9_] as BitmapAsset).bitmapData;
         fillColor(_loc12_,_loc8_);
         fillColor(_loc2_,_loc10_);
         var _loc7_:Point = new Point(0,0);
         var _loc6_:BitmapData = new BitmapData(_loc3_.width,_loc3_.height,true,0);
         _loc6_.lock();
         _loc6_.copyPixels(_loc12_,_loc12_.rect,_loc7_,null,null,true);
         _loc6_.copyPixels(_loc2_,_loc2_.rect,_loc7_,_loc2_,null,true);
         _loc6_.copyPixels(_loc3_,_loc3_.rect,new Point(),null,null,true);
         _loc6_.unlock();
         var _loc4_:BitmapAsset = new BitmapAsset(_loc6_);
         registerBitmapAsset(param1,_loc4_);
         return new BitmapAssetReference(_loc4_);
      }
      
      private function fillColor(param1:BitmapData, param2:uint) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < param1.height)
         {
            _loc4_ = 0;
            while(_loc4_ < param1.width)
            {
               if(param1.getPixel(_loc4_,_loc3_) != 0)
               {
                  param1.setPixel(_loc4_,_loc3_,param2);
               }
               _loc4_++;
            }
            _loc3_++;
         }
      }
      
      override public function getSoundAssetReference(param1:String) : SoundAssetReference
      {
         if(param1 in soundAssets)
         {
            return new SoundAssetReference(soundAssets[param1]);
         }
         false && log(LoggerContexts.INFRASTRUCTURE,"Sound Remote: " + param1);
         var _loc2_:String = remoteAssetUrlPrefix + param1;
         if(param1 in this["remoteassets"])
         {
            _loc2_ += ".cache" + this["remoteassets"][param1][0];
         }
         var _loc3_:RemoteSoundAsset = new RemoteSoundAsset(_loc2_);
         registerSoundAsset(param1,_loc3_);
         return new SoundAssetReference(_loc3_);
      }
      
      public function getMobileAvatar(param1:String) : AssetDisplayObject
      {
         var _loc2_:String = "GuestAvatar" + param1;
         return new AssetDisplayObject(getBitmapAssetReference(_loc2_));
      }
      
      public function getFacebookPicture(param1:String) : AssetDisplayObject
      {
         var _loc3_:String = null;
         var _loc2_:String = null;
         var _loc4_:RoundedFacebookPicture = null;
         if(param1 != null)
         {
            _loc3_ = "fbpicture" + param1;
            if(_loc3_ in bitmapAssets)
            {
               return new AssetDisplayObject(new BitmapAssetReference(bitmapAssets[_loc3_]));
            }
            _loc2_ = "https://graph.facebook.com/v2.2/_/picture".replace("_",param1);
            _loc4_ = new RoundedFacebookPicture(_loc2_,getBitmapAssetReference("FacebookFallbackPicture"));
            registerBitmapAsset(_loc3_,_loc4_);
            return new AssetDisplayObject(new BitmapAssetReference(_loc4_));
         }
         return new AssetDisplayObject(getBitmapAssetReference("FacebookFallbackPicture"));
      }
      
      public function getAvatarByProfile(param1:Profile) : AssetDisplayObject
      {
         var _loc2_:String = null;
         if(param1.isNpc)
         {
            switch(param1.npcClan)
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
            return getDisplayObject(_loc2_);
         }
         if(!param1.platformId && param1.avatar)
         {
            return getMobileAvatar(param1.mobileAvatarIndex);
         }
         if(param1.platformId)
         {
            return getFacebookPicture(param1.platformId);
         }
         return new AssetDisplayObject(getBitmapAssetReference("FacebookFallbackPicture"));
      }
      
      public function getRemoteAnnouncementAsset(param1:String, param2:String) : AssetDisplayObject
      {
         var _loc3_:String = "Announcement_" + param1;
         if(_loc3_ in bitmapAssets)
         {
            return new AssetDisplayObject(new BitmapAssetReference(bitmapAssets[_loc3_]));
         }
         var _loc4_:RemoteBitmapAsset = new RemoteBitmapAsset(param2);
         registerBitmapAsset(_loc3_,_loc4_);
         return new AssetDisplayObject(new BitmapAssetReference(_loc4_));
      }
   }
}


package game.managers
{
	import common.utils.HashMap;
	
	import game.untils.DynamicAtlas;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	/**
	 * 贴图管理器
	 * @author noah
	 */	
	public class TextureMgr
	{
		/**
		 *单例模式 
		 */		
		private static var _instance:TextureMgr;
		/**
		 * 单例访问器
		 * @return 
		 */		
		public static function get instance():TextureMgr {
			if(_instance == null) {
				_instance = new TextureMgr();
			}
			return _instance;
		}
		
		protected var atlasArr:Vector.<TextureAtlas>;
		protected var texturesHashArr:Vector.<HashMap>;
		
		/**
		 * 
		 */		
		public function TextureMgr()
		{
			if(_instance != null){
				throw new Error("该类是单例模式");
			}
			_instance = this;
			
			atlasArr = new Vector.<TextureAtlas>();
			texturesHashArr = new Vector.<HashMap>();
		}
		/**
		 * 
		 */		
		public function init():void
		{
			var boyMc:PeopleBoyMc = new PeopleBoyMc();
			atlasArr[0] = DynamicAtlas.fromMovieClipContainer(boyMc, 1, 0, true, true);
			var girlMc:PeopleGirlMc = new PeopleGirlMc();
			atlasArr[1] = DynamicAtlas.fromMovieClipContainer(girlMc, 1, 0, true, true);
			var monsterMc:PeopleMonsterMc = new PeopleMonsterMc();
			atlasArr[2] = DynamicAtlas.fromMovieClipContainer(monsterMc, 1, 0, true, true);
			inifTextures( atlasArr );
		}
		/**
		 * 
		 * @param vect
		 */		
		private function inifTextures( vect:Vector.<TextureAtlas> ):void
		{
			for (var j:uint=0;j<3;j++){
				var texturesHash:HashMap = new HashMap();
				texturesHashArr[j] = texturesHash;
				for (var i:uint=1;i<33;i++){
					if(i < 10){
						texturesHash.put("m0" + i, vect[j].getTextures("m0" + i));
					} else {
						texturesHash.put("m" + i, vect[j].getTextures("m" + i));
					}		
				}
			}
		}
		/**
		 * 
		 * @param index
		 * @return 
		 */
		public function getAtlas( index:uint ):TextureAtlas{
			return atlasArr[index];
		}
		
		/**
		 * 
		 * @param str
		 * @return 
		 */		
		public function getTextures( num:uint, str:String):Vector.<Texture>{
			
			return texturesHashArr[num].get(str) as Vector.<Texture>;
		}
	}
}
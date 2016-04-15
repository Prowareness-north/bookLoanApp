package nl.pw.apps.data
{
	import starling.textures.Texture;

	public class EmbeddedAssets
	{
		[Embed(source="/../assets/images/atlas/facebook.png")]
		private static const FACEBOOK_EMBEDDED:Class;

		

		public static var ATLAS:Texture;
		
		public static function initialize():void
		{
			//we can't create these textures until Starling is ready
			ATLAS = Texture.fromEmbeddedAsset(FACEBOOK_EMBEDDED, false);
			
		}
	}
}

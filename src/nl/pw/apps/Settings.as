package nl.pw.apps 
{
	/**
	 * ...
	 * @author Dave Woertman
	 */
	public final class Settings 
	{
		private static var _instance:Settings;
		
		public var bolComOpenAPIKey:String = "11739B5476D54D2CB6E3A8CA99D70E39";
		public var bolComOpenAPI_URL:String = "https://api.bol.com/catalog/v4/search";
		public var bolComOpenAPIformat:String = "json";
		//Only use with version3 of OpenAPI
		public var bolComOpenAPISecretKey:String = "842302312CC1EEE7C64C8BC9324F9DB52950FD8F7A679031C826C81E389562B60F2BED2CBB289964966F80430AEA2F8A67E80AD9B04CB593A927D54EB22ECB2CEF4CAB69AF35D671A5E2FDE889619C6358877FA8449A41C98760C3BE34764CAA98F0CAF0FE0891C00648FA6E92E7D9EC7F7763909B206CD16D22B4B669CE9E2C"
		//Flox settings
		public var floxGameID:String = "WyxecpK8FTlj1qau";
		public var floxGameKey:String = "BRCt7RNRtKDnxD0a";
		public var floxGameVersion:String = "0.2";
		
		public function Settings() 
		{
				if (_instance) {
						throw new Error("Singleton...USe getInstance instead");
				}
				_instance = this;
		}
		public static function getInstance():Settings {
			if (!_instance) {
					new Settings();
			}
			return _instance;
		}
	}

}
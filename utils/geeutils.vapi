namespace Gee {
	namespace Utils {
		namespace Async {
			[CCode (cheader_filename = "async.h")]
			public async void yield_and_unlock (GLib.Mutex mutex);
		}
		namespace Free {
			[CCode (cheader_filename = "free.h")]
			public GLib.DestroyNotify get_destroy_notify<G> ();
		}
		namespace Misc {
			[CCode (cheader_filename = "misc.h", simple_generics = true)]
			public void unused<G> (G unused);
		}
	}
}
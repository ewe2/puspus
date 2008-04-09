#include <linux/module.h>
#include <linux/vermagic.h>
#include <linux/compiler.h>

MODULE_INFO(vermagic, VERMAGIC_STRING);

struct module __this_module
__attribute__((section(".gnu.linkonce.this_module"))) = {
 .name = KBUILD_MODNAME,
 .init = init_module,
#ifdef CONFIG_MODULE_UNLOAD
 .exit = cleanup_module,
#endif
 .arch = MODULE_ARCH_INIT,
};

static const struct modversion_info ____versions[]
__attribute_used__
__attribute__((section("__versions"))) = {
	{ 0x4d7cf8c7, "struct_module" },
	{ 0x9a1dfd65, "strpbrk" },
	{ 0xca49a95c, "per_cpu__current_task" },
	{ 0x12da5bb2, "__kmalloc" },
	{ 0x9afe9c91, "__mod_timer" },
	{ 0xf9a482f9, "msleep" },
	{ 0x8e9eceaa, "complete_and_exit" },
	{ 0xd6ee688f, "vmalloc" },
	{ 0x933568d6, "alloc_etherdev" },
	{ 0x75b38522, "del_timer" },
	{ 0xc7ec6c27, "strspn" },
	{ 0xc8b57c27, "autoremove_wake_function" },
	{ 0x6337d4ed, "malloc_sizes" },
	{ 0x9ce3050c, "remove_wait_queue" },
	{ 0x9633a534, "netif_carrier_on" },
	{ 0x925b90d, "dev_get_by_name" },
	{ 0x62779d75, "netif_carrier_off" },
	{ 0x3f3ad74f, "usb_kill_urb" },
	{ 0x21895f98, "filp_close" },
	{ 0xeae3dfd6, "__const_udelay" },
	{ 0x85df9b6c, "strsep" },
	{ 0x2fd1d81c, "vfree" },
	{ 0x1d26aa98, "sprintf" },
	{ 0x7d11c268, "jiffies" },
	{ 0x84e77aa6, "netif_rx" },
	{ 0xffd5a395, "default_wake_function" },
	{ 0xaa136450, "param_get_charp" },
	{ 0x88ce4ace, "wait_for_completion" },
	{ 0x2bc95bd4, "memset" },
	{ 0x8d3894f2, "_ctype" },
	{ 0xbb99e222, "usb_deregister" },
	{ 0x1b7d4074, "printk" },
	{ 0xfc17cc58, "free_netdev" },
	{ 0x795340bb, "__tasklet_schedule" },
	{ 0x2da418b5, "copy_to_user" },
	{ 0xb085d3d2, "register_netdev" },
	{ 0x2cd3086, "__down_failed_trylock" },
	{ 0x9f0fb023, "wireless_send_event" },
	{ 0x47d1ad01, "usb_control_msg" },
	{ 0x625acc81, "__down_failed_interruptible" },
	{ 0x9545af6d, "tasklet_init" },
	{ 0x707f93dd, "preempt_schedule" },
	{ 0x770b53c3, "dev_kfree_skb_any" },
	{ 0xd79b5a02, "allow_signal" },
	{ 0x82072614, "tasklet_kill" },
	{ 0xab4d3dab, "skb_over_panic" },
	{ 0xa9f7624a, "module_put" },
	{ 0xa0aaefcf, "usb_submit_urb" },
	{ 0xde1ebd5e, "kmem_cache_alloc" },
	{ 0x2b545780, "__alloc_skb" },
	{ 0xfb421208, "usb_get_dev" },
	{ 0x86c84e1f, "usb_put_dev" },
	{ 0x17d59d01, "schedule_timeout" },
	{ 0xc23fb24, "eth_type_trans" },
	{ 0x2c6a1056, "ether_setup" },
	{ 0x6cb34e5, "init_waitqueue_head" },
	{ 0xfde9fe64, "init_timer" },
	{ 0x2cd7da6c, "param_set_charp" },
	{ 0xab8f2178, "add_wait_queue" },
	{ 0x37a0cba, "kfree" },
	{ 0x932da67e, "kill_proc" },
	{ 0x801678, "flush_scheduled_work" },
	{ 0x7d1ed1f2, "prepare_to_wait" },
	{ 0x41f9582c, "usb_register_driver" },
	{ 0x2a7b11d4, "finish_wait" },
	{ 0x7e9ebb05, "kernel_thread" },
	{ 0x60a4461c, "__up_wakeup" },
	{ 0xb0e76172, "unregister_netdev" },
	{ 0xb742fd7, "simple_strtol" },
	{ 0xa9392f2b, "complete" },
	{ 0x25da070, "snprintf" },
	{ 0x9c5af643, "__netif_schedule" },
	{ 0xf2a644fb, "copy_from_user" },
	{ 0x5f5c8560, "usb_free_urb" },
	{ 0x9e7d6bd0, "__udelay" },
	{ 0xdc43a9c8, "daemonize" },
	{ 0x84af2dfe, "usb_alloc_urb" },
	{ 0x85c52f0f, "filp_open" },
};

static const char __module_depends[]
__attribute_used__
__attribute__((section(".modinfo"))) =
"depends=";

MODULE_ALIAS("usb:v148Fp2573d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v148Fp2671d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v7392p7318d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v7392p7618d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v050Dp905Bd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v14B2p3C10d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v18E8p6196d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v18E8p6229d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v18E8p6238d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v1044p8008d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v14B2p3C22d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0DB0p6877d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0DB0pA874d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0DB0pA861d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v07B8pB21Dd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0769p31F3d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v1472p0009d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v1371p9022d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v1371p9032d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v1631pC019d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v1044p800Ad*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v1690p0722d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0DF6p9712d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0DF6p90ACd*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v148Fp9021d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0EB0p9021d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0411p00D8d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0586p3415d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0B05p1723d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v0B05p1724d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v050Dp705Ad*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v07D1p3C03d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v13B1p0023d*dc*dsc*dp*ic*isc*ip*");
MODULE_ALIAS("usb:v13B1p0020d*dc*dsc*dp*ic*isc*ip*");

MODULE_INFO(srcversion, "D6D68CCCC5991CDA3190E26");

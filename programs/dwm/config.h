/*             
	 _|     _ _  
	(_|\/\/| | | 
 */            

/* appearance */
static const unsigned int borderpx  = 2;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "FiraCode Nerd Font:size=13"  };
static const char dmenufont[]       = "FiraCode Nerd Font:size=13";
static const char col_gray1[]       = "#282828"; //background normal
static const char col_gray2[]       = "#282828"; //border normal
static const char col_gray3[]       = "#a89984"; //foreground normal
static const char col_gray4[]       = "#b8bb26"; //foreground selected
static const char col_cyan[]        = "#1d2021"; //background/border selected
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_cyan,  col_cyan  },
};

/* tagging */
/* { code, pdf, admin, paused, research, processing, spotify, web} */
static const char *tags[] = {"1","2","3","4","5","6","7","8","9"};
static const unsigned int gappx = 5;        /* gap pixel between windows */
static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	// web browsers go on 9
	{ "navigator",  NULL,       NULL,       1 << 8,       0,           -1 },
	{ "firefox",	NULL,       NULL,       1 << 8,       0,           -1 },
	// music goes on 8
	{ "Spotify",	NULL,	    NULL,	1 << 7,       0,	   -1 },
	// communication apps go on 7
	{ "signal",	NULL,       NULL,       1 << 6,       0,           -1 },
	{ "Signal",	NULL,       NULL,       1 << 6,       0,           -1 },
	{ "Mail",	NULL,       NULL,       1 << 6,       0,           -1 },
	{ "thunderbird",NULL,       NULL,       1 << 6,       0,           -1 },
	{ "discord ",	NULL,       NULL,       1 << 6,       0,           -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "",	tile },    /* first entry is default */
	{ "",	NULL },    /* no layout function means floating behavior */
	{ "󰍉",	monocle },
	{ "",	bstack	},
	{ "󰛻",	bstackhoriz },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
// dmenu commands
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *passmenucmd[] = { "passmenu", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *termcmd[]  = { "st", NULL };
static const char *termcmd_sessionized[]  = { "st", "-e", "tmux-sessionizer.sh", NULL };
static const char *lockcmd[] = {"slock", NULL };
static const char *volcmd[] = {"st", "-e", "alsamixer",	NULL};
static const char *screenshotcmd[] = {"maim", "-s", ">", "$(date +%F%H).jpg", NULL};

// brightness -- requires acpilight.
static const char *brightnessdowncmd[] = {"xbacklight" , "-ctrl", "amdgpu_bl2", "-dec", "5", NULL};
static const char *brightnessupcmd[] = {"xbacklight" , "-ctrl", "amdgpu_bl2", "-inc", "5", NULL};
static const char *brightnesssetcmd[] = { "dmenubrightness.sh", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *btconnectcmd[] = { "dmenubtconnect.sh", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *btdisconnectcmd[] = { "dmenubtdisconnect.sh", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_d,      spawn,          {.v = dmenucmd } },
	{ MODKEY,			XK_v,	   spawn,          {.v = volcmd } },
	{ MODKEY,			XK_Return, spawn,          {.v = termcmd_sessionized } },
	{ MODKEY|ShiftMask,		XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY|ShiftMask,		XK_z,	   spawn,	   {.v = lockcmd } },
	{ MODKEY|ShiftMask,		XK_s,      spawn,	   {.v = screenshotcmd} },
	{ MODKEY,			XK_p,      spawn,	   {.v = passmenucmd } },
	{ MODKEY,                       XK_space,  togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY|ShiftMask,		XK_c,      incnmaster,     {.i = +1 } }, //increment no. in master
	{ MODKEY|ShiftMask,		XK_v,      incnmaster,     {.i = -1 } }, //decrement no. in master
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_z, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY,                       XK_q,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} }, //tiling layout
	{ MODKEY|ShiftMask,		XK_f,      setlayout,      {.v = &layouts[1]} }, //floating layout
	{ MODKEY,                       XK_w,      setlayout,      {.v = &layouts[2]} }, //monocole layout
	{ MODKEY,			XK_e,	   setlayout,	   {.v = &layouts[3]} }, //bottom stack
	{ MODKEY|ShiftMask,		XK_e,	   setlayout,	   {.v = &layouts[4]} }, //bottom stack hor
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	{ MODKEY,			XK_b,	   spawn, {.v = brightnessdowncmd } },
	{ MODKEY|ShiftMask,		XK_b,	   spawn, {.v = brightnessupcmd } },
	{ MODKEY|ControlMask,		XK_b,	   spawn, {.v = brightnesssetcmd } },
	{ MODKEY,			XK_o,	   spawn, {.v = btconnectcmd} },
	{ MODKEY|ShiftMask,		XK_o,	   spawn, {.v = btdisconnectcmd} },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{MODKEY|ShiftMask,              XK_q,      quit,           {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

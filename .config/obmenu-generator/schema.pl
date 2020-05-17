#!/usr/bin/perl

# obmenu-generator - schema file

=for comment

    item:      add an item inside the menu               {item => ["command", "label", "icon"]},
    cat:       add a category inside the menu             {cat => ["name", "label", "icon"]},
    sep:       horizontal line separator                  {sep => undef}, {sep => "label"},
    pipe:      a pipe menu entry                         {pipe => ["command", "label", "icon"]},
    file:      include the content of an XML file        {file => "/path/to/file.xml"},
    raw:       any XML data supported by Openbox          {raw => q(xml data)},
    begin_cat: beginning of a category              {begin_cat => ["name", "icon"]},
    end_cat:   end of a category                      {end_cat => undef},
    obgenmenu: generic menu settings                {obgenmenu => ["label", "icon"]},
    exit:      default "Exit" action                     {exit => ["label", "icon"]},

=cut

# NOTE:
#    * Keys and values are case sensitive. Keep all keys lowercase.
#    * ICON can be a either a direct path to an icon or a valid icon name
#    * Category names are case insensitive. (X-XFCE and x_xfce are equivalent)

require "$ENV{HOME}/.config/obmenu-generator/config.pl";

## Text editor
my $editor = $CONFIG->{editor};
my $terminal = $CONFIG->{terminal};
my $tab_options = '@ --to unix:/tmp/mykitty new-window --new-tab';

our $SCHEMA = [

    {sep => 'Quick'},

    #          COMMAND                 LABEL              ICON
    {item => ['discord', 'Discord', 'discord']},
    {item => ['firefox', 'Firefox',  'firefox']},
    {item => ['keepassxc', 'KeepassXC',  'keepassxc']},
    {item => ['minigalaxy', 'Minigalaxy', 'io.github.sharkwouter.Minigalaxy']},
    {item => ['spotify', 'Spotify', 'spotify-client']},
    {item => ['steam', 'Steam', 'steam']},
    {item => ['teamspeak3', 'Teamspeak 3', 'teamspeak3']},
    {item => ["$terminal --listen-on unix:/tmp/mykitty", 'Terminal', 'utilities-terminal']},

    {sep => 'Categories'},

    #          NAME            LABEL                ICON
    {cat => ['utility',     'Accessories', 'applications-utilities']},
    {cat => ['development', 'Development', 'applications-development']},
    {cat => ['education',   'Education',   'applications-science']},
    {cat => ['game',        'Games',       'applications-games']},
    {cat => ['graphics',    'Graphics',    'applications-graphics']},
    {cat => ['audiovideo',  'Multimedia',  'applications-multimedia']},
    {cat => ['network',     'Network',     'applications-internet']},
    {cat => ['office',      'Office',      'applications-office']},
    {cat => ['other',       'Other',       'applications-other']},
    {cat => ['settings',    'Settings',    'systemsettings']},
    {cat => ['system',      'System',      'applications-system']},

    ## Custom advanced settings
    {sep       => undef},
    {begin_cat => ['Advanced Settings', 'applications-engineering']},

      # Configuration files
      {item => ["$terminal $tab_options $editor ~/.config/tint2/tint2rc",
                'Tint2 Panel', 'text-x-generic']},

      # obmenu-generator category
      {begin_cat => ['Obmenu-Generator', 'accessories-text-editor']},
        {item      => ["$terminal $tab_options $editor $ENV{HOME}/.config/obmenu-generator/schema.pl", 'Menu Schema', 'text-x-generic']},
        {item      => ["$terminal $tab_options $editor $ENV{HOME}/.config/obmenu-generator/config.pl", 'Menu Config', 'text-x-generic']},

        {sep  => undef},
        {item => ['obmenu-generator -s -c',    'Generate a static menu',             'accessories-text-editor']},
        {item => ['obmenu-generator -s -i -c', 'Generate a static menu with icons',  'accessories-text-editor']},
        {sep  => undef},
        {item => ['obmenu-generator -p',       'Generate a dynamic menu',            'accessories-text-editor']},
        {item => ['obmenu-generator -p -i',    'Generate a dynamic menu with icons', 'accessories-text-editor']},
        {sep  => undef},

        {item    => ['obmenu-generator -d', 'Refresh Icon Set', 'view-refresh']},
      {end_cat => undef},

      # Openbox category
      {begin_cat => ['Openbox', 'openbox']},
        {item      => ["$terminal $tab_options $editor $ENV{HOME}/.config/openbox/autostart", 'Openbox Autostart',   'text-x-generic']},
        {item      => ["$terminal $tab_options $editor $ENV{HOME}/.config/openbox/rc.xml",    'Openbox RC',          'text-x-generic']},
        {item      => ["$terminal $tab_options $editor $ENV{HOME}/.config/openbox/menu.xml",  'Openbox Menu',        'text-x-generic']},
        {item      => ['openbox --reconfigure',                                               'Reconfigure Openbox', 'openbox']},
      {end_cat => undef},
    {end_cat => undef},

    {sep => undef},

    ## This option uses the default Openbox's action "Exit"
    {exit => ['Exit Openbox', 'application-exit']},

    {sep => undef},

    ## The xscreensaver lock command
    {item => ['i3lock -c 404040', 'Lock', 'system-lock-screen']},

    ## suspend
    {item => ['systemctl suspend', 'Suspend', 'system-suspend']},

    ## shutdown
    {item => ['poweroff', 'Shutdown', 'system-shutdown']},

    ## reboot
    {item => ['reboot', 'Reboot', 'system-reboot']},

]

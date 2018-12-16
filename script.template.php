<?php

defined('_JEXEC') or die('Restricted access');

function symlinkComponent($component, $folder) {
    $target = $_SERVER['DOCUMENT_ROOT'] . "/tmp/" . $component . "/" . $folder;
    $link = $_SERVER['DOCUMENT_ROOT'] . "/" . ($folder === "admin" ? "administrator/" : "") . "components/com_" . $component;
    system("rm -rf " . $link);
    symlink($target, $link);
    if (is_link($link)) {
        echo $folder . " folder symlinked for development<br/>";
    } else {
        echo "**failed to symlink " . $folder . " folder**<br/>";
    }
}

class com_COMPONENT_NAMEInstallerScript
{
    public function postflight($type, $adapter) {
        if ($type == "install") {
            $component = str_replace("com_", "", $adapter->manifest->name);

            symlinkComponent($component, "admin");
            symlinkComponent($component, "site");

            echo $adapter->manifest->name . "installed and symlinked. Ready for development<br/>";
        }
    }
}
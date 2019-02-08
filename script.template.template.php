<?php

defined('_JEXEC') or die('Restricted access');

function symlinkTemplate($template, $folder) {
    $target = $_SERVER['DOCUMENT_ROOT'] . "/tmp/" . $template . "/" . $folder;
    $link = $_SERVER['DOCUMENT_ROOT'] . "/" . ($folder === "admin" ? "administrator/" : "") . "templates/com_" . $template;
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
            $template = str_replace("tpl_", "", $adapter->manifest->name);

            symlinkTemplate($template, "");

            echo $adapter->manifest->name . "installed and symlinked. Ready for development<br/>";
        }
    }
}
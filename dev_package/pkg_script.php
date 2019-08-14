<?php

defined('_JEXEC') or die('Restricted access');

function symlinkTemplate($template) {
    $target = $_SERVER['DOCUMENT_ROOT'] . "/tmp/dev/packages/tpl_" . $template;
    $link = $_SERVER['DOCUMENT_ROOT'] . "/templates/" . $template;
    system("rm -rf " . $link);
    symlink($target, $link);
    if (is_link($link)) {
        echo $template . " template symlinked for development<br/>";
    } else {
        echo "**failed to symlink " . $template . "**<br/>";
    }
}

function symlinkComponent($component, $folder) {
    $target = $_SERVER['DOCUMENT_ROOT'] . "/tmp/dev/packages/com_" . $component . "/" . $folder;
    $link = $_SERVER['DOCUMENT_ROOT'] . "/" . ($folder === "admin" ? "administrator/" : "") . "components/com_" . $component;
    system("rm -rf " . $link);
    symlink($target, $link);
    if (is_link($link)) {
        echo $folder . " folder symlinked for development<br/>";
    } else {
        echo "**failed to symlink " . $folder . " folder**<br/>";
    }
}

class pkg_devInstallerScript
{
    public function postflight($type, $adapter) {
        if ($type == "install") {
            $packages = scandir($_SERVER['DOCUMENT_ROOT'] . "/tmp/dev/packages");

            foreach ($packages as $package) {
                if (substr( $package, 0, 4 ) === "com_") {
                    $component = str_replace("com_", "", $package);

                    symlinkComponent($component, "admin");
                    symlinkComponent($component, "site");
                } elseif (substr( $package, 0, 4 ) === "tpl_") {
                    $template = str_replace("tpl_", "", $package);

                    symlinkTemplate($template);
                }
            }

            echo "Dev bundle installed and symlinked. Ready for development<br/>";
        }
    }
}
<?php
namespace Arcadroid\Commands;

use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

class LaunchGameCommand extends \Knp\Command\Command {

    protected function configure() {
        $this->setName("launch:game")->setDescription(
            "Lance un jeu sur recallbox.");
    }

    protected function execute(InputInterface $input, OutputInterface $output) {
        try {
            ini_set('memory_limit', '512M');
            $app = $this->getSilexApplication();
            $msg = "Lancement du jeu sur recallbox";
            $app['monolog.game']->addInfo($msg);
            $output->writeln($msg);
        } catch (\Exception $ex) {
            $app['monolog.game']->addError($ex->getMessage());
            $output->writeln("Une erreur s'est produite : " . $ex->getMessage());
        }
    }
}
#include "Ogre.h"
#include "OgreSceneManager.h"
#include "OgreApplicationContext.h"
#include <OgreCamera.h>
#include <OgreInput.h>
#include <OgreMath.h>
#include <OgreNode.h>
#include <OgrePrerequisites.h>
#include <OgreQuaternion.h>
#include <iostream>
#include "helpers.hpp"

class KeyHandler : public OgreBites::InputListener
{
    bool keyPressed(const OgreBites::KeyboardEvent& evt) override
    {
        if (evt.keysym.sym == OgreBites::SDLK_ESCAPE)
        {
            Ogre::Root::getSingleton().queueEndRendering();
        }
        return true;
    }
};

int main(void) {
    OgreBites::ApplicationContext ctx("OgreTutorialApp");
    ctx.initApp();

    Ogre::Root* root = ctx.getRoot();
    Ogre::SceneManager* scnMgr = root->createSceneManager();

    Ogre::RTShader::ShaderGenerator* shadergen = Ogre::RTShader::ShaderGenerator::getSingletonPtr();
    shadergen->addSceneManager(scnMgr);

    Ogre::Light* light = scnMgr->createLight("MainLight");
    Ogre::SceneNode* lightNode = scnMgr->getRootSceneNode()->createChildSceneNode();
    lightNode->setPosition(0, 10, 15);
    lightNode->attachObject(light);

    // also need to tell where we are
    Ogre::SceneNode* camNode = scnMgr->getRootSceneNode()->createChildSceneNode();
    camNode->setPosition(8, 8, 8);
    camNode->lookAt(Ogre::Vector3(-1, -1, -1), Ogre::Node::TS_LOCAL);
    //camNode->setDirection(Ogre::Vector3(-1, -1, -1));
    camNode->roll(Ogre::Degree(0));

    Ogre::Vector3 cameraPosition = camNode->getPosition();
    Ogre::Vector3 directionToTarget = Ogre::Vector3() - cameraPosition;
    camNode->setFixedYawAxis(true);
    camNode->lookAt(Ogre::Vector3(0, 0, 0), Ogre::Node::TransformSpace::TS_WORLD);

    auto up = Ogre::Vector3(0,0,0);
    auto dir = Ogre::Vector3(-1,-1,-1);
    Ogre::Vector3 right = dir.crossProduct(up);
    Ogre::Quaternion quat;
    quat.FromAxes(right, up, dir);
    //camNode->setOrientation(quat);


    // create the camera
    Ogre::Camera* cam = scnMgr->createCamera("myCam");
    cam->setNearClipDistance(5); // specific to this sample
    cam->setAutoAspectRatio(true);
    camNode->attachObject(cam);
    //camNode->lookAt(Ogre::Vector3(0,0,0), Ogre::Node::TransformSpace::TS_PARENT, Ogre::Vector3f::NEGATIVE_UNIT_Z);

    // and tell it to render into the main window
    ctx.getRenderWindow()->addViewport(cam);

    // finally something to render
    Krogre::makeMesh("cube.obj", "cube");
    Ogre::Entity* ent = scnMgr->createEntity("cube");
    Ogre::SceneNode* node = scnMgr->getRootSceneNode()->createChildSceneNode();
    node->attachObject(ent);
    node->setPosition(0,0,0);

    KeyHandler keyHandler;
    ctx.addInputListener(&keyHandler);
 
    ctx.getRoot()->startRendering();
    ctx.closeApp();

    return 0; 
}
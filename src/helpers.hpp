#include <Ogre.h>
#include "modelLoader.hpp"

namespace Krogre {
    Ogre::ManualObject* createCubeMesh (Ogre::String name, Ogre::String matName);
    void makeMesh(Ogre::String meshFile, Ogre::String meshName);
};
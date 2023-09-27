local ffi = require("ffi")
ffi.cdef[[
    // std::string::string(char*)
    struct string _ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1IS3_EEPKcRKS3_(char*);
    // std::string::data()
    char* _ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4dataEv(struct string*);
    // OgreBites::ApplicationContext::ApplicationContext(std::string*)
    struct OgreBitesApplicationContext _ZN9OgreBites22ApplicationContextBaseC2ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE(struct string*);
    // OgreBites::ApplicationContext::initApp
    void _ZN9OgreBites22ApplicationContextBase7initAppEv(struct OgreBitesApplicationContext*);
    // OgreBites::ApplicationContext::getRoot
    struct OgreRoot* _Z7getRootPN9OgreBites21ApplicationContextSDLE(struct OgreBitesApplicationContext*);
    // Ogre::Root::createSceneManager(std::string type)
    struct OgreSceneManager* _ZN4Ogre4Root18createSceneManagerERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEES8_(struct OgreRoot*, struct string*, struct string*);
    // SMT_DEFAULT
    struct string _ZN4Ogre11SMT_DEFAULTB5cxx11E;
    // Ogre::RTShader::ShaderGenerator::getSingletonPtr()
    struct OgreRTShaderShaderGenerator* _ZN4Ogre8RTShader15ShaderGenerator15getSingletonPtrEv();
    // Ogre::RTShader::ShaderGenerator::addSceneManager(Ogre::SceneManager*)
    void _ZN4Ogre8RTShader15ShaderGenerator15addSceneManagerEPNS_12SceneManagerE(struct OgreRTShaderShaderGenerator*, struct OgreSceneManager*);
    // Ogre::SceneManager::createLight(std::string)
    struct OgreLight* _ZN4Ogre12SceneManager11createLightERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE(struct OgreSceneManager*, struct string*);
    // Ogre::SceneManager::getRootSceneNode()
    struct OgreSceneNode* _ZN4Ogre12SceneManager16getRootSceneNodeEv(struct OgreSceneManager*);
    // Ogre::SceneNode::attachObject(Ogre::MovableObject*)
    void _Z12attachObjectPN4Ogre9SceneNodeEPNS_13MovableObjectE(struct OgreSceneNode*, struct OgreMovableObject*);

    struct OVector3 {
        void* loloolol;
        float data[3];
    };

    struct OQuat {
        void* lolololol;
        float data[4];
    };

    struct OVector3 _Z13createVector3fff(float,float,float);
    struct OQuat _Z16createQuaternionffff(float,float,float,float);

    // Ogre::SceneNode::createChildSceneNode()
    struct OgreSceneNode* _ZN4Ogre9SceneNode20createChildSceneNodeERKNS_6VectorILi3EfEERKNS_10QuaternionE(struct OgreSceneNode*, struct OVector3*, struct OQuat*);
    // Ogre::SceneNode::setPosition(OVector3*)
    void _ZN4Ogre4Node11setPositionERKNS_6VectorILi3EfEE(struct OgreSceneNode*, struct OVector3*);
    // Ogre::SceneNode::lookAt(OVector3*, OgreNodeTransformSpace, OVector3*)
    void _ZN4Ogre9SceneNode6lookAtERKNS_6VectorILi3EfEENS_4Node14TransformSpaceES4_(struct OgreSceneNode*, struct OVector3*, struct OgreNodeTransformSpace, struct OVector3*);
]]

local krogre = ffi.load("./libKrogre.so")

function OQuat(...)
    return krogre._Z16createQuaternionffff(...)
end

function OVector3(...)
    return krogre._Z13createVector3fff(...)
end

function MakeCXXString(luaStr)
    return krogre._ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1IS3_EEPKcRKS3_(
        ffi.new("char[" .. (#luaStr + 1) .. "]", luaStr)
    )
end

function ReadCXXString(cxxStr)
    return ffi.string(krogre._ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4dataEv(cxxStr))
end

local Ogre = {}
local OgreBites = {}
local SceneManagerT = {
    SMT_DEFAULT = krogre._ZN4Ogre11SMT_DEFAULTB5cxx11E
}
local RTShader = {}

function RTShader.getSingletonPtr()
    return krogre._ZN4Ogre8RTShader15ShaderGenerator15getSingletonPtrEv();
end

function RTShader.addSceneManager(shaderGen, sceneManager)
    krogre._ZN4Ogre8RTShader15ShaderGenerator15addSceneManagerEPNS_12SceneManagerE(shaderGen, sceneManager)
end

function OgreBites.newAppContext(appName)
    local cxxStr = MakeCXXString(appName)
    local appContext = krogre._ZN9OgreBites22ApplicationContextBaseC2ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE(cxxStr)
    return appContext
end

function OgreBites.getRoot(appCtx)
    return krogre._Z7getRootPN9OgreBites21ApplicationContextSDLE(appCtx)
end

function OgreBites.initApp(appCtx)
    krogre._ZN9OgreBites22ApplicationContextBase7initAppEv(appCtx)
end

function OgreBites.createSceneManager(root)
    return krogre._ZN4Ogre4Root18createSceneManagerERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEES8_(root, SceneManagerT.SMT_DEFAULT, MakeCXXString(""))
end

function Ogre.createLightCXX(sceneManager, cxxName)
    return krogre._ZN4Ogre12SceneManager11createLightERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE(sceneManager, cxxName)
end

function Ogre.createLight(sceneManager, name)
    return Ogre.createLightCXX(sceneManager, MakeCXXString(name))
end

function getRootSceneNode(sceneManager)
    return krogre._ZN4Ogre12SceneManager16getRootSceneNodeEv(sceneManager)
end

local Node = {}

function Node.setPos(node, pos)
    krogre._ZN4Ogre4Node11setPositionERKNS_6VectorILi3EfEE(node, pos)
end

function Node.createChild(rootNode, v, q)
    return krogre._ZN4Ogre9SceneNode20createChildSceneNodeERKNS_6VectorILi3EfEERKNS_10QuaternionE(rootNode, v, q)
end

local OGRE_MOVABLE_OBJECT_TYPE = ffi.typeof("struct OgreMovableObject*")
function Node.attachObject(sceneNode, object)
    krogre._Z12attachObjectPN4Ogre9SceneNodeEPNS_13MovableObjectE(sceneNode, ffi.cast(OGRE_MOVABLE_OBJECT_TYPE, object))
end

local testStr = "Test thing lolo;p;l;l;l;"
local cxxString = MakeCXXString(testStr)
local backToNormalYay = ReadCXXString(cxxString)

local appCtx = OgreBites.newAppContext("TestApp")
OgreBites.initApp(appCtx)
local root = OgreBites.getRoot(appCtx)
local sm = OgreBites.createSceneManager(root)

local shaderGenerator = RTShader.getSingletonPtr()

RTShader.addSceneManager(shaderGenerator, sm)

local rootNode = getRootSceneNode(sm)

local light = Ogre.createLight(sm, "mainLight")
local lightNode = Node.createChild(rootNode, OVector3(0,0,0), OQuat(1,0,0,0))
Node.attachObject(lightNode, light)

local camNode = Node.createChild(rootNode, OVector3(0,0,0), OQuat(1,0,0,0))
Node.setPos(camNode, OVector3(8,8,8))
Node.setPos(lightNode, OVector3(0,10,15))
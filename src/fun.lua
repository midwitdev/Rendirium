local ffi = require("ffi")
ffi.cdef[[

    struct string {
        char array[24];
    };

    // SMT_DEFAULT
    struct string _ZN4Ogre11SMT_DEFAULTB5cxx11E;

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
    // OgreBites::ApplicationContext::closeApp
    void _ZN9OgreBites22ApplicationContextBase8closeAppEv(struct OgreBitesApplicationContext*);
    // OgreBites::ApplicationContext::addInputListener
    void _Z16addInputListenerPN9OgreBites21ApplicationContextSDLEPNS_13InputListenerE(struct OgreBitesApplicationContext*, struct OgreBitesInputListener*);

    // Ogre::Root::startRendering
    void _ZN4Ogre4Root14startRenderingEv(struct OgreRoot*);

    // OgreBites::ApplicationContext::getRenderWindow()
    struct OgreRenderWindow* _ZNK9OgreBites22ApplicationContextBase15getRenderWindowEv(struct OgreBitesApplicationContext*);

    // Ogre::RenderTarget::addViewport(Ogre::Camera*, int, float, float, float, float)
    struct OgreViewport* _ZN4Ogre12RenderTarget11addViewportEPNS_6CameraEiffff(struct OgreRenderWindow*, struct OgreCamera*, int, float, float, float, float);

    // Ogre::Root::createSceneManager(std::string type)
    struct OgreSceneManager* _ZN4Ogre4Root18createSceneManagerERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEES8_(struct OgreRoot*, struct string*, struct string*);

    // Ogre::RTShader::ShaderGenerator::getSingletonPtr()
    struct OgreRTShaderShaderGenerator* _ZN4Ogre8RTShader15ShaderGenerator15getSingletonPtrEv();
    // Ogre::RTShader::ShaderGenerator::addSceneManager(Ogre::SceneManager*)
    void _ZN4Ogre8RTShader15ShaderGenerator15addSceneManagerEPNS_12SceneManagerE(struct OgreRTShaderShaderGenerator*, struct OgreSceneManager*);

    // Ogre::SceneManager::createLight(std::string)
    struct OgreLight* _ZN4Ogre12SceneManager11createLightERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE(struct OgreSceneManager*, struct string*);
    // Ogre::SceneManager::getRootSceneNode()
    struct OgreSceneNode* _ZN4Ogre12SceneManager16getRootSceneNodeEv(struct OgreSceneManager*);
    // Ogre::SceneManager::createCamera(std::string*)
    struct OgreCamera* _ZN4Ogre12SceneManager12createCameraERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE(struct OgreSceneManager*, struct string*);
    // Ogre::SceneManager::createEntity(std::string*)
    struct OgreEntity* _Z12createEntityPN4Ogre12SceneManagerERNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE(struct OgreSceneManager*, struct string*);

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

    // Ogre::SceneNode::attachObject(Ogre::MovableObject*)
    void _Z12attachObjectPN4Ogre9SceneNodeEPNS_13MovableObjectE(struct OgreSceneNode*, struct OgreMovableObject*);
    // Ogre::SceneNode::createChildSceneNode()
    struct OgreSceneNode* _ZN4Ogre9SceneNode20createChildSceneNodeERKNS_6VectorILi3EfEERKNS_10QuaternionE(struct OgreSceneNode*, struct OVector3*, struct OQuat*);
    // Ogre::SceneNode::setPosition(OVector3*)
    void _ZN4Ogre4Node11setPositionERKNS_6VectorILi3EfEE(struct OgreSceneNode*, struct OVector3*);
    // Ogre::SceneNode::lookAt(OVector3*, OgreNodeTransformSpace, OVector3*)
    void _ZN4Ogre9SceneNode6lookAtERKNS_6VectorILi3EfEENS_4Node14TransformSpaceES4_(struct OgreSceneNode*, struct OVector3*, int, struct OVector3*);
    // Ogre::Camera::setNearClipDistance(float)
    void _ZN4Ogre7Frustum19setNearClipDistanceEf(struct OgreCamera*, float);
    // Ogre::Camera::setAutoAspectRatio(bool)
    void _ZN4Ogre6Camera18setAutoAspectRatioEb(struct OgreCamera*, bool);

    // Krogre::makeMesh(std::string, std::string)
    void _ZN6Krogre8makeMeshERNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEES6_(struct string*, struct string*);

    // createKeyHandler
    struct OgreBitesInputListener _Z16createKeyHandlerv();
]]

local krogre = ffi.load("./libKrogre.so")

createKeyHandler = krogre._Z16createKeyHandlerv;

function OQuat(...)
    return krogre._Z16createQuaternionffff(...)
end

function OVector3(...)
    return krogre._Z13createVector3fff(...)
end

function MakeCXXString(luaStr)
    return krogre._ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1IS3_EEPKcRKS3_(
        ffi.new("char[" .. (#luaStr + 1) .. "]", luaStr.."\0")
    )
end

function ReadCXXString(cxxStr)
    return ffi.string(krogre._ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4dataEv(cxxStr))
end

local Ogre = {}
local OgreBites = {}
local AppCtx = {}
local RenderTarget = {}

local Camera = {}

function Camera.setNearClipDistance(cam, d)
    krogre._ZN4Ogre7Frustum19setNearClipDistanceEf(cam, d)
end

function Camera.setAutoAspectRatio(cam, enabled)
    krogre._ZN4Ogre6Camera18setAutoAspectRatioEb(cam, enabled)
end

local SceneManagerT = {
    SMT_DEFAULT = krogre._ZN4Ogre11SMT_DEFAULTB5cxx11E
}
local RTShader = {}

local OgreTransformSpace =
{
    LOCAL = 0,
    PARENT = 1,
    WORLD = 2,
}

function RTShader.getSingletonPtr()
    return krogre._ZN4Ogre8RTShader15ShaderGenerator15getSingletonPtrEv();
end

function RTShader.addSceneManager(shaderGen, sceneManager)
    krogre._ZN4Ogre8RTShader15ShaderGenerator15addSceneManagerEPNS_12SceneManagerE(shaderGen, sceneManager)
end

function AppCtx.newCtx(appName)
    local cxxStr = MakeCXXString(appName)
    local appContext = krogre._ZN9OgreBites22ApplicationContextBaseC2ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE(cxxStr)
    return appContext
end

function AppCtx.getRenderWindow(appCtx)
    return krogre._ZNK9OgreBites22ApplicationContextBase15getRenderWindowEv(appCtx)
end
--[[
virtual Viewport* addViewport(Camera* cam, int ZOrder = 0, float left = 0.0f, float top = 0.0f ,
            float width = 1.0f, float height = 1.0f);
]]
function RenderTarget.addViewport(renderWindow, camera, ZOrder, left, top, width, height)
    local left = left or 0.0
    local top = top or 0.0
    local width = width or 1.0
    local height = height or 1.0
    local ZOrder = ZOrder or 0

    krogre._ZN4Ogre12RenderTarget11addViewportEPNS_6CameraEiffff(renderWindow, camera, ZOrder, left, top, width, height)
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

function createCamera(sm, name)
    return krogre._ZN4Ogre12SceneManager12createCameraERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE(sm, name)
end

function createEntity(sm, name)
    return krogre._Z12createEntityPN4Ogre12SceneManagerERNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE(sm, name)
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

function Node.lookAt(node, pos, space, relativeToVec)
    krogre._ZN4Ogre9SceneNode6lookAtERKNS_6VectorILi3EfEENS_4Node14TransformSpaceES4_(node, pos, space, relativeToVec)
end

local OGRE_MOVABLE_OBJECT_TYPE = ffi.typeof("struct OgreMovableObject*")
function Node.attachObject(sceneNode, object)
    krogre._Z12attachObjectPN4Ogre9SceneNodeEPNS_13MovableObjectE(sceneNode, ffi.cast(OGRE_MOVABLE_OBJECT_TYPE, object))
end

function makeMeshCXX(CXXpath, CXXname)
    krogre._ZN6Krogre8makeMeshERNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEES6_(CXXpath, CXXname)
end

function makeMesh(path, name)
    return makeMeshCXX(MakeCXXString(path), MakeCXXString(name))
end

local testStr = "Test thing lolo;p;l;l;l;"
local cxxString = MakeCXXString(testStr)
local backToNormalYay = ReadCXXString(cxxString)

local appCtx = AppCtx.newCtx("TestApp")
OgreBites.initApp(appCtx)
local root = OgreBites.getRoot(appCtx)
local sm = OgreBites.createSceneManager(root)

local shaderGenerator = RTShader.getSingletonPtr()

print(1)
RTShader.addSceneManager(shaderGenerator, sm)
print(2)
local rootNode = getRootSceneNode(sm)
print(3)

local light = Ogre.createLight(sm, "mainLight")
local lightNode = Node.createChild(rootNode, OVector3(0,0,0), OQuat(1,0,0,0))
Node.attachObject(lightNode, light)

print(4)

local camNode = Node.createChild(rootNode, OVector3(0,0,0), OQuat(1,0,0,0))
Node.setPos(camNode, OVector3(8,8,8))
Node.lookAt(camNode, OVector3(0,0,0), OgreTransformSpace.PARENT, OVector3(0,0,-1))

print(5)

local camera = createCamera(sm, MakeCXXString("mainCam"))
Node.attachObject(camNode, camera)

print(6)

Camera.setNearClipDistance(camera, 5)
Camera.setAutoAspectRatio(camera, true)

print(7)

Node.setPos(lightNode, OVector3(0,10,15))

local renderWindow = AppCtx.getRenderWindow(appCtx)
RenderTarget.addViewport(renderWindow, camera)

print(8)

local cxxName = MakeCXXString("cube")
local cxxPath = MakeCXXString("resources/cube.obj")
print(8.5)
--makeMesh(cxxPath, cxxName)
print(8.75)
--local ent = createEntity(sm, MakeCXXString("cube"))
print(9)

local handler = createKeyHandler()
print(10)

krogre._Z16addInputListenerPN9OgreBites21ApplicationContextSDLEPNS_13InputListenerE(appCtx, handler)
print(10.5)
krogre._ZN4Ogre4Root14startRenderingEv(root)
print(11)
krogre._ZN9OgreBites22ApplicationContextBase8closeAppEv(appCtx)
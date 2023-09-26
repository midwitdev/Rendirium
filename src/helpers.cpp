#include "./helpers.hpp"
#include <iostream>

namespace Krogre {

    void makeMesh(Ogre::String meshFile, Ogre::String meshName)
    {
        Ogre::MeshPtr Mesh = Ogre::MeshManager::getSingleton().createManual(meshName, Ogre::ResourceGroupManager::DEFAULT_RESOURCE_GROUP_NAME);
        Ogre::SubMesh *subMesh = Mesh->createSubMesh("subMesh");
        Ogre::VertexDeclaration *vertexDeclaration;
        Ogre::HardwareVertexBufferSharedPtr vertexBuffer;
        Ogre::HardwareIndexBufferSharedPtr indexBuffer;
        std::stringstream stringBuffer;
        size_t offset = 0;
        /*
        // Get file name and extension from the Ogre Resource Manager
        Ogre::FileInfoListPtr fileInfoListPtr(Ogre::ResourceGroupManager::getSingleton().findResourceFileInfo(Ogre::ResourceGroupManager::DEFAULT_RESOURCE_GROUP_NAME, meshFile, false));
        Ogre::FileInfoList *fileInfoList = fileInfoListPtr.get();
        Ogre::FileInfo &fileInfo = fileInfoList->front();
        stringBuffer << fileInfo.archive->getName().c_str() << meshFile;
        */

        // ************** From Assimp code ***************************
        ModelManager manager;

        manager.loadModel(meshFile);
        std::vector<float> *vData = manager.getVertexData();
        std::vector<uint16_t> *iData = manager.getIndexData();
        // ********************************************************************

        Mesh->sharedVertexData = new Ogre::VertexData;

        // Organizo la memoria de video
        vertexDeclaration = Mesh->sharedVertexData->vertexDeclaration;
        vertexDeclaration->addElement(0, offset, Ogre::VET_FLOAT3, Ogre::VES_POSITION);
        offset += Ogre::VertexElement::getTypeSize(Ogre::VET_FLOAT3);

        vertexDeclaration->addElement(0, offset, Ogre::VET_FLOAT3, Ogre::VES_NORMAL);
        offset += Ogre::VertexElement::getTypeSize(Ogre::VET_FLOAT3);

        vertexDeclaration->addElement(0, offset, Ogre::VET_FLOAT2, Ogre::VES_TEXTURE_COORDINATES);
        offset += Ogre::VertexElement::getTypeSize(Ogre::VET_FLOAT2);

        // Make vertex buffer
        vertexBuffer = Ogre::HardwareBufferManager::getSingleton().createVertexBuffer(vertexDeclaration->getVertexSize(0),
        vData->size() / 8,
        Ogre::HardwareBuffer::HBU_STATIC);

        // Write the vertex buffer with the target data of vData->data() located in assimp code
        vertexBuffer.get()->writeData(0, vertexBuffer.get()->getSizeInBytes(), vData->data());

        // Make index buffer
        indexBuffer = Ogre::HardwareBufferManager::getSingleton().createIndexBuffer(Ogre::HardwareIndexBuffer::IT_16BIT,
        iData->size(),
        Ogre::HardwareBuffer::HBU_STATIC);

        indexBuffer.get()->writeData(0, indexBuffer.get()->getSizeInBytes(), iData->data());

        Mesh->sharedVertexData->vertexBufferBinding->setBinding(0, vertexBuffer);
        Mesh->sharedVertexData->vertexCount = vertexBuffer.get()->getNumVertices();
        Mesh->sharedVertexData->vertexStart = 0;

        subMesh->useSharedVertices = true;
        subMesh->indexData->indexBuffer = indexBuffer;
        subMesh->indexData->indexCount = indexBuffer.get()->getNumIndexes();
        subMesh->indexData->indexStart = 0;
        //if (manager.hasmaterial()) {
        // oSceneManager->getEntity(entityName)->setMaterialName(manager.material_name());
        // } 
        // I don't get real AABB from object, this is ok for probe
        Mesh->_setBounds(Ogre::AxisAlignedBox(-400, -400, -400, 400, 400, 400));
        Mesh->load();

        std::cout << "total vertices: " << vData->size() / 8 << "\n";
        std::cout << "total faces: " << indexBuffer.get()->getNumIndexes() / 3 << "\n";
    } 

    Ogre::ManualObject* createCubeMesh (Ogre::String name, Ogre::String matName) 
    {
        Ogre::ManualObject* cube = new Ogre::ManualObject(name);
        cube->begin(matName);
        
        cube->position(0.5f,-0.5f,1.0f);cube->normal(0.408248f,-0.816497f,0.408248f);cube->textureCoord(1,0);
        cube->position(-0.5f,-0.5f,0.0f);cube->normal(-0.408248f,-0.816497f,-0.408248f);cube->textureCoord(0,1);
        cube->position(0.5f,-0.5f,0.0f);cube->normal(0.666667f,-0.333333f,-0.666667f);cube->textureCoord(1,1);
        cube->position(-0.5f,-0.5f,1.0f);cube->normal(-0.666667f,-0.333333f,0.666667f);cube->textureCoord(0,0);
        cube->position(0.5f,0.5f,1.0f);cube->normal(0.666667f,0.333333f,0.666667f);cube->textureCoord(1,0);
        cube->position(-0.5,-0.5,1.0);cube->normal(-0.666667f,-0.333333f,0.666667f);cube->textureCoord(0,1);
        cube->position(0.5,-0.5,1.0);cube->normal(0.408248,-0.816497,0.408248f);cube->textureCoord(1,1);
        cube->position(-0.5,0.5,1.0);cube->normal(-0.408248,0.816497,0.408248);cube->textureCoord(0,0);
        cube->position(-0.5,0.5,0.0);cube->normal(-0.666667,0.333333,-0.666667);cube->textureCoord(0,1);
        cube->position(-0.5,-0.5,0.0);cube->normal(-0.408248,-0.816497,-0.408248);cube->textureCoord(1,1);
        cube->position(-0.5,-0.5,1.0);cube->normal(-0.666667,-0.333333,0.666667);cube->textureCoord(1,0);
        cube->position(0.5,-0.5,0.0);cube->normal(0.666667,-0.333333,-0.666667);cube->textureCoord(0,1);
        cube->position(0.5,0.5,0.0);cube->normal(0.408248,0.816497,-0.408248);cube->textureCoord(1,1);
        cube->position(0.5,-0.5,1.0);cube->normal(0.408248,-0.816497,0.408248);cube->textureCoord(0,0);
        cube->position(0.5,-0.5,0.0);cube->normal(0.666667,-0.333333,-0.666667);cube->textureCoord(1,0);
        cube->position(-0.5,-0.5,0.0);cube->normal(-0.408248,-0.816497,-0.408248);cube->textureCoord(0,0);
        cube->position(-0.5,0.5,1.0);cube->normal(-0.408248,0.816497,0.408248);cube->textureCoord(1,0);
        cube->position(0.5,0.5,0.0);cube->normal(0.408248,0.816497,-0.408248);cube->textureCoord(0,1);
        cube->position(-0.5,0.5,0.0);cube->normal(-0.666667,0.333333,-0.666667);cube->textureCoord(1,1);
        cube->position(0.5,0.5,1.0);cube->normal(0.666667,0.333333,0.666667);cube->textureCoord(0,0);
        
        cube->triangle(0,1,2);      cube->triangle(3,1,0);
        cube->triangle(4,5,6);      cube->triangle(4,7,5);
        cube->triangle(8,9,10);      cube->triangle(10,7,8);
        cube->triangle(4,11,12);   cube->triangle(4,13,11);
        cube->triangle(14,8,12);   cube->triangle(14,15,8);
        cube->triangle(16,17,18);   cube->triangle(16,19,17);
        cube->end();
        
        return cube;
    }

}